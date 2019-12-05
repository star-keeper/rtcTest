#!/bin/bash

currentHour=1 #h
secInHour=60 #s
interval=5 #s
boot=90 #s documentation states ntp updates every minute

cd /home/pi/Documents/rtcTest

#create a data folder
counts=$(ls -l | wc -l)
counts=$((counts-7)) #only count data folders
mkdir data$counts

#ensure ntp is enabled to start
sudo systemctl enable ntp
sudo systemctl start ntp

#give ntp time to update
sleep $boot

#run for an hour without ntp (then for two hours...then for three hours...etc)
#note: might need to switch to hwclock commands
#note: do I need to make sure the rtc is set up here? or wait for it?
while true; do
	exec 3<> data/${currentHour}currentHour.csv
	timedatectl show --property=TimeUSec --value >&3 #first reliable time
	sudo systemctl stop ntp
	sudo systemctl disable ntp
	timedatectl show --property=TimeUSec --value >&3 #time immediately after disable

	#prepare for inner while
	count=1
	fullTime=$((currentHour * secInHour)) #s
	moment=$((count * interval)) #s

	while [ $moment -le $fullTime ]; do
		sleep $interval #s
		timedatectl show --property=TimeUSec --value >&3 #monitor time

		#update for next inner while
		count=$((count + 1))
		moment=$((count * interval))

	done

	#reenable ntp
	sudo systemctl enable ntp
	sudo systemctl start ntp

	#give ntp time to update in case of drift
	sleep $boot
	timedatectl show --property=TimeUSec --value >&3 #time after enable and boot wait

	currentHour=$((currentHour + 1))
	exec 3>&-
done
