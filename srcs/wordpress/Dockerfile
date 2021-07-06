# Base Image
FROM	alpineplus

# Label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# Install nginx
# Install php
RUN		apk --no-cache add nginx; \
		apk --no-cache add php7 fcgi; \
		apk --no-cache add php7-cgi php7-common php7-ctype php7-curl php7-dom php7-fpm \
							php7-gd php7-gettext php7-iconv php7-imap php7-json php7-ldap \
							php7-mbstring php7-mcrypt php7-mysqli \
							php7-pdo php7-pdo_mysql php7-phar php7-posix \
							php7-session php7-soap php7-xml php7-xmlrpc

# Install wordpress
RUN		wget https://wordpress.org/latest.tar.gz -P /tmp; \
		mkdir -p /var/www/wordpress/; \
		tar xzf /tmp/latest.tar.gz --strip-components=1 -C /var/www/wordpress/; \
		rm /tmp/latest.tar.gz;

# install wp-cli
RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /tmp; \
		chmod +x /tmp/wp-cli.phar; \
		mv /tmp/wp-cli.phar /usr/local/bin/wp

# Create Working Directory
RUN		mkdir -p /run/nginx; \
		mkdir -p /run/php-fpm;

# Copy Setting Data
COPY	./srcs/default.conf /etc/nginx/conf.d/
COPY	./srcs/www.conf /etc/php7/php-fpm.d/
COPY	./srcs/wp-config.php /var/www/wordpress/
RUN		chown -R nginx:nginx /var/www/wordpress/

# Copy LivenessProbe Script
COPY	./srcs/livenessprobe.sh /tmp/

# Copy Init Script
COPY	./srcs/init_wordpress.sh /tmp/
RUN		chmod +x /tmp/init_wordpress.sh

# Run Init Command
ENTRYPOINT	[ "/tmp/init_wordpress.sh" ]
