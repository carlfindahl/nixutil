#!/bin/bash

# Title: glDocsDmenu
# Purpose: Open docs.gl for chosen gl command
# Author: Carl Findahl
# Date: 21.07.2018

choice=$(echo "VkDevice" | dmenu -fn 'Roboto-9' -nb '#1d1f21' -nf '#c5c8c6' -sb '#538d87' -sf '#c5c8c6' -p 'Enter Vulkan
Command To Look Up:' -b)

if [[ ! -z "${choice// /}" ]]
then
        firefox "https://www.khronos.org/registry/vulkan/specs/1.1-extensions/man/html/$choice.html"
fi
