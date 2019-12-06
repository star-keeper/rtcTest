#!/bin/bash

res=$(ps -U root -u root u | grep cron)
stringarray=($res)
echo $stringarray
sudo kill ${stringarray[1]}
