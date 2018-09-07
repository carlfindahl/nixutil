#!/bin/zsh

# Script to feed LemonBar with info
# Carl Findahl 2018

clock()
{
        date '+%H:%M | %d. %b'
}

# Compute average of both batteries and show icon
battery()
{
        bat1stat=$(< /sys/class/power_supply/BAT0/capacity)
        bat2stat=$(< /sys/class/power_supply/BAT1/capacity)
        bat1chr=$(< /sys/class/power_supply/BAT0/status)
        bat2chr=$(< /sys/class/power_supply/BAT1/status)

        case "$bat1stat" in
                [0-9]) bat1icon="\\uf244 %{F#BF2828}" ;;
                [1-3]?) bat1icon="\\uf243 %{F#BF6428}" ;;
                [4-5]?) bat1icon="\\uf242 %{F#D69F28}" ;;
                [6-7]?) bat1icon="\\uf241 %{F#DBDD3D}" ;;
                *) bat1icon="\\uf240 %{F#AEDB3D}" ;;
        esac 

        [[ "$bat1chr" == Charging ]] && bat1icon+="+"

        echo -n "$bat1icon$bat1stat% %{F-}"

        case "$bat2stat" in
                [0-9]) bat2icon="\\uf244 %{F#BF2828}" ;;
                [1-3]?) bat2icon="\\uf243 %{F#BF6428}" ;;
                [4-5]?) bat2icon="\\uf242 %{F#D69F28}" ;;
                [6-7]?) bat2icon="\\uf241 %{F#DBDD3D}" ;;
                *) bat2icon="\\uf240 %{F#AEDB3D}" ;;
        esac 

        [[ "$bat2chr" == Charging ]] && bat2icon+="+"

        echo -n " $bat2icon$bat2stat% %{F-}"
}

# Gather Volume Info
volume()
{
        volstat=$(amixer -c 1 get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p' | uniq)

        if [[ $volstat -gt 60 ]]; then
                echo -n "\uf028"
        elif [[ $volstat -gt 30 ]]; then
                echo -n "\uf027"
        else
                echo -n "\uf026"
        fi

        echo -n " $volstat%"
}

# Get Network Connection Info
network()
{
        # Gather basic info about interface and connection
        ip link show enp0s25 | grep 'state UP' > /dev/null && int=enp0s25 || int=wlp3s0
        ping -c 1 8.8.8.8 >/dev/null 2>&1 && con=true || con=false

        # Print Interface information
        if [[ $int -eq wlp3s0 ]]; then
                echo -n "\uf1eb "
        else
                echo -n "\uf1e6"
        fi

        # Print IP and Connection Info
        if [[ con -eq true ]]; then
                echo -n "%{F#DBDD3D}"
                cname=$(nmcli device show $int | grep GENERAL.CONNECTION | cut -c 41-)
                ipa=$(nmcli device show $int | grep IP4.ADDRESS | cut -c 41-)
                echo -n $cname
                echo -n " $ipa"
                echo -n "%{F-}"
        fi
}

# Main Loop
while [[ true ]]; do
        BAR_INPUT="%{l}  $(battery) %{c}%{F#C5C8C6}$(clock) %{r}%{F-}$(network)    $(volume)  "
        echo -e $BAR_INPUT
        sleep 2
done

