cat <<EOF

# custom parameters
server_url: $domain
embed_server_url: $domain
embed_server_host: $domain
db_internationalization.database_url: mysql+mysqlconnector://$instance:$dbpassword@localhost/$instance?unix_socket=/var/run/mysqld/mysqld.sock
db_security.database_url: mysql+mysqlconnector://$instance:$dbpassword@localhost/$instance?unix_socket=/var/run/mysqld/mysqld.sock
db_superdesk.database_url: mysql+mysqlconnector://$instance:$dbpassword@localhost/$instance?unix_socket=/var/run/mysqld/mysqld.sock
thumbnailProcessor.ThumbnailProcessorGM.gm_path: /usr/bin/gm
EOF
