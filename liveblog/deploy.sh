#!/bin/sh

[ -z $2 ] && echo "Usage: $0 instance_name src_path" && exit 1

(
cd ally-py &&
./build-eggs &&
cd superdesk &&
./build-eggs
) &&

bash /var/opt/instances/scripts/instance_update.sh $1 $2
