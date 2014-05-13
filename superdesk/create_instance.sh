#!/bin/sh

[ -z "$2" ] &&
echo "Usage: $0 instance_name instance_url" &&
echo "       $0 master master.sd-test.sourcefabric.org" &&
exit 1

PWD=$(dirname $0)
INSTANCE="$1"
URL="$2"
NGINX_PORT=82
STARTING_PORT=9090
ROOT=/var/opt/superdesk_instances
INSTANCE_ROOT=$ROOT/$INSTANCE

mkdir -p $INSTANCE_ROOT

rm $INSTANCE_ROOT/.port 2>/dev/null
PORT=$(expr $(cat $ROOT/*/.port | sort -nr | head -n 1) + 1) 2>/dev/null 
[ $PORT -le $STARTING_PORT ] && PORT=$STARTING_PORT
echo $PORT > $INSTANCE_ROOT/.port

. $PWD/templates/nginx.tpl > /etc/nginx/sites-enabled/$INSTANCE
service nginx reload

. $PWD/templates/supervisor.tpl > /etc/supervisor/conf.d/$INSTANCE.conf
supervisorctl reread
