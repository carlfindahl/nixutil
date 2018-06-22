#!/bin/zsh

# This files disconnects or reconnects the HDMI monitor

if [[ $# -ne 1 ]]; then
        echo "Usage: $0 [0/1 Where 0 -> Disconnect and 1 -> Connect]"
        exit 1
fi

if [[ $1 -eq 1 ]] then
        xrandr --output HDMI1 --auto
else
        xrandr --output HDMI1 --off
fi

