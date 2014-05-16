##!/bin/sh

[ -z "$1" ] &&
echo "Usage: $0 INSTANCE_NAME" &&
echo "       $0 master" &&
exit 1


INSTANCE_NAME="$1"
ROOT_PATH=/var/opt/superdesk_instances/$INSTANCE_NAME
FRONTEND_PATH=$ROOT_PATH/frontend
PWD=$(readlink -e $(dirname $0))
RESULTS_DIR=$PWD/../../results

cd $FRONTEND_PATH &&

# run tests
grunt ci:bamboo &&

(
	mkdir -p $RESULTS_DIR 2> /dev/null ;
	mv test-results.xml $RESULTS_DIR
) &&

exit 0
