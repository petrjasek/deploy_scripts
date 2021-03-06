cat <<EOF
[program:superdesk_$INSTANCE]
directory=$INSTANCE_ROOT/backend
command=$INSTANCE_ROOT/env/bin/python $INSTANCE_ROOT/env/bin/gunicorn wsgi -w 4 -b 127.0.0.1:$PORT
environment=PATH="$INSTANCE_ROOT/env/bin:$PATH",SUPERDESK_SERVER_NAME="$URL",SUPERDESK_URL_PREFIX="api",MONGO_DBNAME="superdesk_$INSTANCE"
stdout_logfile=$LOG_PATH/stdout
stderr_logfile=$LOG_PATH/stderr
EOF
