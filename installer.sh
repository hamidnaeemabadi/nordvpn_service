#!/bin/bash
########################################################
# Author: [Hamid Naeemabadi, hamid.naeemabadi@gmail.com]
# Version: 1.1
# Date: [2023/12/26 10:50]
# Purpose: [This script will install the NordVPN best server finder on the system]
########################################################
app_path=/opt/nordvpn_services/
service_path=/lib/systemd/system/
nordvpn_srv_finder_script=find_nordvpn_best_server.sh
nordvpn_srv_finder_service=nordvpn_srv_finder.service
nordvpn_autoconnect_script=nordvpn_autoconnect.sh
nordvpn_autoconnect_service=nordvpn_autoconnect.service
log_path=/var/log/nordvpn/

# Install deps
which speedtest || (sudo apt update -qq && sudo apt install -y speedtest-cli)
which curl || (sudo apt update -qq && sudo apt install -y curl)

# Copy the script
sudo mkdir -p $app_path
sudo cp -v ./$nordvpn_srv_finder_script $app_path
sudo chmod +x $app_path/$nordvpn_srv_finder_script
sudo cp -v ./$nordvpn_autoconnect_script $app_path
sudo chmod +x $app_path/$nordvpn_autoconnect_script

# Config logs and the logrotate
sudo mkdir -p $log_path
sudo cat << EOT >/etc/logrotate.d/nordvpn_srv_finder
/var/log/nordvpn/nordvpn_srv_finder.log {
    daily
    rotate 7
    missingok
    notifempty
    compress
    delaycompress
    copytruncate
}
EOT

sudo cat << EOT >/etc/logrotate.d/nordvpn_autoconnect
/var/log/nordvpn/nordvpn_autoconnect.log {
    daily
    rotate 7
    missingok
    notifempty
    compress
    delaycompress
    copytruncate
}
EOT
sudo systemctl restart logrotate

# Install the finder service
sudo cp -v ./$nordvpn_srv_finder_service $service_path
sudo cp -v ./$nordvpn_autoconnect_service $service_path
sudo systemctl daemon-reload
sudo systemctl enable nordvpn_srv_finder
sudo systemctl start nordvpn_srv_finder
sudo systemctl status nordvpn_srv_finder
echo ""
sudo systemctl enable nordvpn_autoconnect
sudo systemctl start nordvpn_autoconnect
sudo systemctl status nordvpn_autoconnect
######################
# Clean
# sudo rm -fv $service_path/$nordvpn_srv_finder_service 
# sudo rm -fv $service_path/$nordvpn_autoconnect_service 
# sudo rm -fv /etc/logrotate.d/nordvpn_srv_finder
# sudo systemctl stop nordvpn_srv_finder
# sudo systemctl stop nordvpn_autoconnect
# sudo systemctl disable nordvpn_srv_finder
# sudo systemctl disable nordvpn_autoconnect
# sudo systemctl daemon-reload