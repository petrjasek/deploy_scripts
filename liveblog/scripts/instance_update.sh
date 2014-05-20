#!/bin/bash

. /var/opt/instances/scripts/functions
[ "$root" = "" ] && exit 1

[ "$1" = "" ] && echo "Usage: $0 instance_number|instance_domain [path_to_superdesk_repo]" && exit 1

if [ ! "$2" = "" ]; then
    repo_superdesk=$2
    [ ! -d $repo_superdesk/distribution ] && echo "ERROR! Superdesk repo $repo_superdesk doesn't exist" && exit 1
fi

if [ -f $start_folder/$1 ]; then
    instance=$1
else
    instance=`cd $start_folder && grep "domain=$1" * -l`
fi

[ ! -f $start_folder/$instance ] && echo "ERROR! Conf file for instance $1 desn't exist" && exit 1

. $start_folder/$instance
allypy=$instances_root/$container/distribution

[ ! -d $instances_root/$container ] && echo "ERROR! Instance $instance isn't installed" && exit 1

for file in `find  $instances_root/$container/distribution/workspace/shared | grep __pycache__`; do [ -f $file ] && unlink $file; done

instance_backup

rsync -a $repo_superdesk/distribution/ $instances_root/$container/distribution/

file=$instances_root/$container/distribution/distribution.properties
mv  $file  $file.bak
cat $file.bak | while read string; do
    if [[ ! $string =~ gui ]]; then
        echo $string >> $file
    fi
done

create_properties

/etc/init.d/ally-py stop $instance
python3 $instances_root/$container/distribution/application.py -repair
/etc/init.d/ally-py start $instance

post_update

exit 0
