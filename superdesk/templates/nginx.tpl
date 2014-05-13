cat <<EOF
upstream $INSTANCE {
	server 127.0.0.1:$PORT;
}
 
server {
	listen          $NGINX_PORT;
	server_name     $URL;
	access_log      /var/log/nginx/$URL.access.log combined;

	location / {
		proxy_pass      http://$INSTANCE;
	}
}
EOF
