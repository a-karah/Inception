#!/bin/sh -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Creating data folder"

	mysql_install_db --datadir=/var/lib/mysql --user=mysql
else
	chown -R mysql:mysql /var/lib/mysql
fi

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
	echo "Creating database --${DB_NAME}--"
	rc-service mariadb start

	mysql -u root -e "DROP DATABASE IF EXISTS test;"
	mysql -u root -e "DELETE FROM mysql.user WHERE User=''";
	mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
	mysql -u root -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
	mysql -u root -e "FLUSH PRIVILEGES;"
	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"

	rc-service mariadb stop
fi

mysqld_safe -u mysql --datadir=/var/lib/mysql