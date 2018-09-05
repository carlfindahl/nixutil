#!/bin/sh

wpa_supplicant -B -i wlp3s0 -c /etc/wpa_supplicant.conf
dhcpcd wlp3s0

