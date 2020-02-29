# rtcTest
Tests the RTC on a Chronodot.
Setup and Script for Real Time Clock tests

**Please complete these sequentually for first time setup:**
git clone rtcTest repository
$ ./1-setup.sh
The Raspberry Pi will shutdown.
Plug a Chronodot into the gpio pins.
Turn the Raspberry Pi on.
$ ./3-update.sh
$ ./4-mail.sh 1
Shut down the Raspberry Pi:
$ sudo shutdown -r now
On startup, clock.sh will automatically begin to run.
