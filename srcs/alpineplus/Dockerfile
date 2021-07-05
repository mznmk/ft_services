# Base Image
FROM	alpine:3.13

# Label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# Update Alpine Linux
# Install openssl
# Install openrc
# Install wget curl
# Install telegraf
RUN		apk --no-cache update; \
		apk --no-cache add openrc; \
		apk --no-cache add openssl; \
		apk --no-cache add telegraf; \
		apk --no-cache add wget curl;

# Create Working Directory
RUN		mkdir -p /run/openrc/; \
		touch /run/openrc/softlevel;

# Copy Setting Data
COPY	srcs/telegraf.conf /etc/telegraf.conf

# Create SSL/TLS Key
RUN		mkdir -p /etc/ssl/selfcerts/; \
		openssl req -x509 -nodes -new -days 7 \
			-subj "/C=JP/ST=Tokyo/L=Shibuya/CN=ft_services.com" \
			-keyout /etc/ssl/selfcerts/ft_services.key -out /etc/ssl/selfcerts/ft_services.crt; \
		chmod 400 /etc/ssl/selfcerts/ft_services.key; \
		chmod 400 /etc/ssl/selfcerts/ft_services.crt;

# Working Directory
WORKDIR /
