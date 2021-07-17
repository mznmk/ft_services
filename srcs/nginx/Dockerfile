# base image
FROM	alpineplus

# label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# install Nginx
RUN		apk --no-cache add nginx;

# create working directory
RUN		mkdir -p /run/nginx

# copy setting data
COPY	./srcs/default.conf /etc/nginx/conf.d/

# copy contents data
COPY	./srcs/index.html /var/www/
RUN		chown -R nginx:nginx /var/www

# copy LivenessProbe script
COPY	./srcs/livenessprobe.sh /tmp/

# copy init script
COPY	./srcs/init_nginx.sh /tmp/
RUN		chmod +x /tmp/init_nginx.sh

# run init command
ENTRYPOINT [ "/tmp/init_nginx.sh" ]
