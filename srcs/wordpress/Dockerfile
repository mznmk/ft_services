# base image
FROM	alpineplus

# label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# install nginx
# install php
RUN		apk --no-cache add nginx; \
		apk --no-cache add php7 fcgi; \
		apk --no-cache add php7-cgi php7-common php7-ctype php7-curl php7-dom php7-fpm \
							php7-gd php7-gettext php7-iconv php7-imap php7-json php7-ldap \
							php7-mbstring php7-mcrypt php7-mysqli \
							php7-pdo php7-pdo_mysql php7-phar php7-posix \
							php7-session php7-soap php7-xml php7-xmlrpc

# install wp-cli
RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /tmp; \
		chmod +x /tmp/wp-cli.phar; \
		mv /tmp/wp-cli.phar /usr/local/bin/wp

# download wordpress (download only)
RUN		wget https://wordpress.org/latest.tar.gz -P /tmp/; \
		mkdir -p /var/www/wordpress/

# create working directory
RUN		mkdir -p /run/nginx; \
		mkdir -p /run/php-fpm;

# copy setting data
COPY	./srcs/default.conf /etc/nginx/conf.d/
COPY	./srcs/www.conf /etc/php7/php-fpm.d/
COPY	./srcs/wp-config.php /tmp/

# copy LivenessProbe script
COPY	./srcs/livenessprobe.sh /tmp/

# copy init script
COPY	./srcs/init_wordpress.sh /tmp/
RUN		chmod +x /tmp/init_wordpress.sh

# run init command
ENTRYPOINT	[ "sh", "/tmp/init_wordpress.sh" ]
