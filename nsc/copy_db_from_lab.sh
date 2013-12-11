#!/bin/sh

APP="$bamboo_app"
DEVELOPER="$bamboo_developer"
PORT="$bamboo_port"

REMOTE_PATH="/var/www/""$APP""-prelive/backup/backup-*.tar.gz"
LOCAL_PATH="/var/dumps/""$APP""/backup.tar.gz"

ssh -p$PORT lab@"$DEVELOPER".sourcefabric.net -x "mkdir -p /var/dumps/$APP"
echo rsync -a --rsh="ssh -p$PORT" --protect-args --rsync-path="sudo rsync" $REMOTE_PATH lab@"$DEVELOPER".sourcefabric.net:"$LOCAL_PATH"
rsync -a --rsh="ssh -p$PORT" --protect-args --rsync-path="sudo rsync" $REMOTE_PATH lab@"$DEVELOPER".sourcefabric.net:"$LOCAL_PATH"

