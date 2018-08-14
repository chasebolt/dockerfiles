#!/bin/sh

# if we have a bind mount at this location then copy updated files
if [ -d /HomeSeer ]; then
  cp -a /data/HomeSeer /
else
  ln -s /data/HomeSeer /HomeSeer
fi

# bug fix for case sensitive filesystems
# without this myhs.homeseer.com wont load icons
ln -s /HomeSeer/html/images/homeseer /HomeSeer/html/images/HomeSeer

cd /HomeSeer
mono ./HSConsole.exe --log
