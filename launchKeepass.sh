#!/bin/sh

# Purpose: Launch KeePass with --verify-all to avoid random crashes

exec mono --verify-all /usr/share/keepass/KeePass.exe "$@"

