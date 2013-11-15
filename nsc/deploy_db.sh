#!/bin/sh

APP="$bamboo_app"

BACKUP_PATH="/var/dumps/""$APP""/"

cd $BACKUP_PATH
tar xvf backup.tar.gz
ls -laho
