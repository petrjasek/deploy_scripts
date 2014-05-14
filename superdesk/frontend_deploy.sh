#!/bin/sh

[ -z "$2" ] &&
echo "Usage: $0 INSTANCE_NAME INSTANCE_URL" &&
echo "       $0 master master.sd-test.sourcefabric.org" &&
exit 1


INSTANCE_NAME="$1"
URL="$2"
ROOT_PATH=/var/opt/superdesk_instances/$INSTANCE_NAME
FRONTEND_PATH=$ROOT_PATH/frontend

# create working dir and copy files from repo there
mkdir -p $ROOT_PATH ;
cp frontend $ROOT_PATH/ -r &&
cd $FRONTEND_PATH &&

# install tools
sudo npm -g install grunt-cli bower &&

# install dependencies
npm install &&
bower update --allow-root --force-latest &&

# deploy
grunt build --server="$URL" &&

exit 0
