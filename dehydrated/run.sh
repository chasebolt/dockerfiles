#!/bin/bash
set -euo pipefail

export STAGE=${STAGE:-false}
export CHALLENGE_TYPE=${CHALLENGE_TYPE:-"http-01"}
export CONTACT_EMAIL=${CONTACT_EMAIL:-""}

if [ "$STAGE" = true ]; then
  mkdir -p /etc/dehydrated/config.d
  echo 'CA="https://acme-staging.api.letsencrypt.org/directory"' > /etc/dehydrated/config.d/stage.sh
  echo 'CA_TERMS="https://acme-staging.api.letsencrypt.org/terms"' >> /etc/dehydrated/config.d/stage.sh
fi

[ ! -d "/data" ] && mkdir -p /data
[ ! -d "/data/certs" ] && mkdir -p /data/certs
[ ! -d "/data/accounts" ] && mkdir -p /data/accounts
[ ! -d "/data/haproxy" ] && mkdir -p /data/haproxy
[ ! -d "/etc/dehydrated/config.d" ] && mkdir -p /etc/dehydrated/config.d
[ ! -d "/var/www/dehydrated" ] && mkdir -p /var/www/dehydrated

echo "CHALLENGETYPE=\"${CHALLENGE_TYPE}\"" > /etc/dehydrated/config.d/challenge.sh
echo "CONTACT_EMAIL=\"${CONTACT_EMAIL}\"" > /etc/dehydrated/config.d/email.sh

/opt/dehydrated/dehydrated --register --accept-terms

while :; do
  /opt/dehydrated/dehydrated \
    --cron \
    --config /etc/dehydrated/config \
    --challenge $CHALLENGE_TYPE \
    --no-lock \
    --keep-going

  echo 'Sleeping...'
  sleep 86400
done
