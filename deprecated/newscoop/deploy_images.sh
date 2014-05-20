#!/bin/sh

APP="$bamboo_app"
DEVELOPER="$bamboo_developer"

#default image folders:
IMG_FOLDER="images"
SRC_PATH="/var/dumps/""$APP""_images/images"

test "$BRANCH" = 'wobs-stable' && IMG_FOLDER="images_prelive"
test $APP = "tw" && SRC_PATH="/var/dumps/""$APP""_images/""$BRANCH""/images/"

DEST_PATH="/var/www/$APP/$DEVELOPER/$IMG_FOLDER"

rsync -av $SRC_PATH $DEST_PATH

