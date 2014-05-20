#!/bin/sh

[ -z "$2" ] &&
echo "Usage: $0 INSTANCE_NAME SRC_PATH" &&
echo "       $0 master ./superdesk-server/" &&
exit 1


INSTANCE="$1"
SRC_PATH="$2"
INSTANCE_PATH=/var/opt/superdesk_instances/$INSTANCE
RESULTS_DIR=$(dirname $0)/../../../results
RESULTS_FILE=$RESULTS_DIR/unit.xml


# flush old test results
(
	rm -r $RESULTS_FILE ;
	mkdir -p $RESULTS_DIR
) &&

# create/reuse virtual environment
[ ! -f $INSTANCE_PATH/env/bin/activate ] && (
    virtualenv-3.4 -p python3.3 $INSTANCE_PATH/env;
)
. $INSTANCE_PATH/env/bin/activate &&

# run tests
cd $SRC_PATH &&
nosetests -sv --with-xunit --xunit-file=$RESULTS_FILE
