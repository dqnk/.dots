#!/bin/sh
input=$(cat)

user=$(whoami)
host=$(hostname -s)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Shorten home directory to ~
home="$HOME"
short_cwd=$(echo "$cwd" | sed "s|^$home|~|")

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
if [ -n "$five_hour" ]; then
  limits=" [5h:$(printf '%.0f' "$five_hour")%]"
fi
if [ -n "$seven_day" ]; then
  limits="$limits [7d:$(printf '%.0f' "$seven_day")%]"
fi

printf "\033[32m%s@%s\033[0m \033[34m%s\033[0m\033[33m%s\033[0m\033[36m%s\033[0m\033[35m%s\033[0m" \
  "$user" "$host" "$short_cwd" "$mdl" "$ctx" "$limits"
