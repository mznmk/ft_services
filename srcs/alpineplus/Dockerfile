# Base Image
FROM	alpine:3.13

# Label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# Update Alpine Linux
RUN		apk --no-cache update;

# Install openrc
# Install wget curl
RUN		apk --no-cache add openrc; \
		apk --no-cache add wget curl;

# Create Working Directory
RUN		mkdir -p /run/openrc/; \
		touch /run/openrc/softlevel

# Create SSL/TLS Key
RUN		mkdir -p /etc/ssl/selfcerts/; \
		openssl req -x509 -nodes -new -days 7 \
			-subj "/C=JP/ST=Tokyo/L=Shibuya/CN=ft_services.com" \
			-keyout /etc/ssl/selfcerts/ft_services.key -out /etc/ssl/selfcerts/ft_services.crt; \
		chmod 400 /etc/ssl/selfcerts/ft_services.key; \
		chmod 400 /etc/ssl/selfcerts/ft_services.crt;

# Working Directory
WORKDIR /
