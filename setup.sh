#!/bin/sh

# ================================ Variables ================================= #

# ------------------------------- font / color ------------------------------- #

# ESC_RESET='\033[0m'
# ESC_FNT_BOLD='\033[1m'
# ESC_FNT_FINE='\033[2m'
# ESC_FNT_ITALIC='\033[3m'
# ESC_FNT_ULINE='\033[4m'
# ESC_CLR_BLACK='\033[38;5;00m'
# ESC_CLR_RED='\033[38;5;01m'
# ESC_CLR_GREEN='\033[38;5;02m'
# ESC_CLR_YELLOW='\033[38;5;03m'
# ESC_CLR_BLUE='\033[38;5;04m'
# ESC_CLR_MAGENTA='\033[38;5;05m'
# ESC_CLR_CYAN='\033[38;5;06m'
# ESC_CLR_WHITE='\033[38;5;07m'
# ESC_CLR_PINK='\033[38;5;213m'

ESC_RESET='\033[0m'
ESC_FNT_BOLD='\033[1m'
ESC_CLR_GREEN='\033[38;5;02m'
ESC_CLR_YELLOW='\033[38;5;03m'
ESC_CLR_CYAN='\033[38;5;06m'

# ================================= Scripts ================================== #

# ============================= Title ASCII ART ============================== #

echo "${ESC_FNT_BOLD}${ESC_CLR_CYAN}          _               "
echo ' ___  ___| |_ _   _ _ __  '
echo '/ __|/ _ \ __| | | | `_ \ '
echo '\__ \  __/ |_| |_| | |_) |'
echo '|___/\___|\__|\__,_| .__/ '
echo '                   |_|  '
echo "${ESC_RESET}"

# ================================= minikube ================================= #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Minikube Setting] start ..${ESC_RESET}"

minikube delete
minikube start --driver=docker --extra-config=apiserver.service-node-port-range=1-65535

eval $(minikube docker-env)

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Minikube Setting] finish !!${ESC_RESET}"
echo ""

# ============================ working directory ============================= #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Create Working Directory] start ..${ESC_RESET}"

if [ ! -d "/data/ftps" ]; then
	sudo mkdir -p /data/ftps
	sudo chmod 777 /data/ftps
fi

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Create Working Directory] finish !!${ESC_RESET}"
echo ""

# ================================== docker ================================== #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Create Docker Image] start ..${ESC_RESET}"

# AlpinePlus (AlpineLinux + alpha = baseimage)
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) alpineplus start ..${ESC_RESET}"
docker image build -t alpineplus srcs/alpineplus/ > ./logs/docker_build_alpineplus.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) alpineplus finish !!${ESC_RESET}"

# Nginx
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_nginx start ..${ESC_RESET}"
docker image build --pull=false -t ft_nginx srcs/nginx/ > ./logs/docker_build_ft_nginx.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_nginx finish !!${ESC_RESET}"

# PhpMyAdmin
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_phpmyadmin start ..${ESC_RESET}"
docker image build --pull=false -t ft_phpmyadmin srcs/phpmyadmin/ > ./logs/docker_build_ft_phpmyadmin.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_phpmyadmin finish !!${ESC_RESET}"

# MySQL
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_mysql start ..${ESC_RESET}"
docker image build --pull=false -t ft_mysql srcs/mysql/ > ./logs/docker_build_ft_mysql.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_mysql finish !!${ESC_RESET}"

# WordPress
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_wordpress start ..${ESC_RESET}"
docker image build --pull=false -t ft_wordpress srcs/wordpress/ > ./logs/docker_build_ft_wordpress.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_wordpress finish !!${ESC_RESET}"

# FTPS
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_ftps start ..${ESC_RESET}"
docker image build --pull=false -t ft_ftps srcs/ftps/ > ./logs/docker_build_ft_ftps.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_ftps finish !!${ESC_RESET}"

# Grafana
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_grafana start ..${ESC_RESET}"
docker image build --pull=false -t ft_grafana srcs/grafana/ > ./logs/docker_build_ft_grafana.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_grafana finish !!${ESC_RESET}"

# InfluxDB
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_influxdb start ..${ESC_RESET}"
docker image build --pull=false -t ft_influxdb srcs/influxdb/ > ./logs/docker_build_ft_influxdb.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_influxdb finish !!${ESC_RESET}"

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Create Docker Image] finish !!${ESC_RESET}"
echo ""

# ================================ kubernetes ================================ #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Apply Kubernetes Setting] start ..${ESC_RESET}"

# Config
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Config start ..${ESC_RESET}"
kubectl apply -f srcs/config/config-secret.yaml >> ./logs/kubectl_apply_config.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Config finish !!${ESC_RESET}"

# MetalLB
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) MetalLB start ..${ESC_RESET}"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml >> ./logs/kubectl_apply_metallb.log
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml >> ./logs/kubectl_apply_metallb.log
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> ./logs/kubectl_apply_metallb.log
kubectl apply -f srcs/metallb/metallb-configmap.yaml >> ./logs/kubectl_apply_metallb.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) MetalLB finish !!${ESC_RESET}"

# Nginx
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Nginx start ..${ESC_RESET}"
kubectl apply -f srcs/nginx/nginx-deployment.yaml >> ./logs/kubectl_apply_nginx.log
kubectl apply -f srcs/nginx/nginx-service.yaml >> ./logs/kubectl_apply_nginx.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Nginx finish !!${ESC_RESET}"

# PhpMyAdmin
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) PhpMyAdmin start ..${ESC_RESET}"
kubectl apply -f srcs/phpmyadmin/phpmyadmin-deployment.yaml >> ./logs/kubectl_apply_phpmyadmin.log
kubectl apply -f srcs/phpmyadmin/phpmyadmin-service.yaml >> ./logs/kubectl_apply_phpmyadmin.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) PhpMyAdmin finish !!${ESC_RESET}"

# MySQL
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) MySQL start ..${ESC_RESET}"
kubectl apply -f srcs/mysql/mysql-pv.yaml >> ./logs/kubectl_apply_mysql.log
kubectl apply -f srcs/mysql/mysql-pvc.yaml >> ./logs/kubectl_apply_mysql.log
kubectl apply -f srcs/mysql/mysql-deployment.yaml >> ./logs/kubectl_apply_mysql.log
kubectl apply -f srcs/mysql/mysql-service.yaml >> ./logs/kubectl_apply_mysql.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) MySQL finish !!${ESC_RESET}"

# WordPress
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) WordPress start ..${ESC_RESET}"
kubectl apply -f srcs/wordpress/wordpress-deployment.yaml >> ./logs/kubectl_apply_wordpress.log
kubectl apply -f srcs/wordpress/wordpress-service.yaml >> ./logs/kubectl_apply_wordpress.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) WordPress finish !!${ESC_RESET}"

# FTPS
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) FTPS start ..${ESC_RESET}"
kubectl apply -f srcs/ftps/ftps-pv.yaml >> ./logs/kubectl_apply_ftps.log
kubectl apply -f srcs/ftps/ftps-pvc.yaml >> ./logs/kubectl_apply_ftps.log
kubectl apply -f srcs/ftps/ftps-deployment.yaml >> ./logs/kubectl_apply_ftps.log
kubectl apply -f srcs/ftps/ftps-service.yaml >> ./logs/kubectl_apply_ftps.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) FTPS finish !!${ESC_RESET}"

# Grafana
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Grafana start ..${ESC_RESET}"
kubectl apply -f srcs/grafana/grafana-deployment.yaml >> ./logs/kubectl_apply_grafana.log
kubectl apply -f srcs/grafana/grafana-service.yaml >> ./logs/kubectl_apply_grafana.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Grafana finish !!${ESC_RESET}"

# InfluxDB
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) InfluxDB start ..${ESC_RESET}"
kubectl apply -f srcs/influxdb/influxdb-pv.yaml >> ./logs/kubectl_apply_influxdb.log
kubectl apply -f srcs/influxdb/influxdb-pvc.yaml >> ./logs/kubectl_apply_influxdb.log
kubectl apply -f srcs/influxdb/influxdb-deployment.yaml >> ./logs/kubectl_apply_influxdb.log
kubectl apply -f srcs/influxdb/influxdb-service.yaml >> ./logs/kubectl_apply_influxdb.log
echo "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) InfluxDB finish !!${ESC_RESET}"

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Apply Kubernetes Setting] finish !!${ESC_RESET}"
echo ""

# ================================= minikube ================================= #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Minikube Dashboard] start ..${ESC_RESET}"

# minikube addons list
minikube addons enable dashboard
minikube dashboard &

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Minikube Dashboard] finish !!${ESC_RESET}"
echo ""

# ============================================================================ #
