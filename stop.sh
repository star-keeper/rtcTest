#!bin/bash

res=$(ps -U root -u root u | grep cron)
stringarray=($res)
echo ${stringarray[1]}
sudo kill ${stringarray[1]}
