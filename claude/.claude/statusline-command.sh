#!/bin/sh
input=$(cat)

user=$(whoami)
host=$(hostname -s)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // ""')
effort=$(echo "$input" | jq -r '.effort.level // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
transcript=$(echo "$input" | jq -r '.transcript_path // empty')

# Cumulative tokens billed this session, expressed in output-token equivalents:
# each class is weighted by its price relative to an output token — input 0.2,
# cache write 0.25 at 5m ttl and 0.4 at 1h, cache read 0.02. Those ratios are
# identical on opus, sonnet and haiku, so the figure is model-independent.
# One API response spans several transcript lines (one per content block) that
# each repeat the same usage object, so dedupe by requestId before summing.
# The context_window.* fields describe the latest request only, not the session.
tok_total=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  tok_total=$(jq -n '[inputs | select(.message.usage)
      | {k: (.requestId // .message.id // .uuid), u: .message.usage}]
    | unique_by(.k)
    | reduce (.[] | .u) as $u (0;
        . + ($u.output_tokens // 0)
          + ($u.input_tokens // 0) * 0.2
          + (if $u.cache_creation then
               ($u.cache_creation.ephemeral_5m_input_tokens // 0) * 0.25
               + ($u.cache_creation.ephemeral_1h_input_tokens // 0) * 0.4
             else ($u.cache_creation_input_tokens // 0) * 0.25 end)
          + ($u.cache_read_input_tokens // 0) * 0.02)
    | round | select(. > 0)' "$transcript" 2>/dev/null)
fi
five_hour_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hour_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_day_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_day_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# Shorten home directory to ~
home="$HOME"
short_cwd=$(echo "$cwd" | sed "s|^$home|~|")

# Format seconds-until-reset as a human-readable string (e.g. "2d3h45m", "1h23m", "45m")
fmt_ttl() {
  secs=$1
  if [ -z "$secs" ] || [ "$secs" -le 0 ] 2>/dev/null; then
    echo ""
    return
  fi
  d=$((secs / 86400))
  h=$(( (secs % 86400) / 3600 ))
  m=$(( (secs % 3600) / 60 ))
  if [ "$d" -gt 0 ]; then
    printf "%dd%dh%02dm" "$d" "$h" "$m"
  elif [ "$h" -gt 0 ]; then
    printf "%dh%02dm" "$h" "$m"
  else
    printf "%dm" "$m"
  fi
}

# Format a token count compactly (e.g. "950", "93.5k", "1.2M")
fmt_tokens() {
  n=$1
  if [ "$n" -lt 1000 ]; then
    printf "%d" "$n"
  elif [ "$n" -lt 1000000 ]; then
    printf "%d.%dk" "$((n / 1000))" "$(((n % 1000) / 100))"
  else
    printf "%d.%dM" "$((n / 1000000))" "$(((n % 1000000) / 100000))"
  fi
}

now=$(date +%s)

# Build session usage info (cumulative tokens + cost for this session)
usage=""
if [ -n "$tok_total" ] || [ -n "$cost" ]; then
  parts=""
  [ -n "$tok_total" ] && parts=$(fmt_tokens "$tok_total")
  if [ -n "$cost" ]; then
    c=$(printf '$%.2f' "$cost")
    [ -n "$parts" ] && parts="$parts $c" || parts="$c"
  fi
  usage=" [$parts]"
fi

# Build context info
ctx=""
if [ -n "$used" ]; then
  ctx=" [ctx:$(printf '%.0f' "$used")%]"
fi

# Build model info
mdl=""
if [ -n "$model" ]; then
  if [ -n "$effort" ]; then
    mdl=" ($model, $effort)"
  else
    mdl=" ($model)"
  fi
fi

# Build rate limit info
limits=""
limits7=""
if [ -n "$five_hour_pct" ]; then
  ttl=""
  if [ -n "$five_hour_reset" ]; then
    secs_left=$((five_hour_reset - now))
    ttl=$(fmt_ttl "$secs_left")
  fi
  if [ -n "$ttl" ]; then
    limits=" [$(printf '%.0f' "$five_hour_pct")% ${ttl}]"
  else
    limits=" [$(printf '%.0f' "$five_hour_pct")%]"
  fi
fi
if [ -n "$seven_day_pct" ]; then
  ttl=""
  if [ -n "$seven_day_reset" ]; then
    secs_left=$((seven_day_reset - now))
    ttl=$(fmt_ttl "$secs_left")
  fi
  if [ -n "$ttl" ]; then
    limits7=" [$(printf '%.0f' "$seven_day_pct")% ${ttl}]"
  else
    limits7=" [$(printf '%.0f' "$seven_day_pct")%]"
  fi
fi

printf "\033[32m%s@%s\033[0m \033[34m%s\033[0m\033[33m%s\033[0m\033[36m%s\033[0m\033[2;36m%s\033[0m\033[35m%s\033[0m\033[2;35m%s\033[0m" \
  "$user" "$host" "$short_cwd" "$mdl" "$ctx" "$usage" "$limits" "$limits7"
