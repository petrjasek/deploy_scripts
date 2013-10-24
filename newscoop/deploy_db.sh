#!/bin/sh

#BRANCH=${bamboo.planRepository.branchName}

APP="$bamboo_app"
DEVELOPER="$bamboo_developer"
WORKDIR=$(pwd)
DBUSER="$APP"_"$DEVELOPER"_"$BRANCH"
DBNAME="$DBUSER"_db
DBUSER=$(echo "$DBUSER" | md5sum | awk '{print substr($0,0,15)}')

test "$APP" = 'tw' && DUMP_FILE="/var/dumps/lab_tw-reloaded.sql"
test "$APP" = 'tw' && OLD_URL="tw-reloaded.lab.sourcefabric.org"
test "$BRANCH" = 'wobs-stable' && DUMP_FILE="/var/dumps/lab_pre-live.sql"
test "$BRANCH" = 'wobs-stable' && OLD_URL="tw-pre-live.lab.sourcefabric.org"

mysql -e "SET GLOBAL general_log = 'OFF';"

echo "drop database \`$DBNAME\` ;"
mysql -e "drop database \`$DBNAME\` ;"

echo "create database \`$DBNAME\` ;"
mysql -e "create database \`$DBNAME\` ;"

echo "grant all privileges on \`$DBNAME\`.* to \`$DBUSER\`@\`localhost\` identified by '$DBUSER' with grant option;"
mysql -e "grant all privileges on \`$DBNAME\`.* to \`$DBUSER\`@\`localhost\` identified by '$DBUSER' with grant option;"

echo "mysql $DBNAME < $DUMP_FILE"
mysql $DBNAME < $DUMP_FILE

#echo "INSERT INTO Aliases (\`Id\`, \`Name\`, \`IdPublication\`) VALUES (NULL, '$BRANCH.$DEVELOPER.newscoop-test.sourcefabric.org', '2');"
#mysql $DBNAME -e "INSERT INTO Aliases (\`Id\`, \`Name\`, \`IdPublication\`) VALUES (NULL, '$BRANCH.$DEVELOPER.newscoop-test.sourcefabric.org', '2');"

echo " UPDATE Aliases SET Name='$BRANCH.$DEVELOPER.$APP.newscoop-test.sourcefabric.org' WHERE Name='$OLD_URL'"
mysql $DBNAME -e "UPDATE Aliases SET Name='$BRANCH.$DEVELOPER.$APP.newscoop-test.sourcefabric.org' WHERE Name='$OLD_URL'"

