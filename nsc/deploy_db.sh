#!/bin/sh

APP="$bamboo_app"

BACKUP_PATH="/var/dumps/""$APP"
INSTALL_DIR="/var/www/""$APP"

IMG_SRC="$BACKUP_PATH"/backup-*/images
IMG_DEST="$INSTALL_DIR"/images

FILES_SRC="$BACKUP_PATH"/backup-*/files
FILES_DEST="$INSTALL_DIR"/files

cd $BACKUP_PATH
rm -fr backup-*
tar xvf backup.tar.gz
rsync -a --protect-args --rsync-path="sudo rsync" $IMG_SRC $IMG_DEST
rsync -a --protect-args --rsync-path="sudo rsync" $FILES_SRC $FILES_DEST
chown www-data -R $INSTALL_DIR

