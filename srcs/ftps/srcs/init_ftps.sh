#!/bin/sh

# create ftps user
adduser -h /var/www/ftps/$FTPS_USER_NAME -D $FTPS_USER_NAME
echo "$FTPS_USER_NAME:$FTPS_USER_PASS" | chpasswd

# modify telegraf setting
sed -i -e s/'hostname = ""'/'hostname = "ftps"'/ /etc/telegraf.conf
sed -i -e s/'database = ""'/'database = "ftps"'/ /etc/telegraf.conf

# start telegraf
telegraf --config /etc/telegraf.conf &

# start vsftpd
vsftpd /etc/vsftpd/vsftpd.conf
