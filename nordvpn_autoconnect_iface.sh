#!/bin/bash
########################################################
# Author: [Hamid Naeemabadi, hamid.naeemabadi@gmail.com]
# Version: 1.1
# Date: [2023/12/26 11:22]
# Purpose: [NordVPN Auto-connect on disconnection]
########################################################
# List of countries to try
countries=("Obfuscated_Servers" "Obfuscated_Servers" "Obfuscated_Servers" "Obfuscated_Servers" "Obfuscated_Servers" "Sweden" "Sweden" "Sweden" "Sweden" "United_Arab_Emirates" "United_Kingdom" "The_Americas" "The_Americas" "The_Americas" "United_States" "Germany" "Canada" "Japan" "Spain" "Netherlands" "Switzerland" "France" "Poland" "Singapore" "Hong_Kong" "Italy" "Turkey")

# Service check_interval (seconds), you need to restart the service after change this variable (sudo systemctl restart nordvpn_autoconnect)
service_check_interval=5
# Colores ###################
# End Colores
ENDCOLOR="\e[0m"
Red='\033[0;31m'          # Red
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
#############################

# While NordVPN is disconnected
while true
do
  ifconfig | grep nordtun > /dev/null 2>&1
  if [ $? != 0 ]; then
      for country in "${countries[@]}"
      do
        echo -e "$Blue NordVPN$ENDCOLOR is $Red disconnected$ENDCOLOR."
        echo -e "$Yellow$(date) - Trying to reconnect...$ENDCOLOR"
        nordvpn connect $country
        # Check if the connection was successful
        if [ $? -eq 0 ]
        then
            echo -e "$Blue NordVPN is Connected.$ENDCOLOR"
            break
        fi
      done
  fi
  sleep $service_check_interval
done