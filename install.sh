#!/bin/env sh
echo "Installing dependencies listed in dependencies.txt..."

sed -e 's/#.*$//' -e '/^$/d' dependencies.txt | while read p; do
    echo "Running apk add $p"
    apk add $p
done 



setup-devd udev

#add user to groups
adduser gjoanes input
adduser gjoanes video
adduser gjoanes audio
adduser gjoanes flatpak

#start dbus
rc-service dbus start
rc-update add dbus

#start  elogind
rc-update add elogind
rc-service elogind start

#start network manager
rc-service networking stop
rc-service wpa_supplicant stop
rc-update del networking boot
rc-update del wpa_supplicant boot
rc-service networkmanager start
rc-update add networkmanager

#start display manager
rc-update add lightdm


mkdir -p /usr/share/xsessions/
cp qtile.desktop /usr/share/xsessions/
cp NetworkManager.conf /etc/NetworkManager/NetworkManager.conf
cp 50-org.freedesktop.NetworkManager.rules /etc/polkit-1/rules.d/50-org.freedesktop.NetworkManager.rules
cp auto-cpufreq /etc/init.d/auto-cpufreq
cp rfkill /etc/init.d/rfkill

rc-update add rfkill
rc-update add auto-cpufreq 





