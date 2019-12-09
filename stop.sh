#!/bin/bash

res=$(ps -U root -u root u | grep cron)
stringarray=($res)
sudo kill ${stringarray[1]}
