# base image
FROM	alpineplus

# label
LABEL	maintainer="mmizuno <mmizuno@student.42tokyo.jp>"

# install libc6-compat
RUN		apk --no-cache add libc6-compat

# install grafana
RUN		wget --no-check-certificate https://dl.grafana.com/oss/release/grafana-7.4.5.linux-amd64.tar.gz -P /tmp; \
		mkdir -p /usr/share/grafana/; \
		tar xzf /tmp/grafana-7.4.5.linux-amd64.tar.gz --strip-components=1 -C /usr/share/grafana/; \
		rm /tmp/grafana-7.4.5.linux-amd64.tar.gz

# copy setting data
COPY	./srcs/defaults.ini /usr/share/grafana/conf/
COPY	./srcs/datasources /usr/share/grafana/conf/provisioning/datasources
COPY	./srcs/dashboards /usr/share/grafana/conf/provisioning/dashboards

# copy LivenessProbe script
COPY	./srcs/livenessprobe.sh /tmp/

# copy init script
COPY	./srcs/init_grafana.sh /tmp/
RUN		chmod +x /tmp/init_grafana.sh

# run init command
ENTRYPOINT	[ "sh", "/tmp/init_grafana.sh" ]
