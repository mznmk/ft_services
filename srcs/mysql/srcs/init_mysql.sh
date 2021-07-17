#!/bin/sh

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "mysql"'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "mysql"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# create mysql database
# (if database don't exist)
if [ ! -d /var/lib/mysql/$MYSQL_WP_DB_NAME ]; then
	# create mysql directory
	mysql_install_db --user=root

	# set default database
	echo "USE mysql ;" >> init_db.sql
	echo "FLUSH PRIVILEGES ;" >> init_db.sql
	# set root user
	echo "SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASS}') ;" >> init_db.sql
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASS}' ;" >> init_db.sql
	# create wordpress user
	echo "CREATE USER '${MYSQL_WP_USER_NAME}'@'%' IDENTIFIED BY '${MYSQL_WP_USER_PASS}' ;" >> init_db.sql
	# create wordpress database
	echo "CREATE DATABASE ${MYSQL_WP_DB_NAME} CHARACTER SET utf8;" >> init_db.sql
	echo "GRANT ALL PRIVILEGES ON ${MYSQL_WP_DB_NAME}.* TO ${MYSQL_WP_USER_NAME}@'%' IDENTIFIED BY '${MYSQL_WP_USER_PASS}' ;" >> init_db.sql
	echo "FLUSH PRIVILEGES ;" >> init_db.sql
	# run sql script
	/usr/bin/mysqld --user=root --bootstrap < init_db.sql
	# delete sql script file
	rm -f init_db.sql
fi

# start mysql
/usr/bin/mysqld_safe  --user=root
