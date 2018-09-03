#!/bin/zsh

# Script to feed LemonBar with info
# Carl Findahl 2018

clock() {
        date '+%H:%M | %d. %b'
}

# Compute average of both batteries and show icon
battery(){
        BATAEN=$(cat /sys/class/power_supply/BAT0/energy_now)
        BATBEN=$(cat /sys/class/power_supply/BAT1/energy_now)
        BATAFL=$(cat /sys/class/power_supply/BAT0/energy_full)
        BATBFL=$(cat /sys/class/power_supply/BAT1/energy_full)

        batcur=$(expr $BATAEN + $BATBEN)
        batful=$(expr $BATAFL + $BATBFL)
        batstat=$(python -c "print(f'{($batcur / $batful) * 100:3.0f}', end='')")

        # Not working at the moment /shrug
        # batcharge=$(cat /sys/class/power_supply/BAT0/status)

        # if [[ $batcharge -eq "Discharging" ]]; then
        #         batcharge=" "
        # else
        #         batcharge="\uf0e7"
        # fi

        # echo -n "%{F#F0C674}$batcharge%{F-} "

        if [[ $batstat -gt 60 ]]; then
                echo -n "\uf240 %{F#8C9440}"
        elif [[ $batstat -gt 40 ]]; then
                echo -n "\uf241 %{F#F0C674}"
        elif [[ $batstat -gt 25 ]]; then
                echo -n "\uf243 %{F#DE935F}"
        else
                echo -n "\uf244 %{F#A54242}"
        fi

        echo -n "$batstat% %{F-}"
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
        ip link show enp0s31f6 | grep 'state UP' > /dev/null && int=enp0s31f6 || int=wlp3s0
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
                cname=$(iw dev wlp3s0 link | grep SSID | cut -c 8-)
                ipa=$(ip -o route get 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')
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

