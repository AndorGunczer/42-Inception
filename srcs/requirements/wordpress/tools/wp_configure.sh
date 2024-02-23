#!/bin/bash

# Install Wordpress
curl -o /usr/bin/wp -0 https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /usr/bin/wp

wp core download --allow-root

wp core config \
    --dbhost="mariadb" \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --prompt=$MYSQL_PASSWORD \
    --allow-root

wp core install \
    --url=localhost \
    --title="website" \
    --admin_user=$MYSQL_USER \
    --admin_password=$MYSQL_PASSWORD \
    --admin_email=info@wp-cli.org \
    --allow-root

www_conf_file="/etc/php/8.3/fpm/pool.d/www.conf"

config="[www]\n\
user = www-data\n\
group = www-data\n\
listen = 0.0.0.0:9000\n\
pm = dynamic\n\
pm.max_children = 5\n\
pm.start_servers = 2\n\
pm.min_spare_servers = 1\n\
pm.max_spare_servers = 3\n\
chdir = /\n\
php_admin_value[error_log] = /var/log/php8.3-fpm.log\n\
php_admin_flag[log_errors] = on\n\
php_admin_value[upload_max_filesize] = 100M\n\
php_admin_value[post_max_size] = 100M\n\
security.limit_extensions = .php .php3 .php4 .php5 .php7 .php8"

sed -i "s|.*|${config}|g" "$www_conf_file"

/usr/sbin/php-fpm8.3 -F

# https://stackoverflow.com/questions/19101243/error-1130-hy000-host-is-not-allowed-to-connect-to-this-mysql-server
# https://make.wordpress.org/cli/handbook/guides/installing/