#!/bin/sh

root=/var/www/nodejs-dev

# prepare and copy srcs
mkdir -p $root 2>/dev/null
cp -rf lb-embed-server/* lb-embed-server/.* $root/
cd $root

# install deps
npm --allow-root install
bower --allow-root install
