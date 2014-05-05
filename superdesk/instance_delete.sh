#!/bin/sh

. /var/opt/instances/scripts/functions
[ "$root" = "" ] && exit 1

[ "$1" = "" ] && echo "Usage: $0 instance_number" && exit 1
if [ -f $start_folder/$1 ]; then
    instance=$1
else
    instance=`cd $start_folder && grep "domain=$1" * -l`
fi
[ ! -f $start_folder/$instance ] && echo "ERROR! Conf file for instance $1 desn't exist" && exit 1

. $start_folder/$instance
[ ! -d $instances_root/$container ] && echo "ERROR! Instance $1 isn't installed" && exit 1


# remove autostart config
unlink $start_folder/$instance
unlink $instances_root/system/start/$instance

# reload webserver config
/etc/init.d/mongrel2 reload

# remove root folder
rm -r $instances_root/$container/

# remove database
echo "DROP USER '$instance'@'localhost';" | mysql -uroot -p$dbrootpassword
echo "DROP DATABASE $instance;" | mysql -uroot -p$dbrootpassword

# remove redirection startpage
rm -r /var/www/apy/$container

exit 0
