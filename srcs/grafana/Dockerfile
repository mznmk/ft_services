# Base Image
FROM	alpineplus

# Label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# Install libc6-compat
RUN		apk --no-cache add libc6-compat

# # Install grafana
# RUN		apk --no-cache add grafana

# Install grafana
RUN		wget --no-check-certificate https://dl.grafana.com/oss/release/grafana-7.4.5.linux-amd64.tar.gz -P /tmp; \
		mkdir -p /usr/share/grafana/; \
		tar xzf /tmp/grafana-7.4.5.linux-amd64.tar.gz --strip-components=1 -C /usr/share/grafana/; \
		rm /tmp/grafana-7.4.5.linux-amd64.tar.gz

# Create Working Directory


# Copy Setting Data
COPY	./srcs/defaults.ini /usr/share/grafana/conf/
# COPY	./srcs/datasources /usr/share/grafana/conf/provisioning/datasources
# COPY	./srcs/dashboards /usr/share/grafana/conf/provisioning/dashboards

# Copy LivenessProbe Script
COPY	./srcs/livenessprobe.sh /tmp/

# Copy Init Script
COPY	./srcs/init_grafana.sh /tmp/
RUN		chmod +x /tmp/init_grafana.sh

# Run Init Command
ENTRYPOINT	[ "/tmp/init_grafana.sh" ]
