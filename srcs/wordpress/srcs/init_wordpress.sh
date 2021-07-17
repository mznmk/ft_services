#!/bin/sh

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "wordpress"'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "wordpress"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# install wordpress (first time only)
if [ ! "$(ls -A /var/www/wordpress)" ]; then
	# install wordpress & set wordpress config
	tar xzf /tmp/latest.tar.gz --strip-components=1 -C /var/www/wordpress/
	rm /tmp/latest.tar.gz
	mv /tmp/wp-config.php /var/www/wordpress/
	chown -R nginx:nginx /var/www/wordpress

	# modify wordpress setting
	sed -i -e "s/'DB_NAME', 'database_name_here'/'DB_NAME', '${WORDPRESS_DB_NAME}'/" /var/www/wordpress/wp-config.php
	sed -i -e "s/'DB_USER', 'username_here'/'DB_USER', '${WORDPRESS_DB_USER}'/" /var/www/wordpress/wp-config.php
	sed -i -e "s/'DB_PASSWORD', 'password_here'/'DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}'/" /var/www/wordpress/wp-config.php

	# install wordpress contents
	until wp core install --allow-root \
		--url=https://192.168.49.50:5050 \
		--title=$WORDPRESS_TITLE \
		--admin_user=$WORDPRESS_ADMIN_NAME \
		--admin_password=$WORDPRESS_ADMIN_PASS \
		--admin_email=$WORDPRESS_ADMIN_MAIL \
		--path=/var/www/wordpress; do
		sleep 3
	done

	# create wordpress user1
	wp user create --allow-root \
		$WORDPRESS_USER1_NAME \
		$WORDPRESS_USER1_MAIL \
		--role=editor \
		--user_pass=$WORDPRESS_USER1_PASS \
		--path=/var/www/wordpress
	# create wordpress user2
	wp user create --allow-root \
		$WORDPRESS_USER2_NAME \
		$WORDPRESS_USER2_MAIL \
		--role=author \
		--user_pass=$WORDPRESS_USER2_PASS \
		--path=/var/www/wordpress
	# create wordpress user3
	wp user create --allow-root \
		$WORDPRESS_USER3_NAME \
		$WORDPRESS_USER3_MAIL \
		--role=contributor \
		--user_pass=$WORDPRESS_USER3_PASS \
		--path=/var/www/wordpress
	# create wordpress user4
	wp user create --allow-root \
		$WORDPRESS_USER4_NAME \
		$WORDPRESS_USER4_MAIL \
		--role=subscriber \
		--user_pass=$WORDPRESS_USER4_PASS \
		--path=/var/www/wordpress
fi

# start php-fpm
php-fpm7

# avoid Nginx to be daemon
nginx -g "daemon off;"
