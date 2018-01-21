#!/bin/zsh

# Utility to set border width in bspwm

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 [Border-Width]"
    exit 1
fi

bspc config border_width $1
