#!/bin/bash

# Title: glDocsDmenu
# Purpose: Open docs.gl for chosen gl command
# Author: Carl Findahl
# Date: 21.07.2018

helperLocation="/home/carl/usr/dev/nixUtil/"

choice=$(python ${helperLocation}glDocsCommandFetcher.py | dmenu -fn 'Roboto-9' -nb '#03142c' -nf '#a5d1da' -sb '#03142c' -sf '#dbdd3d' -p 'GL Cmd:' -b)

if [[ ! -z "${choice// /}" ]]
then
        firefox "http://docs.gl/gl4/$choice"
fi
