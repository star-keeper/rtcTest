#!/bin/bash

echo "This will take between 5 and 10 minutes."
sudo apt-get update
sudo apt-get -y upgrade

echo "Please add the following lines to /boot/config.txt"
echo "   dtparam=i2c=on"
echo "   dtoverlay=i2c-rtc,ds3231"

lxterminal -e sudo nano /boot/config.txt

sudo hwclock -w
sudo systemctl disable ntp
sudo systemctl stop ntp

echo "COMPLETE"
echo "Current Time"

sudo hwclock -r
