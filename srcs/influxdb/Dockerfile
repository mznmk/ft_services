# Base Image
FROM	alpineplus

# Label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# Install influxdb
RUN		apk --no-cache add influxdb;

# Copy Setting Data
COPY	srcs/influxdb.conf /etc/influxdb/influxdb.conf

# Copy LivenessProbe Script
COPY	./srcs/livenessprobe.sh /tmp/

# Copy Init Script
COPY	./srcs/init_influxdb.sh /tmp/
RUN		chmod +x /tmp/init_influxdb.sh

# Run Init Command
ENTRYPOINT	[ "/tmp/init_influxdb.sh" ]
