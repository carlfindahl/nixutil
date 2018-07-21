#!/bin/bash

# Title: glDocsDmenu
# Purpose: Open docs.gl for chosen gl command
# Author: Carl Findahl
# Date: 21.07.2018

helperLocation="/home/carl/usr/dev/nixUtil/"

choice=$(python ${helperLocation}glDocsCommandFetcher.py | dmenu -fn 'Roboto-9' -nb '#1d1f21' -nf '#c5c8c6' -sb '#538d87' -sf '#c5c8c6' -p '>' -b)

if [[ ! -z "${choice// /}" ]]
then
        firefox "http://docs.gl/gl4/$choice"
fi
