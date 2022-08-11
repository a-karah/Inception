#!bin/sh

if [ ! -f /var/www/wordpress/wp-config.php ]; then

	sleep 5;

	if ! mysqladmin -h $DB_HOST -u $DB_USER --password=$DB_PASSWORD --wait=60 ping > /dev/null; then
		printf "Database is not started\n"
		exit 1
	fi

	cd /var/www/wordpress

	wp core config	--dbhost=$DB_HOST \
					--dbname=$DB_NAME \
					--dbuser=$DB_USER \
					--dbpass=$DB_PASSWORD \
					--allow-root

	wp core install --title=$WP_TITLE \
					--admin_user=$WP_ADMIN_USER \
					--admin_password=$WP_ADMIN_PASSWORD \
					--admin_email=$WP_ADMIN_MAIL \
					--url=$WP_URL \
					--allow-root

	wp user create $WP_USER $WP_USER_MAIL \
					--role=author \
					--user_pass=$WP_USER_PASSWORD \
					--allow-root

	cd -
fi

# run php-fpm7 listening for CGI request
exec php-fpm7 --nodaemonize
