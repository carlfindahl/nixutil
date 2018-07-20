#!/bin/zsh

# Source: http://akuederle.com/awesome-dmenu

declare -A gitdic
dirlist=()

# Locate Git Repos
while IFS= read -d $'\0' -r file ; do
        dir=$(basename "$(dirname "$file")")
        gitdic["$dir"]="$(dirname "$file")"
        dirlist+="$dir\n"

done < <(find ~ -type d -name .git -print0)

# Get Choice of Repository
choice=$(echo -e "$dirlist" | dmenu)

# Open Terminal In Repo
termite -d ${gitdic["$choice"]}

