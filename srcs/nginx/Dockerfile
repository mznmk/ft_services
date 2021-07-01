# Base Image
FROM	alpineplus

# Label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# Install Nginx
# Install OpenSSL
RUN		apk --no-cache add nginx; \
		apk --no-cache add openssl;

# Create Working Directory
RUN		mkdir -p /run/nginx

# Copy Setting Data
COPY	./srcs/nginx.conf /etc/nginx/
COPY	./srcs/default.conf /etc/nginx/conf.d/

# Copy Contents Data
COPY	./srcs/index.html /var/www/
RUN		chown -R nginx:nginx /var/www

# Copy Init Script
COPY	./srcs/init_nginx.sh /
RUN		chmod +x /init_nginx.sh

# Run Init Command
ENTRYPOINT [ "/init_nginx.sh" ]
