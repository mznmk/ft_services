# base image
FROM	alpineplus

# label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# install vsftpd
RUN		apk --no-cache add vsftpd;

# copy setting data
COPY	srcs/vsftpd.conf /etc/vsftpd/

# copy LivenessProbe script
COPY	./srcs/livenessprobe.sh /tmp/

# copy init script
COPY	./srcs/init_ftps.sh /tmp/
RUN		chmod +x /tmp/init_ftps.sh

# run init command
ENTRYPOINT	[ "sh", "/tmp/init_ftps.sh" ]
