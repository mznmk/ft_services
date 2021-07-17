#!/bin/sh

# modify phpmyadmin setting
sed -i -e "s/\['controluser'\] = 'pma'/['controluser'] = '${PHPMYADMIN_USER_NAME}'/" /var/www/phpmyadmin/config.inc.php
sed -i -e "s/\['controlpass'\] = 'pmapass'/['controluser'] = '${PHPMYADMIN_USER_PASS}'/" /var/www/phpmyadmin/config.inc.php

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "phpmyadmin"'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "phpmyadmin"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# start php-fpm
php-fpm7

# avoid Nginx to be daemon
nginx -g "daemon off;"
