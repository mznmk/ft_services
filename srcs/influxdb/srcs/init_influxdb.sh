#!/bin/sh

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "influxdb-service"'/ /etc/telegraf.conf
sed -i -e s/'influxdb-service:8086'/'127.0.0.1:8086'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "influxdb"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# start influxdb
influxd --config /etc/influxdb.conf
