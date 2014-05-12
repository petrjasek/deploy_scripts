cat <<EOF
CREATE USER '$instance'@'localhost' IDENTIFIED BY '$dbpassword';
GRANT USAGE ON * . * TO '$instance'@'localhost' IDENTIFIED BY '$dbpassword';
CREATE DATABASE IF NOT EXISTS $instance;
GRANT ALL PRIVILEGES ON $instance . * TO '$instance'@'localhost';
EOF