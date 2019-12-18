#!/bin/bash

#cronjob kill
res=$(ps -U root -u root u | grep cron)
stringarray=($res)
sudo kill ${stringarray[1]}

#clock kill
pkill -U root -u root clock
pkill -U pi -u pi clock
