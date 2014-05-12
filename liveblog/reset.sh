#/bin/sh

[ -z $1 ] && echo "Usage: $0 instance_name" && exit 1

bash /var/opt/instances/scripts/instance_delete.sh "$1"
bash /var/opt/instances/scripts/instance_create.sh "$1" "$1".lb-test.sourcefabric.org

