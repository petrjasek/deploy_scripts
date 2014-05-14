#!/bin/sh

[ -z "$2" ] &&
echo "Usage: $0 INSTANCE_NAME INSTANCE_URL" &&
echo "       $0 master master.sd-test.sourcefabric.org" &&
exit 1

PWD=$(dirname $0)
INSTANCE="$1"
URL="$2"
NGINX_PORT=82
STARTING_PORT=9090
ROOT=/var/opt/superdesk_instances
INSTANCE_ROOT=$ROOT/$INSTANCE
LOG_PATH=$INSTANCE_ROOT/logs

mkdir -p $INSTANCE_ROOT
mkdir -p $LOG_PATH

rm $INSTANCE_ROOT/.port 2>/dev/null
PORT=$(expr $(cat $ROOT/*/.port | sort -nr | head -n 1) + 1) 2>/dev/null 
[ $PORT -le $STARTING_PORT ] && PORT=$STARTING_PORT
echo $PORT > $INSTANCE_ROOT/.port

. $PWD/templates/nginx.tpl > /etc/nginx/sites-enabled/superdesk_$INSTANCE
service nginx reload

. $PWD/templates/supervisor.tpl > /etc/supervisor/conf.d/superdesk_$INSTANCE.conf
supervisorctl reread

mkdir -p /var/www/sd-test/$INSTANCE
. $PWD/templates/index.html.tpl > /var/www/sd-test/$INSTANCE/index.html
