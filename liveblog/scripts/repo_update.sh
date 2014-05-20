#!/bin/sh

. /var/opt/instances/scripts/functions
[ "$root" = "" ] && exit 1

cd $repo_allypy
git branch -a
cd $repo_superdesk
git branch -a


[ "$1" = "" ] || [ "$2" = "" ] && echo "Usage: $0 allypy_branch_name superdesk_branch_name" && exit 1

cd $repo_allypy
git pull --all
git remote prune origin
git checkout $1
git pull --all
./build-eggs

cd $repo_superdesk
git pull --all
git remote prune origin
git checkout $2
git pull --all
./build-eggs

exit 0
