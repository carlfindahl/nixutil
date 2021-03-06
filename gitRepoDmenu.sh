#!/bin/bash

#title           : git_jumper
#description     : A simple dmenu call to navigate your git repos 
#author		 : Arne Küderle, modified by Carl Findahl
#date            : 201502
#notes           : Install dmenu to use this script. For the best experience create a hotkey

declare -A gitdic
dirlist=()
while IFS= read -d $'\0' -r file ; do
   dir=$(basename "$(dirname "$file")")
   gitdic["$dir"]="$(dirname "$file")"
   dirlist+="$dir\n"
 done < <(find ~ -type d -name .git -print0)
choice=$(echo -e "$dirlist" | dmenu -fn 'Roboto-9' -nb '#03142c' -nf '#a5d1da' -sb '#03142c' -sf '#dbdd3d' -p '>' -b)
if [ -n "$choice" ]
    then
        termite -d "${gitdic["$choice"]}"
fi

