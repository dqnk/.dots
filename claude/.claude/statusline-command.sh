#!/bin/sh
input=$(cat)

user=$(whoami)
host=$(hostname -s)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
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

now=$(date +%s)

# Build context info
ctx=""
if [ -n "$used" ]; then
  ctx=" [ctx:$(printf '%.0f' "$used")%]"
fi

# Build model info
mdl=""
if [ -n "$model" ]; then
  mdl=" ($model)"
fi

# Build rate limit info
limits=""
if [ -n "$five_hour_pct" ]; then
  ttl=""
  if [ -n "$five_hour_reset" ]; then
    secs_left=$((five_hour_reset - now))
    ttl=$(fmt_ttl "$secs_left")
  fi
  if [ -n "$ttl" ]; then
    limits=" [5h:$(printf '%.0f' "$five_hour_pct")% rst:${ttl}]"
  else
    limits=" [5h:$(printf '%.0f' "$five_hour_pct")%]"
  fi
fi
if [ -n "$seven_day_pct" ]; then
  ttl=""
  if [ -n "$seven_day_reset" ]; then
    secs_left=$((seven_day_reset - now))
    ttl=$(fmt_ttl "$secs_left")
  fi
  if [ -n "$ttl" ]; then
    limits="$limits [7d:$(printf '%.0f' "$seven_day_pct")% rst:${ttl}]"
  else
    limits="$limits [7d:$(printf '%.0f' "$seven_day_pct")%]"
  fi
fi

printf "\033[32m%s@%s\033[0m \033[34m%s\033[0m\033[33m%s\033[0m\033[36m%s\033[0m\033[35m%s\033[0m" \
  "$user" "$host" "$short_cwd" "$mdl" "$ctx" "$limits"
