#!/bin/bash

# Title: glDocsDmenu
# Purpose: Open docs.gl for chosen gl command
# Author: Carl Findahl
# Date: 21.07.2018

choice=$(python "/home/carl/usr/dev/nixutil/vkDocsCommandFetcher.py" | dmenu -fn 'Roboto-9' -nb "#03142c" -nf "#a5d1da" -sb "#03142c" -sf '#dbdd3d' -p 'Vulkan Cmd:' -b)

if [[ ! -z "${choice// /}" ]]
then
        firefox "https://www.khronos.org/registry/vulkan/specs/1.1-extensions/man/html/$choice.html"
fi
