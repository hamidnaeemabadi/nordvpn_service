#!/bin/bash
########################################################
# Author: [Hamid Naeemabadi, hamid.naeemabadi@gmail.com]
# Version: 1.1
# Date: [2023/12/18 18:31]
# Purpose: [Find the best country of nord vpn server]
########################################################
# Initial Value
speed_test_status=0

# List of countries to try
countries=("Germany" "Finland" "Canada" "United Kingdom" "France")
 
# Define the speed threshold (Mbits/s)
speed_threshold=100

# Check speedtest cli is installed
which speedtest || (sudo apt update -qq && sudo apt install -y speedtest-cli)

# While not connected
while [ "$speed_test_status" == 0 ]
do
  # Try to connect to each country
  for country in "${countries[@]}"
  do
    # echo "Trying to connect to $country..."
    nordvpn connect $country
    # Check if the connection was successful
    if [ $? -eq 0 ]
    then
        echo "Connected to $country."
        # Current Server Country
        server_country=$(curl -s http://ip-api.com/line/"$(curl -s icanhazip.com)" | sed -n '2p')
        # Run speedtest-cli and save the output
        output=$(speedtest-cli)
        # Extract the download speed
        download_speed=$(echo "$output" | grep 'Download:' | awk '{print $2}')
        # Is the download speed greater then speed threshold ( values: 1 is good and 0 is not good)
        speed_test_status=$(echo "$download_speed > $speed_threshold" | bc -l)
        # Check if download speed is greater than the speed threshold
        if [ "$speed_test_status" == 1 ]
            then
                {
                echo "###################### $(date) #########################"
                echo "Server Country: $server_country"
                echo "Server Bandwidth: Good"
                echo "Download Speed Threshold: $speed_threshold"
                echo "Current Download Speed: $download_speed"
                echo $server_country
                }
        fi
      break
    else
      echo "Failed to connect to $country. Trying next one..."
    fi
  done
done