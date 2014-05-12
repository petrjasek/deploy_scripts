#!/bin/sh

[ "$2" = "" ] && echo "Usage: $0 instance_name /path/to/python/file [param]" && exit 1

instance_root="/var/opt/apy_instances/""$1"

cd "$instance_root"/workspace
export LC_CTYPE="en_US.UTF-8"
. "$instance_root"/env/bin/activate
exec python $2 $3
