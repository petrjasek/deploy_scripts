#!/bin/sh

[ -z "$1" ] && echo "Usage: $0 instance_name" && exit 1


INSTANCE="$1"
ROOT=/var/opt/superdesk_instances
INSTANCE_ROOT=$ROOT/$INSTANCE


# remove all the instance files
rm -r $INSTANCE_ROOT ;

# remove nginx vhost
(
	rm /etc/nginx/sites-enabled/superdesk_$INSTANCE &&
	service nginx reload
) ;

# remove supervisor config and shut down instance if running
(
	rm /etc/supervisor/conf.d/superdesk_$INSTANCE.conf &&
	supervisorctl reread &&
	supervisorctl update ||
	exit 2
) ;

# remove index page
rm -r /var/www/sd-test/$INSTANCE/ ;

exit 0
