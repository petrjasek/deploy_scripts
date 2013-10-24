#!/bin/sh

#default path for tw:
test $APP = "tw" && REMOTE_PATH="/var/www/tw-reloaded/images"
test "$BRANCH" = 'wobs-stable' && REMOTE_PATH="/var/www/tw-pre-live/images"

test $APP = "tw" && LOCAL_PATH="/var/dumps/""$APP""_images/""$BRANCH"

mkdir -p "$LOCAL_PATH"
rsync -av -e "ssh -i /root/.ssh/bamboo -p2209" bamboo@lab.sourcefabric.org:$REMOTE_PATH $LOCAL_PATH --exclude=image_cache

