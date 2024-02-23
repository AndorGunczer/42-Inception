#!/bin/bash

echo "here"
service mariadb start
echo "here 1"

sed -i "s|skip-networking|# skip-networking|g" /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

sed -i '/\[client-server\]/a\
            port = 3306\n\
            # socket = /run/mysqld/mysqld.sock\n\
            \n\
            !includedir /etc/mysql/conf.d/\n\
            !includedir /etc/mysql/mariadb.conf.d/\n\
            \n\
            [mysqld]\n\
            user = root\n\
            \n\
            [server]\n\
            bind-address = 0.0.0.0' /etc/mysql/my.cnf

echo "CNF File Modified"

mariadb -u root -e "alter user 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD'";
mariadb -u root -e "CREATE DATABASE wpdb";
mariadb -u root -e "CREATE USER 'wpuser'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'";
mariadb -u root -e "GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'";
mariadb -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'";
mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'";
mariadb -u root -e "FLUSH PRIVILEGES";

echo "Database Setup Complete"

mysqladmin shutdown
# exec mysqld_safe
mariadbd --bind-address=0.0.0.0