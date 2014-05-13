#!/bin/sh

[ -z "$1" ] && echo "Usage: $0 instance_name" && exit 1

INSTANCE="$1"
ROOT=/var/opt/superdesk_instances
INSTANCE_ROOT=$ROOT/$INSTANCE

rm -r $INSTANCE_ROOT

rm /etc/nginx/sites-enabled/$INSTANCE
service nginx reload

rm /etc/supervisor/conf.d/$INSTANCE.conf
supervisorctl reread
