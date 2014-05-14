#!/bin/sh

[ -z $1 ] && echo "Usage: $0 URL" && exit 1

URL="$1"

ROOT_PATH=/var/opt/superdesk_instances/"$1"
FRONTEND_PATH=$ROOT_PATH/frontend

mkdir -p $ROOT_PATH

cp frontend $ROOT_PATH/ -r
cd $FRONTEND_PATH

sudo npm -g install grunt-cli bower

npm install
bower update --allow-root --force-latest

grunt build --server="$URL"
