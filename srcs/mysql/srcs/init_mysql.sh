#!/bin/sh

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "mysql-service"'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "mysql"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# Create MySQL Database
# (if Database don't exist)
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE_NAME}" ]; then
	# create mysql directory
	mysql_install_db --user=root > /dev/null
	# use mysql
	echo "USE mysql ;" >> init_db.sql
	# user: root
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;" >> init_db.sql
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" >> init_db.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '';" >> init_db.sql
	echo "FLUSH PRIVILEGES ;" >> init_db.sql
	# create database
	echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;" >> init_db.sql
	echo "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE_NAME}.* TO ${MYSQL_USER_NAME}@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}' ;" >> init_db.sql
	echo "FLUSH PRIVILEGES ;" >> init_db.sql
	# run sql script
	/usr/bin/mysqld --user=root --bootstrap < init_db.sql
	# delete sql script file
	rm -f init_db.sql
fi

# Start MySQL
/usr/bin/mysqld --user=root
