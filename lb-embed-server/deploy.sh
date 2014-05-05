#!/bin/sh

root=/var/www/nodejs-dev

backend_url="$1"
backend_port="$2"
frontend_url="$3"
[ "$2" = "" ] &&
		echo "Usage: $0 backend_url backend_port [frontend_url]" &&
		exit 1
[ "$3" = "" ] &&
		frontend_url=$backend_url

# prepare and copy srcs
working_dir=$(dirname $0)
mkdir -p $root 2>/dev/null
cp -rf lb-embed-server/* lb-embed-server/.* $root/
cd $root

# generate config
source $working_dir/files/config.json.tpl > config.json

# install deps
npm --allow-root install
bower --allow-root install

# restart server
grunt server:forever:restart
