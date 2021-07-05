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

# Install phpmyadmin
RUN		wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz -P /tmp; \
		mkdir -p /var/www/phpmyadmin/; \
		tar xzf /tmp/phpMyAdmin-5.0.4-all-languages.tar.gz --strip-components=1 -C /var/www/phpmyadmin/; \
		rm /tmp/phpMyAdmin-5.0.4-all-languages.tar.gz;

# Create Working Directory
RUN		mkdir -p /run/nginx
RUN		mkdir -p /run/php-fpm

# Copy Setting Data
COPY	./srcs/default.conf /etc/nginx/conf.d/
COPY	./srcs/www.conf /etc/php7/php-fpm.d/
COPY	./srcs/config.inc.php /var/www/phpmyadmin/
RUN		chown -R nginx:nginx /var/www/phpmyadmin/

# Copy LivenessProbe Script
COPY	./srcs/livenessprobe.sh /tmp/

# Copy Init Script
COPY	./srcs/init_phpmyadmin.sh /tmp/
RUN		chmod +x /tmp/init_phpmyadmin.sh

# Run Init Command
ENTRYPOINT	[ "/tmp/init_phpmyadmin.sh" ]
