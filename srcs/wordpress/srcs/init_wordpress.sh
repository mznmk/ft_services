#!/bin/sh

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "wordpress-service"'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "wordpress"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# # change working directory
# cd /var/www/wordpress/

# modify wordpress setting
sed -i -e s/'database_name_here'/$WORDPRESS_DB_NAME/ /var/www/wordpress/wp-config.php
sed -i -e s/'username_here'/$WORDPRESS_DB_USER/ /var/www/wordpress/wp-config.php
sed -i -e s/'password_here'/$WORDPRESS_DB_PASSWORD/ /var/www/wordpress/wp-config.php

# create wordpress table
until wp core install --allow-root \
	--url=https://192.168.49.50:5050 \
	--title=$WORDPRESS_TITLE \
	--admin_user=$WORDPRESS_ADMIN_NAME \
	--admin_password=$WORDPRESS_ADMIN_PASSWORD \
	--admin_email=$WORDPRESS_ADMIN_MAILADDRESS \
	--path=/var/www/wordpress; do
	sleep 3
done

# create wordpress user
wp user create --allow-root \
	$WORDPRESS_USER1_NAME \
	$WORDPRESS_USER1_MAILADDRESS \
	--role=subscriber \
	--user_pass=u$WORDPRESS_USER1_PASSWORD

# start php-fpm
php-fpm7

# avoid Nginx to be daemon
nginx -g "daemon off;"
