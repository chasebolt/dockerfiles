#!/bin/sh

[ ! -d /data ] && mkdir /data
[ ! -f /data/config.txt ] && cp /config.txt /data/config.txt

/terraria/TerrariaServer.bin.x86_64 -config /data/config.txt
