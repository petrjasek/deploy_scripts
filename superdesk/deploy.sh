#!/bin/bash

[ -z $1 ] && echo "Usage: $0 instance_name" && exit 1

instance="$1"
instance_path=/var/opt/superdesk_instances/$instance
backend_path=$instance_path/backend

# create working directory
mkdir -p $backend_path

# create/reuse virtual environment
[ ! -f $instance_path/env/bin/activate ] && (
    virtualenv -p python3.2 $instance_path/env;
)
. $instance_path/env/bin/activate;

# install dependencies
pip install -U pip distribute
pip install -U -r requirements.txt
pip install -U gunicorn

# restart application
supervisorctl update
supervisorctl restart $instance
