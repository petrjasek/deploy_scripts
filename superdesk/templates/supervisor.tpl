cat <<EOF
[program:$INSTANCE]
directory=$INSTANCE_ROOT/backend
command=$INSTANCE_ROOT/env/bin/python $INSTANCE_ROOT/env/bin/gunicorn wsgi -w 4 -b 127.0.0.1:$PORT
environment=PATH="$INSTANCE_ROOT/env/bin:$PATH",SERVER_NAME="$URL",URL_PREFIX="/api/"
EOF
