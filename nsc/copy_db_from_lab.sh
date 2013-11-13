#!/bin/sh

APP="$bamboo_app"

REMOTE_PATH="\'/var/www/""$APP""-prelive/backup/backup-*.tar.gz\'"
LOCAL_PATH="/var/dumps/""$APP""/"

mkdir -p "$LOCAL_PATH"
cd "$LOCAL_PATH"
rm backup*.tar.gz
rsync -av -e "ssh -i /root/.ssh/bamboo -p2209" bamboo@lab.sourcefabric.org:$REMOTE_PATH $LOCAL_PATH
tar xvf backup*.tar.gz
ls -laho

