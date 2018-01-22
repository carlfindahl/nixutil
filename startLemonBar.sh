#!/bin/zsh

# Carl Findahl 2018
# Utility to launch lemon bar, so I don't need the command everywhere
# Parameter $1 is the desired width ( for use with shotmode and workmode )

# Close leombar if it already runs
if [[ $(pgrep -c lemonbar) -eq 1 ]]; then
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

# Launch Bar
 ~/usr/dev/nixUtil/lemonBarFeed.sh | lemonbar -g ${width}x20+${diff}+0 -p -n LM_BAR -B '#D81D1F21' -F '#707880' -f 'Sourc    e Code Pro-9' -f 'Font Awesome' &


