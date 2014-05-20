#!/bin/sh

[ "$1" = "" ] && echo Usage: $0 /path/to/python/file && exit 1

export LC_CTYPE="en_US.UTF-8"
export NEW_RELIC_CONFIG_FILE=/var/opt/instances/scripts/newrelic.ini
exec /usr/local/bin/newrelic-admin run-program python3 $1 $2 $3
