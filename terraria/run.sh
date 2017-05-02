#!/usr/bin/env sh

[ ! -f /data/config.txt ] && cp /config.txt.default /data/config.txt

exec tail -f /dev/null | /src/${TERRARIA_VERSION}/Linux/TerrariaServer.bin.x86_64 \
  -config /data/config.txt
