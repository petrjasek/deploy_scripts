cat <<EOF
        ),
	Host(
    	    name="$instance",
    	    matching="$domain",
    	    routes={
		'/resources/': Handler(
    		    send_spec='ipc://run/send-$instance',
    		    send_ident='$instance',
    		    recv_spec='ipc://run/recv-$instance',
    		    recv_ident=''
		)
    	    '/content/': Dir(
    		    base='instances/$container/distribution/workspace/shared/cdm/',
    		    index_file='/lib/core/start.html',
    		    default_ctype='text/plain'
		)
            '/': Dir(
                    base='www/$instance/',
                    index_file='/index.html',
                    default_ctype='text/plain'
                )
    	    }
EOF
