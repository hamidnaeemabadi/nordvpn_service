#!/bin/bash
########################################################
# Author: [Hamid Naeemabadi, hamid.naeemabadi@gmail.com]
# Contributer: [Iman Kazemi talachiman@gmail.com]
# Version: 1.3
# Date: [2023/12/26 11:22]
# Purpose: [NordVPN Auto-connect on disconnection]
########################################################
# List of countries to try
countries=("Obfuscated_Servers" "Obfuscated_Servers" "Obfuscated_Servers" "Obfuscated_Servers" "Obfuscated_Servers" "Sweden" "Sweden" "Sweden" "Sweden" "United_Arab_Emirates" "United_Kingdom" "The_Americas" "The_Americas" "The_Americas" "United_States" "Germany" "Canada" "Japan" "Spain" "Netherlands" "Switzerland" "France" "Poland" "Singapore" "Hong_Kong" "Italy" "Turkey")

# Service check_interval (seconds), you need to restart the service after change this variable (sudo systemctl restart nordvpn_autoconnect)
service_check_interval=2
# Colores ###################
# End Colores
ENDCOLOR="\e[0m"
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
#############################

# Check server ip location
function check_server_ip_location {
  server_country=$(curl -s http://ip-api.com/line/"$(curl -s icanhazip.com)" | sed -n '2p')
}

# While NordVPN is disconnected
while true
do
  # Call the function
  check_server_ip_location
  if [ "$server_country" == "Iran" ]; then
    echo -e "$Blue NordVPN$ENDCOLOR is $Red disconnected$ENDCOLOR, The current ip location is: $Red$server_country$ENDCOLOR"
    # echo $server_country
    echo -e "$Yellow$(date) - Trying to reconnect...$ENDCOLOR"
    for country in "${countries[@]}"
      do
        echo -e "$Blue NordVPN$ENDCOLOR is $Red disconnected$ENDCOLOR."
        echo -e "$Yellow$(date) - Trying to reconnect...$ENDCOLOR"
        nordvpn connect $country
        # Check if the connection was successful
        check_server_ip_location
        if [ "$server_country" != "Iran" ]; then
          echo -e "$Blue NordVPN is Connected to $Green$server_country.$ENDCOLOR"
        break
        fi
      done
  fi
  sleep $service_check_interval
done