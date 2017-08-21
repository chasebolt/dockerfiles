#!/bin/sh
set -euo pipefail

CURL_OPTIONS=${CURL_OPTIONS:-"-sS"}
SIGNAL=${SIGNAL:-"SIGHUP"}
INOTIFY_EVENTS=${INOTIFY_EVENTS:-"create,delete,modify,move"}
INOTIFY_OPTONS=${INOTIFY_OPTONS:-"--monitor --exclude='*.sw[px]'"}
VOLUMES=${VOLUMES:-"/data"}

inotifywait -e ${INOTIFY_EVENTS} ${INOTIFY_OPTONS} "${VOLUMES}" | \
  while read -r NOTIFIES; do
    echo "${NOTIFIES}"
    echo "notify received, sent signal ${SIGNAL} to container ${CONTAINER}"
    curl ${CURL_OPTIONS} -X POST --unix-socket /var/run/docker.sock "http://localhost/containers/${CONTAINER}/kill?signal=${SIGNAL}"
  done
