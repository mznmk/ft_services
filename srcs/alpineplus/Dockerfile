# base image
FROM	alpine:3.13

# label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# update alpine linux
# install openrc
# install openssh
# install openssl
# install wget curl
# install telegraf
RUN		apk --no-cache update; \
		apk --no-cache add openrc; \
		apk --no-cache add openssh; \
		apk --no-cache add openssl; \
		apk --no-cache add telegraf; \
		apk --no-cache add wget curl;

# create working directory
RUN		mkdir -p /run/openrc/; \
		touch /run/openrc/softlevel;

# copy setting data
COPY	srcs/telegraf.conf /etc/telegraf.conf

# create SSL/TLS key
RUN		mkdir -p /etc/ssl/selfcerts/; \
		openssl req -x509 -nodes -new -days 7 \
			-subj "/C=JP/ST=Tokyo/L=Shibuya/CN=ft_services.com" \
			-keyout /etc/ssl/selfcerts/ft_services.key -out /etc/ssl/selfcerts/ft_services.crt; \
		chmod 400 /etc/ssl/selfcerts/ft_services.key; \
		chmod 400 /etc/ssl/selfcerts/ft_services.crt;
