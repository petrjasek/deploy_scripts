#!/bin/sh

SCRIPTS_DIR='/var/opt/instances/'
INIT_FILE='/etc/init.d/liveblog'
CWD=$(dirname "$0")

echo cp -rf $CWD/scripts $SCRIPTS_DIR/
cp -rf $CWD/scripts $SCRIPTS_DIR/
echo cp liveblog_sysvinit $INIT_FILE
cp liveblog_sysvinit $INIT_FILE
