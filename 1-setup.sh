#!/bin/bash
while true; do
	read -p "Have you enabled I2C? [yn] > " yn
	case $yn in
		[Yy]* ) echo "Good, let's continue"; break;;
		[Nn]* ) echo "You will be redirected to configure I2C in 10 seconds."; break;;
		* ) echo "Please answer [y] or [n].";;
	esac
done

echo "   5 Interfacing Options > P5 I2C > Yes > Ok > Finish"
lxterminal -e sudo raspi-config

while true; do
	read -p "Are you connected to the internet? [yn] > " yn
	case $yn in
		[Yy]* ) echo "Good, let's continue."; ./installation.sh; break;;
		[Nn]* ) echo "Please connect to the internet and run ./installation.sh when you are connected."; exit;;
		* ) echo "Please answer [y] or [n]."
	esac
done
