#!/bin/sh -e

DAEMON=ddns.rb

stop() {
    echo "Received SIGINT or SIGTERM. Shutting down $DAEMON"
    # Get PID
    pid=$(cat /var/run/$DAEMON/$DAEMON.pid)
    # Set TERM
    kill -TERM "${pid}"
    # Wait for exit
    wait "${pid}"
    # All done.
    echo "Done."
}

echo "Running $*"
if [ "$(basename $1)" = "$DAEMON" ]; then
    trap "stop; exit 0" INT TERM
    "$@" &
    pid="$!"
    mkdir -p /var/run/$DAEMON && echo "${pid}" > /var/run/$DAEMON/$DAEMON.pid
    wait "${pid}" && exit $?
else
    exec "$@"
fi
