#!/bin/bash
########################################################
# Author: [Hamid Naeemabadi, hamid.naeemabadi@gmail.com]
# Version: 1.1
# Date: [2023/12/26 10:50]
# Purpose: [This script will install the NordVPN best server finder on the system]
########################################################
app_path=/opt/nordvpn_services/
service_path=/lib/systemd/system/
nordvpn_autoconnect_script=nordvpn_autoconnect.sh
nordvpn_autoconnect_service=nordvpn_autoconnect.service
log_path=/var/log/nordvpn/

# Copy the script
sudo mkdir -p $app_path
sudo cp -v ./$nordvpn_autoconnect_script $app_path
sudo chmod +x $app_path/$nordvpn_autoconnect_script

# Config logs and the logrotate
sudo mkdir -p $log_path
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
sudo cp -v ./$nordvpn_autoconnect_service $service_path
sudo systemctl daemon-reload
sudo systemctl enable nordvpn_autoconnect
sudo systemctl start nordvpn_autoconnect
sudo systemctl status nordvpn_autoconnect
