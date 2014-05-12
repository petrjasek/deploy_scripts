#!/bin/sh

. /var/opt/apy_instances/scripts/functions

[ "$root" = "" ] && exit 1
[ "$2" = "" ] && echo "Usage: $0 instance_number domain" && exit 1

instance=$1
domain=$2

container=$instance
dbpassword=`tr -dc A-Za-z0-9 < /dev/urandom | head -c 16 | xargs`

allypy=$instances_root/$container/
workspace="$allypy"/workspace

# create autostart config
echo container=$container > $instances_root/system/start/$instance
echo domain=$domain >> $instances_root/system/start/$instance
echo dbpassword=$dbpassword >> $instances_root/system/start/$instance
ln -s $instances_root/system/start/$instance $start_folder/$instance

# reload webserver config
/etc/init.d/mongrel2 reload

# create application config
. $scripts/files/application.properties.tpl >> $workspace/application.properties
. $scripts/files/plugins.properties.tpl >> $workspace/plugins.properties

# create database
. $scripts/files/db_init.tpl | mysql -uroot -p$dbrootpassword

# create redirection startpage
mkdir -p /var/www/apy/$container
. $scripts/files/index.html.tpl > /var/www/apy/$container/index.html

exit 0
