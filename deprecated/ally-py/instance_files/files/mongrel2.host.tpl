cat <<EOF
        ),
        Host(
            name="apy$instance",
            matching="$domain",
            routes={
                '/api': Handler(
                    protocol='tnetstring',
                    send_spec='ipc://run/send-apy$instance',
                    send_ident='apy$instance',
                    recv_spec='ipc://run/recv-apy$instance',
                    recv_ident=''
                )
                '/api-test': Handler(
                    protocol='tnetstring',
                    send_spec='ipc://run/send-apy$instance',
                    send_ident='apy$instance',
                    recv_spec='ipc://run/recv-apy$instance',
                    recv_ident=''
                )
                '/api-doc': Dir(
                    base='apy_instances/$instance/doc/_build/html/',
                    index_file='/index.html',
                    default_ctype='text/plain'
                )
                '/content': Dir(
                    base='apy_instances/$instance/workspace/workspace/shared/cdm/',
                    index_file='/index.html',
                    default_ctype='text/plain'
                )
                '/': Dir(
                    base='apy_instances/$instance/superdesk-client/dist/',
                    index_file='/index.html',
                    default_ctype='text/plain'
                )
            }
EOF
