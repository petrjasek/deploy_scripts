cat <<EOF
upstream superdesk_$INSTANCE {
	server 127.0.0.1:$PORT;
}
 
server {
	listen          $NGINX_PORT;
	server_name     $URL;
	access_log      $LOG_PATH/access.log combined;
	error_log      $LOG_PATH/error.log;

	location /api {
		proxy_pass      http://superdesk_$INSTANCE;
		proxy_redirect http://superdesk_$INSTANCE https://$URL;
	}

	location / {
		root /var/opt/superdesk_instances/$INSTANCE/frontend/dist;
	}

}
EOF
