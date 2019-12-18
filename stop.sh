#!/bin/bash

if [ $1 -eq 0 ]; then
	sudo pkill -U root -u root clock
	pkill -U pi -u pi clock

elif [ $1 -eq 1 ]; then
	pkill -U pi -u pi clock

elif [ $1 -eq 2 ]; then
	sudo pkill -U root -u root clock
fi
