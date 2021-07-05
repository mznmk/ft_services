#!/bin/sh

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "nginx-service"'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "nginx"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# avoid Nginx to be daemon
nginx -g 'daemon off;'
