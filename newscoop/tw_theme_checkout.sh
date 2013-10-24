#!/bin/sh

#default:
THEMES_BRANCH='dev-themes'
#for stable branch:
test "$BRANCH" = 'wobs-stable' && THEMES_BRANCH='stable-themes'

git clone ssh://git@stash.sourcefabric.org:7999/tw/tages-woche-themes.git themes ;

cd themes
git checkout "$THEMES_BRANCH" &&
git pull origin "$THEMES_BRANCH"

