#!/bin/sh

###Environment variables:###################
# BRANCH=${bamboo.planRepository.branchName}
#############################################

. ./deploy_scripts/nsc/functions.sh

APP="$bamboo_app"
DEVELOPER="$bamboo_developer"
BRANCH=$(url_safe "$BRANCH")

BACKUP_PATH="/var/dumps/""$APP"
INSTALL_DIR="/var/www/""$APP"/
IMG_SRC="$BACKUP_PATH"/backup-*/images
FILES_SRC="$BACKUP_PATH"/backup-*/files

PASSWORD="$bamboo_password"
DBUSER="$APP"_"$BRANCH"
DBNAME="$DBUSER"_db
DBUSER=$(echo "$DBUSER" | md5sum | awk '{print substr($0,0,15)}') # first 16 symbols of md5 hash
DUMP_FILE=lab_"$APP"-prelive-database.sql
test $APP == "zentralplus" && DUMP_FILE=lab_zug-database.sql
OLD_URL=$APP"-prelive.lab.sourcefabric.org"


cd $BACKUP_PATH
rm -fr backup-*
tar xvf backup.tar.gz
rsync -a --protect-args --rsync-path="sudo rsync" $IMG_SRC $INSTALL_DIR
rsync -a --protect-args --rsync-path="sudo rsync" $FILES_SRC $INSTALL_DIR
chown -R www-data $INSTALL_DIR

mysql -p$PASSWORD -e "SET GLOBAL general_log = 'OFF';"

echo "drop database \`$DBNAME\` ;"
mysql -p$PASSWORD  -e "drop database \`$DBNAME\` ;"

echo "create database \`$DBNAME\` ;"
mysql -p$PASSWORD  -e "create database \`$DBNAME\` ;"

echo "grant all privileges on \`$DBNAME\`.* to \`$DBUSER\`@\`localhost\` identified by '$DBUSER' with grant option;"
mysql -p$PASSWORD  -e "grant all privileges on \`$DBNAME\`.* to \`$DBUSER\`@\`localhost\` identified by '$DBUSER' with grant option;"

cd backup-*
echo "mysql $DBNAME < $DUMP_FILE"
mysql -p$PASSWORD  $DBNAME < $DUMP_FILE

#echo "INSERT INTO Aliases (\`Id\`, \`Name\`, \`IdPublication\`) VALUES (NULL, '$BRANCH.$DEVELOPER.newscoop-test.sourcefabric.org', '2');"
#mysql $DBNAME -e "INSERT INTO Aliases (\`Id\`, \`Name\`, \`IdPublication\`) VALUES (NULL, '$BRANCH.$DEVELOPER.newscoop-test.sourcefabric.org', '2');"

echo " UPDATE Aliases SET Name='$BRANCH.$APP.$DEVELOPER.sourcefabric.net' WHERE Name='$OLD_URL'"
mysql -p$PASSWORD  $DBNAME -e "UPDATE Aliases SET Name='$BRANCH.$APP.$DEVELOPER.sourcefabric.net' WHERE Name='$OLD_URL'"

