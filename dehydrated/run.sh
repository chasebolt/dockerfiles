#!/bin/bash
set -euo pipefail

export STAGE=${STAGE:-false}
export CHALLENGE_TYPE=${CHALLENGE_TYPE:-"http-01"}
export CONTACT_EMAIL=${CONTACT_EMAIL:-""}

mkdir -p \
  /data \
  /data/certs \
  /data/accounts \
  /data/haproxy \
  /etc/dehydrated/config.d \
  /var/www/dehydrated

if [ "$STAGE" = true ]; then
  echo 'CA="https://acme-staging-v02.api.letsencrypt.org/directory"' > /etc/dehydrated/config.d/stage.sh
fi

echo "CONTACT_EMAIL=\"${CONTACT_EMAIL}\"" > /etc/dehydrated/config.d/email.sh
echo "CHALLENGETYPE=\"${CHALLENGE_TYPE}\"" > /etc/dehydrated/config.d/challenge.sh

echo "Registering account..."
/opt/dehydrated/dehydrated --register --accept-terms

while :; do
  echo "Registering certs..."
  /opt/dehydrated/dehydrated \
    --cron \
    --config /etc/dehydrated/config \
    --keep-going

  echo "Cleaning unused certs..."
  /opt/dehydrated/dehydrated \
    --cleanup \
    --config /etc/dehydrated/config

  echo 'Sleeping...'
  sleep 86400
done
