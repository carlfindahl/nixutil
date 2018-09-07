#!/bin/zsh

# Carl Findahl 2018
# Utility to launch lemon bar, so I don't need the command everywhere
# Parameter $1 is the desired width ( for use with shotmode and workmode )

# Close leombar if it already runs
if [[ $(pgrep -c lemonbar) -gt 0 ]]; then
        pkill lemonbar
fi

# If parameter $1 then use that, otherwise use default
width=1880

if [[ $# -eq 1 ]]; then
        width=$1
fi

# Get the offset from left to center bar
diff=$(expr 1920 - $width)
diff=$(expr $diff / 2)

# Source wal colors
. "${HOME}/.cache/wal/colors.sh"

# Launch Bar
 ~/usr/dev/nixutil/lemonBarFeed.sh | lemonbar -g ${width}x20+${diff}+0 -p -n LM_BAR -B "$color0" -F "$color8" -f 'Hack-9' -f 'FontAwesome' &

