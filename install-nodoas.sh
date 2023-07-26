#!/bin/env sh

mkdir -p ~/.local/bin
mkdir -p ~/.config/networkmanager-dmenu/
mkdir -p ~/.local/share/applications

python3 -m pip --no-cache-dir install  "eduvpn-client[gui]"

flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

git clone https://github.com/firecat53/networkmanager-dmenu.git
cp networkmanager-dmenu/networkmanager-dmenu ~/.local/bin/
cp networkmanager-dmenu/networkmanager-dmenu.desktop ~/.local/share/applications
cp networkmanager-dmenuconfig.ini.example ~/.config/networkmanager-dmenu/config.ini

wget https://raw.githubusercontent.com/Dou2ble/qutefetch/main/index.html

git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq/
pip3 install power

doas python3 setup.py install --record files.txt
doas mkdir -p /usr/local/share/auto-cpufreq/
doas cp -r scripts/ /usr/local/share/auto-cpufreq/

#then I had to edit /usr/local/share/auto-cpufreq/scripts/auto-cpufreq-openrc so that command="/usr/bin/auto-cpufreq"

#doas cp /usr/local/share/auto-cpufreq/scripts/auto-cpufreq-openrc /etc/init.d/auto-cpufreq
#doas chmod +x /etc/init.d/auto-cpufreq
#doas rc-service auto-cpufreq start
#doas rc-update add auto-cpufreq


cp .profile ~/.profile 