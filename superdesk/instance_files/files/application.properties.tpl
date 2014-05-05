cat <<EOF

root_uri_resources: api

# custom parameters
headers_no_cache:
  Cache-Control:
  - no-cache

server_type: mongrel2
recv_ident: $instance
recv_spec: ipc:///var/opt/run/recv-apy$instance
send_ident: $instance
send_spec: ipc:///var/opt/run/send-apy$instance
workspace_path: /var/opt

application_mode: devel
EOF
