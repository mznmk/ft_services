# Base Image
FROM	alpineplus

# Label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# Install mysql
RUN		apk --no-cache add mariadb;

# Create Working Directory
RUN		mkdir -p /run/mysqld; \
		touch /run/mysqld/mysqld.sock; \
		chown mysql:mysql /run/mysqld/mysqld.sock;

# Copy Setting Data
COPY	./srcs/mariadb-server.cnf /etc/my.cnf.d/

# Copy LivenessProbe Script
COPY	./srcs/livenessprobe.sh /tmp/

# Copy Init Script
COPY	./srcs/init_mysql.sh /tmp/
RUN		chmod +x /tmp/init_mysql.sh

# Run Init Command
ENTRYPOINT	[ "/tmp/init_mysql.sh" ]
