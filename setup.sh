#!/bin/bash
while true; do
	read -p "Have you enabled I2C? [yn] > " yn
	case $yn in
		[Yy]* ) echo "Good, let's continue"; break;;
		[Nn]* ) echo "You will be redirected to configure I2C in 10 seconds."; echo "   5 Interfacing Options > P5 I2C > Yes > Ok > Finish"; sleep 10; sudo raspi-config; break;;
		* ) echo "Please answer [y] or [n].";;
	esac
done

while true; do
	read -p "Are you connected to the internet? [yn] > " yn
	case $yn in
		[Yy]* ) echo "Good, let's continue."; ./installation.sh; break;;
		[Nn]* ) echo "Please connect to the internet."; exit;;
		* ) echo "Please answer [y] or [n]."
	esac
done
