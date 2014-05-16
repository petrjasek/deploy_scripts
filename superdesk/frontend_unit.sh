##!/bin/sh

[ -z "$2" ] &&
echo "Usage: $0 INSTANCE_NAME INSTANCE_URL" &&
echo "       $0 master master.sd-test.sourcefabric.org" &&
exit 1


INSTANCE_NAME="$1"
URL="$2"
ROOT_PATH=/var/opt/superdesk_instances/$INSTANCE_NAME
FRONTEND_PATH=$ROOT_PATH/frontend
PWD=$(readlink -e $(dirname $0))

cd $FRONTEND_PATH &&

# run tests
grunt ci:bamboo &&

mkdir -p $PWD/../../results/ 2> /dev/null ;
mv server-test-results.xml client-test-results.xml $PWD/../../results/ &&

exit 0
