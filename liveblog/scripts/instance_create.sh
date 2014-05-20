#!/bin/sh

. /var/opt/instances/scripts/functions
[ "$root" = "" ] && exit 1

[ "$1" = "" ] || [ "$2" = "" ] && echo "Usage: $0 instance_number domain" && exit 1

instance=$1
domain=$2
container=$1
dbpassword=`tr -dc A-Za-z0-9 < /dev/urandom | head -c 16 | xargs`
allypy=$instances_root/$container/distribution

[ -f $start_folder/$instance ] && echo "ERROR! Conf file for instance $instance exists" && exit 1
[ -d $instances_root/$container ] && echo "ERROR! Instance $instance is installed already" && exit 1

echo container=$container > $instances_root/system/start/$instance
echo domain=$domain >> $instances_root/system/start/$instance
echo dbpassword=$dbpassword >> $instances_root/system/start/$instance

ln -s $instances_root/system/start/$instance $start_folder/$instance

mkdir -p $instances_root/$container
mkdir -p $instances_root/$container/dbdump
rsync -a $repo_superdesk/distribution/ $allypy/

create_properties

. $scripts/files/db_init.tpl | mysql -uroot -p$dbrootpassword

python3 $allypy/application.py -repair

/etc/init.d/ally-py start $instance
/etc/init.d/mongrel2 reload

post_create

exit 0
