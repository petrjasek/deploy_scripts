cat <<EOF

# custom parameters
headers_no_cache:
  Cache-Control:
  - no-cache

server_type: mongrel2
recv_ident: $instance
recv_spec: ipc:///var/opt/run/recv-$instance
send_ident: $instance
send_spec: ipc:///var/opt/run/send-$instance
workspace_path: /var/opt

excluded_plugins:
- content_article 
- content_packager
- content_publisher

application_mode: normal
EOF