#!/bin/sh

[ -z $2 ] && echo "Usage: $0 INSTANCE_NAME URL" && exit 1

INSTANCE_NAME="$1"
URL="$2"

ROOT_PATH=/var/opt/superdesk_instances/$INSTANCE_NAME
FRONTEND_PATH=$ROOT_PATH/frontend

mkdir -p $ROOT_PATH

cp frontend $ROOT_PATH/ -r
cd $FRONTEND_PATH

sudo npm -g install grunt-cli bower

npm install
bower update --allow-root --force-latest

grunt build --server="$URL"
