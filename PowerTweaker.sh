#!/bin/bash

# Made with the help of: https://wiki.archlinux.org/title/CPU_frequency_scaling
# and https://wiki.archlinux.org/title/ATI
# thank you ArchWiki :]

# TODO
# 1: Make the code smaller (mostly cpu governor part)
# 2: Make the Userspace part of the code
# 3: AMD GPU tweaking
# 4: Control fan speed (maybe)

#Colors (use ${COLOR})
CLEAR='\033[0m'
WHITE='\033[1;37m'
BLACK='\033[1;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT_GRAY='\033[1;30m'
LIGHT_RED='\033[1;31m'
LIGHT_GREEN='\033[1;32m'
LIGHT_YELLOW='\033[1;33m'
LIGHT_BLUE='\033[1;34m'
LIGHT_PURPLE='\033[1;35m'
LIGHT_CYAN='\033[0;36m'


echo -ne "${LIGHT_PURPLE}\n#### Fishy's Power Tweaker V0.1 ######\n${PURPLE}"

INITIAL_MODE=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
echo -e "# ${CYAN}Current mode: ${LIGHT_GREEN} $INITIAL_MODE"

# Print the menu
echo -e "${PURPLE}# ${LIGHT_YELLOW}1 - Performance ${PURPLE}"
echo -e "# ${LIGHT_YELLOW}2 - Powersave ${PURPLE}"
echo -e "# ${LIGHT_YELLOW}3 - ${LIGHT_GRAY}Userspace (not supported yet) ${PURPLE}"
echo -e "# ${LIGHT_YELLOW}4 - OnDemand ${PURPLE}"
echo -e "# ${LIGHT_YELLOW}5 - Conservative ${PURPLE}"
echo -e "# ${LIGHT_YELLOW}6 - Schedutil (default) ${PURPLE}"
echo -e "#"
echo -e "# ${YELLOW}0 - Exit without making any changes ${PURPLE}"
echo -en "# ${CYAN}Select 0 to 6 : ${LIGHT_GREEN}"
read -r -p "" choice
echo -en "${PURPLE}"

if [[ "$choice" == "0" ]]
then
    echo -e "# ${RED}NO CHANGES HAVE BEEN MADE${PURPLE}"
    
elif [[ "$choice" == "1" ]]
then
    echo "# Performance Mode have been selected"
    if [[ "$INITIAL_MODE" == "performance" ]]
    then
        echo -e "# ${YELLOW} Already in performance mode"
    else
        echo -e "# ${GREEN} Setting governor to performance mode"
        echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        echo -en "${LIGHT_PURPLE}# CoreSpeed: ${GREEN}"
        cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
    fi
elif [[ "$choice" == "2" ]]
then
    echo "# Powersave Mode have been selected"
    if [[ "$INITIAL_MODE" == "powersave" ]]
    then
        echo -e "# ${YELLOW} Already in powersave mode"
    else
        echo -e "# ${GREEN} Setting governor to powersave mode"
        echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        echo -en "${LIGHT_PURPLE}# CoreSpeed: ${GREEN}"
        cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
    fi
elif [[ "$choice" == "3" ]]
then
    echo -e "${RED}NOT SUPPORTED YET"
    if [[ "$INITIAL_MODE" == "userspace" ]]
    then
        echo -e "# ${YELLOW} Already in userspace mode"
    else
	echo -e "# ${RED}NOT SUPPORTED YET"
        #echo -e "# ${GREEN} Setting governor to userspace mode"
        #echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
    fi
elif [[ "$choice" == "4" ]]
then
    echo "# OnDemand Mode have been selected"
    if [[ "$INITIAL_MODE" == "ondemand" ]]
    then
        echo -e "# ${YELLOW} Already in ondemand mode"
    else
        echo -e "# ${GREEN} Setting governor to ondemand mode"
        echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
    fi
elif [[ "$choice" == "5" ]]
then
    echo "# Conservative Mode have been selected"
    if [[ "$INITIAL_MODE" == "conservative" ]]
    then
        echo -e "# ${YELLOW} Already in conservative mode"
    else
        echo -e "# ${GREEN} Setting governor to conservative mode"
        echo conservative | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
    fi
elif [[ "$choice" == "6" ]]
then
    echo "# Schedutil Mode have been selected"
    if [[ "$INITIAL_MODE" == "schedutil" ]]
    then
        echo -e "# ${YELLOW} Already in schedutil mode"
    else
        echo -e "# ${GREEN} Setting governor to schedutil mode"
        echo schedutil | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
    fi
else
    echo -e "#${RED} INVALID MODE"
fi
echo -en "${LIGHT_PURPLE}# Current mode: ${GREEN}"
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo -e "${LIGHT_PURPLE}#################################"
