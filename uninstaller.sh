#!/bin/bash
########################################################
# Author: [Hamid Naeemabadi, hamid.naeemabadi@gmail.com]
# Version: 1.1
# Date: [2024/03/06 12:10]
# Purpose: [This script will uninstall the NordVPN service]
########################################################
app_path=/opt/nordvpn_services/
service_path=/lib/systemd/system/
nordvpn_srv_finder_service=nordvpn_srv_finder.service
nordvpn_autoconnect_service=nordvpn_autoconnect.service
log_path=/var/log/nordvpn/

echo "Stopping nordvpn_autoconnect service ..."
sudo systemctl stop nordvpn_srv_finder
sudo systemctl stop nordvpn_autoconnect
sudo systemctl disable nordvpn_srv_finder
sudo systemctl disable nordvpn_autoconnect
sudo systemctl daemon-reload
echo "Removing nordvpn_autoconnect service files..."
sudo rm -fv $service_path/$nordvpn_srv_finder_service 
sudo rm -fv $service_path/$nordvpn_autoconnect_service 
echo "Removing nordvpn_autoconnect script files..."
sudo rm -rfv $app_path
echo "Removing nordvpn_autoconnect log configs files..."
sudo rm -fv /etc/logrotate.d/nordvpn_srv_finder
sudo rm -fv /etc/logrotate.d/nordvpn_autoconnect
echo "Removing nordvpn_autoconnect log files..."
sudo rm -rfv $log_path
echo "Uninstalling nordvpn_autoconnect completed."