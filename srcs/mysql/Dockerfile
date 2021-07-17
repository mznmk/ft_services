# base image
FROM	alpineplus

# label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# install mysql
RUN		apk --no-cache add mysql

# copy setting data
COPY	./srcs/mariadb-server.cnf /etc/my.cnf.d/

# copy LivenessProbe script
COPY	./srcs/livenessprobe.sh /tmp/

# copy init script
COPY	./srcs/init_mysql.sh /tmp/
RUN		chmod +x /tmp/init_mysql.sh

# run init command
ENTRYPOINT	[ "sh", "/tmp/init_mysql.sh" ]
