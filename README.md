# Nord VPN Service

With this script you can create a service that checks if nordvpn is disconnected or not working and tries to reconnect, also when reconnecting, it tries more than 18 different countries.

## Install

```bash
# To install just nordvpn_autoconnect service run the mini installer
chmod +x installer_mini.sh && sudo bash installer_mini.sh

# To install nordvpn_autoconnect service with finding fastest server run the main installer
chmod +x installer.sh && sudo bash installer.sh
```

## Check the services

```bash
systemctl status nordvpn_autoconnect
systemctl status nordvpn_srv_finder
```

## Check the service logs

```bash
tail -f /var/log/nordvpn/nordvpn_autoconnect.log
tail -f /var/log/nordvpn/nordvpn_srv_finder.log
```

Note: The services script path will be in `/opt/nordvpn_services/`
