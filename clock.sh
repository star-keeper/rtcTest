#!/bin/bash

currentPi=3 #be sure to change this
currentHour=1 #h
maxHour=24 #h
secInHour=10 #s
interval=5 #s
boot=10 #s documentation states ntp updates every minute

cd /home/pi/Documents/rtcTest

#create a data folder
counts=$(ls -l | wc -l)
counts=$((counts-12)) #only count data folders
mkdir data${counts}

#ensure ntp is enabled to start
sudo systemctl enable ntp
sudo systemctl start ntp

#give ntp time to update
sleep $boot

#update hwclock to hold the same time as ntp
sudo hwclock -w

#run for an hour without ntp (then for two hours...then for three hours...etc)
#note: might need to switch to hwclock commands
while [ $currentHour -le $maxHour ]; do
	exec 3<> data${counts}/${currentHour}currentHour.csv
	echo $(timedatectl show --property=TimeUSec --value) "network" >&3 #first reliable time
	sudo systemctl stop ntp
	sudo systemctl disable ntp
	echo $(sudo hwclock -r) "readrtc" >&3 #if this doesn't appear then hwclock not set up properly

	#prepare for inner while
	count=1
	fullTime=$((currentHour * secInHour)) #s
	moment=$((count * interval)) #s

	while [ $moment -le $fullTime ]; do
		sleep $interval #s
		echo $(timedatectl show --property=TimeUSec --value) "hwclock" >&3 #monitor time

		#update for next inner while
		count=$((count + 1))
		moment=$((count * interval))

	done

	#reenable ntp
	sudo systemctl enable ntp
	sudo systemctl start ntp

	#give ntp time to update in case of drift
	sleep $boot
	echo $(timedatectl show --property=TimeUSec --value) "network" >&3 #time after enable and boot wait
	exec 3>&-

	#process file and send an email
	./convert.sh $counts $currentPi $currentHour $interval $boot

	#confirm ip address
	if [ ${currentHour} -eq 1 ]; then
		cd .my
		./confirm.sh
		cd ..
	fi

	#update the current hour
	currentHour=$((currentHour + 1))

done

sudo rm -r data* -f
cd .my
sudo rm my* -f
sudo reboot
