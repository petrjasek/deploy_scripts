#!/bin/sh

APP="$bamboo_app"
DEVELOPER="$bamboo_developer"
PORT="$bamboo_port"

REMOTE_PATH="\'/var/www/""$APP""-prelive/backup/backup-*.tar.gz\'"
LOCAL_PATH="/var/dumps/""$APP""/backup.tar.gz"

rsync -a --rsh="ssh -p$PORT " --rsync-path="sudo rsync" "$REMOTE_PATH" lab@"$DEVELOPER".sourcefabric.net:"$LOCAL_PATH"

