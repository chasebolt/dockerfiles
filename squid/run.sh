#!/bin/sh
set -euo pipefail

CACHE_SIZE_MEM=${CACHE_SIZE_MEM:-"1024"}
CACHE_SIZE_DISK=${CACHE_SIZE_DISK:-"1024"}

sed -i "s/%%CACHE_SIZE_MEM%%/${CACHE_SIZE_MEM}/" /etc/squid/squid.conf || true
sed -i "s/%%CACHE_SIZE_DISK%%/${CACHE_SIZE_DISK}/" /etc/squid/squid.conf || true

if [ ! -d /var/cache/squid/00 ]; then
  echo "Initializing Object cache..."
  chown squid:squid /var/cache/squid
  /usr/sbin/squid -f /etc/squid/squid.conf -N -z
  chown -R squid:squid /var/cache/squid
fi
if [ ! -d /var/lib/ssl_db ]; then
  echo "Initializing SSL cache..."
  /usr/lib/squid/ssl_crtd -c -s /var/lib/ssl_db
  chown -R squid:squid /var/lib/ssl_db
fi

/usr/sbin/squid -f /etc/squid/squid.conf -NYd 1
