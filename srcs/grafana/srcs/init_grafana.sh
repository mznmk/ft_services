#!/bin/sh

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "grafana-service"'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "grafana"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# start grafana
/usr/share/grafana/bin/grafana-server --homepath=/usr/share/grafana --config /usr/share/grafana/conf/defaults.ini
