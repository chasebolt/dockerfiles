#!/bin/bash
trap exit 0 SIGTERM
export LANG=en_US.UTF-8

TIMEZONE=${TIMEZONE:-"America/Los_Angeles"}
echo $TIMEZONE > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

[ ! -d "/data/HomeSeer" ] && tar -xz -C /data -f /src/homeseer.tgz

chown -R root:root /data/HomeSeer

# bug fix for case sensitive filesystems
# without this myhs.homeseer.com wont load icons
ln -s /data/HomeSeer/html/images/homeseer /data/HomeSeer/html/images/HomeSeer

cd /data/HomeSeer && mono HSConsole.exe --log
