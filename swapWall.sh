#!/bin/zsh

# Tool to swap wallpaper using feh
# and DM background image using sddm

if [[ $# -ne 1 ]]; then
        echo "USAGE: $0 [PathToImage]"
fi

feh --bg-fill $1
cp $1 /usr/share/sddm/themes/sddm_wynn-theme/background.jpg

