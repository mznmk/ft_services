# Base Image
FROM	alpineplus

# Label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# Install vsftpd
RUN		apk --no-cache add vsftpd;

# Create User
RUN		adduser -D user42; \
		echo 'user42:user42' | chpasswd;

# Create Contents Directory
RUN		mkdir -p /var/www/ftps; \
		chown user42:user42 /var/www/ftps;

# Copy Setting Data
COPY	srcs/vsftpd.conf /etc/vsftpd/
COPY	srcs/chroot_list /etc/vsftpd/

# Copy LivenessProbe Script
COPY	./srcs/livenessprobe.sh /tmp/

# Copy Init Script
COPY	./srcs/init_ftps.sh /tmp/
RUN		chmod +x /tmp/init_ftps.sh

# Run Init Command
ENTRYPOINT	[ "/tmp/init_ftps.sh" ]
