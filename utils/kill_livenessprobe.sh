#!/bin/sh

kubectl exec deploy/ftps -- pkill telegraf
kubectl exec deploy/influxdb -- pkill telegraf
kubectl exec deploy/grafana -- pkill telegraf
kubectl exec deploy/mysql -- pkill telegraf
kubectl exec deploy/nginx -- pkill telegraf
kubectl exec deploy/phpmyadmin -- pkill telegraf
kubectl exec deploy/wordpress -- pkill telegraf

# kubectl exec deploy/ftps -- pkill vsftpd
# kubectl exec deploy/influxdb -- pkill influxd
# kubectl exec deploy/grafana -- pkill grafana-server
# kubectl exec deploy/mysql -- pkill mysql
# kubectl exec deploy/nginx -- pkill nginx
# kubectl exec deploy/phpmyadmin -- pkill nginx
# kubectl exec deploy/wordpress -- pkill nginx

# kubectl exec deploy/phpmyadmin -- pkill php-fpm7
# kubectl exec deploy/wordpress -- pkill php-fpm7
