#!/bin/bash

[ -z "$2" ] &&
echo "Usage: $0 INSTANCE_NAME SRC_PATH" &&
echo "       $0 master ./superdesk-server/" &&
exit 1

INSTANCE="$1"
SRC_PATH="$2"
INSTANCE_PATH=/var/opt/superdesk_instances/$INSTANCE
BACKEND_PATH=$INSTANCE_PATH/backend


# flush src dir, copy fresh one and go there
rm -fr $BACKEND_PATH
cp -fr $SRC_PATH $BACKEND_PATH
cd $BACKEND_PATH

# create/reuse virtual environment
[ ! -f $INSTANCE_PATH/env/bin/activate ] && (
    virtualenv-3.4 -p python3.3 $INSTANCE_PATH/env;
)
. $INSTANCE_PATH/env/bin/activate;

# install dependencies
pip install -U pip distribute
pip install -U -r $BACKEND_PATH/requirements.txt
pip install -U gunicorn

# restart application
supervisorctl update
supervisorctl restart superdesk_$INSTANCE

# create admin user
python manage.py users:create -u admin -p admin 2>&1 && exit 0
