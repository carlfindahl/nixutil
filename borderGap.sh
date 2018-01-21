#!/bin/zsh

# Utility to set gap width in bspwm

if [[ $# -ne 1 ]]; then
        echo "Usage: $0 [Border-Gap]"
        exit 1
fi

bspc config window_gap $1

