#!/bin/sh

[ -z "$1" ] &&
echo "Usage: $0 INSTANCE_NAME" &&
echo "       $0 master" &&
exit 1


INSTANCE_NAME="$1"
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

exit 0
