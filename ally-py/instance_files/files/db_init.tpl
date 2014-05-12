cat <<EOF
CREATE USER 'apy$instance'@'localhost' IDENTIFIED BY '$dbpassword';
GRANT USAGE ON * . * TO 'apy$instance'@'localhost' IDENTIFIED BY '$dbpassword';
CREATE DATABASE IF NOT EXISTS apy$instance;
GRANT ALL PRIVILEGES ON apy$instance . * TO 'apy$instance'@'localhost';
EOF
