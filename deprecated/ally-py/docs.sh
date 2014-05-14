#!/bin/bash

root_path="/var/opt/apy_instances/"$1""

# reuse venv (assuming it's already created during the deploy)
. "$root_path"/env/bin/activate;

# dependencies
pip install sphinx

# clean up previous docs
rm -fr "$root_path"/doc/
mkdir "$root_path"/doc/

# generate docs
python -m ally_start -doc "$root_path"/doc/ --templates "$root_path"/env/src/ally-py-common/doc-templates/
cd "$root_path"/doc/
make html
