# base image
FROM	alpineplus

# label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# install influxdb
RUN		apk --no-cache add influxdb;

# copy setting data
COPY	srcs/influxdb.conf /etc/influxdb/

# copy LivenessProbe script
COPY	./srcs/livenessprobe.sh /tmp/

# copy init script
COPY	./srcs/init_influxdb.sh /tmp/
RUN		chmod +x /tmp/init_influxdb.sh

# run init command
ENTRYPOINT	[ "sh", "/tmp/init_influxdb.sh" ]
