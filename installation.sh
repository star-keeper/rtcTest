#!/bin/bash

echo "INSTALLING NTP"
sudo apt install ntp

echo "INSTALLING PYTHON TOOLS FOR I2C"
sudo apt update
sudo apt install -y python-smbus i2c-tools

echo "You will be prompted to set your timezone in 10 seconds."
echo "   4 Localization Option > I2 Change Timezone"
echo "   select area > select timezone > Finish"
sleep 10
lxterminal -e sudo raspi-config

#wait for user
while true; do
	read -p "Press enter to continue. >  " yn
	case $yn in
		* ) break;;
	esac
done

sudo systemctl stop ntp
sudo systemctl disable ntp
sudo systemctl enable ntp

echo "COMPLETE"
echo "Please connect the Chronodot upon shutdown."
echo "Once connected, turn the Raspberry Pi back on."
echo "Your Raspberry Pi will shutdown in 10 seconds."
sleep 10
sudo shutdown now
