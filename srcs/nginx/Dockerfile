# Base Image
FROM	alpineplus

# Label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# Install Nginx
RUN		apk --no-cache add nginx;

# Create Working Directory
RUN		mkdir -p /run/nginx

# Copy Setting Data
COPY	./srcs/default.conf /etc/nginx/conf.d/

# Copy Contents Data
COPY	./srcs/index.html /var/www/
RUN		chown -R nginx:nginx /var/www

# Copy LivenessProbe Script
COPY	./srcs/livenessprobe.sh /tmp/

# Copy Init Script
COPY	./srcs/init_nginx.sh /tmp/
RUN		chmod +x /tmp/init_nginx.sh

# Run Init Command
ENTRYPOINT [ "/tmp/init_nginx.sh" ]
