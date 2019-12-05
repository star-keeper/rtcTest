#!/bin/bash

echo "This will take between 5 and 10 minutes."
sudo apt-get update
sudo apt-get -y upgrade

echo "Please add the following to the /etc/modules"
echo "   rtc-ds1307"

lxterminal &
sudo nano /etc/modules
exit

echo "Please add the following to /etc/rc.local just before exit"
echo "   echo ds1307 0x68 > /sys/class/i2c-adapter/i2c-1/new_device"
echo "   hwclock -s"

lxterminal &
sudo nano /etc/rc.local
exit

sudo hwclock -w
sudo systemctl disable ntp
sudo systemctl stop ntp

echo "COMPLETE"
echo "Current Time"

sudo hwclock -r
