# rtcTest
Tests the RTC on a Chronodot.
Setup and Script for Real Time Clock tests

**Please complete these sequentually for first time setup:**
$ ./setup.sh
The Raspberry Pi will shut itself down. Plug a Chronodot into the gpio pins.
Turn on the Raspberry Pi
$ ./update.sh
$ sudo nano crontab.cron
Add the following line to the end:
   @reboot /home/pi/clock.sh
Save the file.
Add the file to the cron table using:
$ sudo crontab ./crontab.cron
Shut down the Raspberry Pi:
$ sudo shutdown -r now
On startup, clock.sh will automatically begin to run.
