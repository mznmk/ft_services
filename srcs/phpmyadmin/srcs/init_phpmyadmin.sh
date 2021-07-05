#!/bin/sh

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "phpmyadmin-service"'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "phpmyadmin"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# start php-fpm
php-fpm7

# avoid Nginx to be daemon
nginx -g "daemon off;"
