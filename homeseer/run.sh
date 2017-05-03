#!/bin/sh
export LANG=en_US.UTF-8

TIMEZONE=${TIMEZONE:-"America/Los_Angeles"}
echo $TIMEZONE > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# bug fix for case sensitive filesystems
# without this myhs.homeseer.com wont load icons
ln -s /HomeSeer/html/images/homeseer /HomeSeer/html/images/HomeSeer

mono /HomeSeer/HSConsole.exe --log
