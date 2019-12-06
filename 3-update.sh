#!/bin/bash

echo "This will take between 5 and 10 minutes."
sudo apt-get update
sudo apt-get -y upgrade

echo "Please add the following lines to /boot/config.txt"
echo "   dtparam=i2c=on"
echo "   dtoverlay=i2c-rtc,ds3231"

lxterminal -e sudo nano /boot/config.txt

#wait for user
while true; do
	read -p "Press enter to continue. >  " yn
	case $yn in
		* ) break;;
	esac
done

sudo crontab ./crontab.cron
