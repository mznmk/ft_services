#!/bin/sh

# modify grafana setting
sed -i -e "s/admin_user = admin/admin_user = ${GRAFANA_USER_NAME}/" /usr/share/grafana/conf/defaults.ini
sed -i -e "s/admin_password = admin/admin_password = ${GRAFANA_USER_PASS}/" /usr/share/grafana/conf/defaults.ini

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "grafana"'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "grafana"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# start grafana
/usr/share/grafana/bin/grafana-server --homepath=/usr/share/grafana --config /usr/share/grafana/conf/defaults.ini
