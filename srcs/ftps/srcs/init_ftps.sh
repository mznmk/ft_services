#!/bin/sh

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "ftps-service"'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "ftps"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# start vsftpd
vsftpd /etc/vsftpd/vsftpd.conf
