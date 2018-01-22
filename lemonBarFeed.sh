#!/bin/zsh

# Script to feed LemonBar with info
# Carl H. Findahl 2018

clock() {
        date +%H:%M:%S
}

# Get battery 01 level
battery01(){
        cat /sys/class/power_supply/BAT0/capacity
}

# Compute battery 02 level
battery02(){
        cat /sys/class/power_supply/BAT1/capacity
}

# Compute average of both batteries and show icon
battery(){
        batstat=$(expr $(battery01) / 2 + $(battery02) / 2)

        if [[ $batstat -gt 80 ]]; then
                echo -n "\uf240 %{F#8C9440}"
        elif [[ $batstat -gt 60 ]]; then
                echo -n "\uf241 %{F#DE935F}"
        else
                echo -n "\uf243 %{F#A54242}"
        fi

        echo -n " $batstat% %{F-}"
}

# Gather Volume Info
volume(){
        volstat=$(amixer -c 1 get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p' | uniq)

        if [[ $volstat -gt 50 ]]; then
                echo -n "\uf028"
        else
                echo -n "\uf027"
        fi

        echo -n " $volstat%"
}

# Get Network Connection Info
network(){
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
                echo -n "%{F#8C9440}"
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

