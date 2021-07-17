#!/bin/sh

kubectl exec deployment.apps/ftps -- pkill vsftpd
kubectl exec deployment.apps/influxdb -- pkill influxd
kubectl exec deployment.apps/grafana -- pkill grafana-server
# kubectl exec deployment.apps/mysql -- pkill mysqld
kubectl exec deployment.apps/mysql -- pkill mariadbd
kubectl exec deployment.apps/nginx -- pkill nginx
kubectl exec deployment.apps/phpmyadmin -- pkill nginx
kubectl exec deployment.apps/wordpress -- pkill nginx
