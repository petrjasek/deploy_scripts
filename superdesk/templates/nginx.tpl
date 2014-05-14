cat <<EOF
upstream $INSTANCE {
	server 127.0.0.1:$PORT;
}
 
server {
	listen          $NGINX_PORT;
	server_name     $URL;
	access_log      /var/log/nginx/$URL.access.log combined;

	location /api/ {
		proxy_pass      http://$INSTANCE;
		proxy_redirect http://$INSTANCE https://$URL;
	}

    location / {
        root /var/opt/superdesk_instances/$INSTANCE/frontend/dist;
    }

}
EOF
