cat <<EOF

# custom parameters
server_url: $domain
embed_server_url: $domain
thumbnailProcessor.ThumbnailProcessorGM.gm_path: /usr/bin/gm
#database_url: mysql+mysqlconnector://apy$instance:$dbpassword@localhost/apy$instance?unix_socket=/var/run/mysqld/mysqld.sock
EOF
