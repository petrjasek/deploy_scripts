#!/bin/bash

[ -z $1 ] && echo "Usage: $0 instance_name" && exit 1

root_path="/var/opt/apy_instances/"$1""

# create config directory
mkdir -p "$root_path"/workspace

# create/reuse virtual environment
[ ! -f "$root_path"/env/bin/activate ] && (
    virtualenv -p python3.2 "$root_path"/env;
)
. "$root_path"/env/bin/activate;

# install deploy dependencies
pip install --upgrade pip distribute
# install application and it's dependencies
pip install -e git+https://github.com/sourcefabric/Ally-Py.git@apy-8-implement-x-filter#egg=ally --install-option="--add-git=git+https://github.com/superdesk/ally-py-common#egg=ally-py-common" --install-option="--install=ally-user-management"

# create configs for services
bash /var/opt/apy_instances/scripts/instance_create.sh $1 "$1".apy.sd-test.sourcefabric.org

# generate application configs
cd "$root_path"/workspace
python -m ally_start -dump
