#!/bin/bash

# ================================ Variables ================================= #

SERVICE=(
	nginx
	phpmyadmin
	mysql
	wordpress
	ftps
	grafana
	influxdb
)

# ------------------------------- font / color ------------------------------- #

ESC_RESET='\033[0m'
ESC_FNT_BOLD='\033[1m'
ESC_CLR_GREEN='\033[38;5;02m'
ESC_CLR_YELLOW='\033[38;5;03m'
ESC_CLR_CYAN='\033[38;5;06m'

# ============================== Define Scripts ============================== #

# ----------------------------- Title ASCII ART ------------------------------ #

print_title_ascii_art()
{
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_CYAN}          _               "
	echo -e ' ___  ___| |_ _   _ _ __  '
	echo -e '/ __|/ _ \ __| | | | `_ \ '
	echo -e '\__ \  __/ |_| |_| | |_) |'
	echo -e '|___/\___|\__|\__,_| .__/ '
	echo -e '                   |_|  '
	echo -e "${ESC_RESET}"
}

# ------------------------------ stop minikube ------------------------------- #

stop_minikube()
{
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Stop Minikube] start ..${ESC_RESET}"

	minikube stop
	minikube delete

	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Stop Minikube] finish !!${ESC_RESET}"
	echo -e ""
}

# ------------------------------ start minikube ------------------------------ #

start_minikube()
{
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Minikube] start ..${ESC_RESET}"

	minikube start --driver=docker --extra-config=apiserver.service-node-port-range=1-65535

	eval $(minikube docker-env)

	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Minikube] finish !!${ESC_RESET}"
	echo -e ""
}

# ------------------------------ show dashboard ------------------------------ #

show_dashboard()
{
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Show Minikube Dashboard] start ..${ESC_RESET}"

	# minikube addons list
	minikube addons enable dashboard
	minikube dashboard &

	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Show Minikube Dashboard] finish !!${ESC_RESET}"
	echo -e ""
}

# --------------------------- build docker images ---------------------------- #

build_docker_base_image()
{
	# AlpinePlus (AlpineLinux + alpha = baseimage)
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) alpineplus start ..${ESC_RESET}"
	START_TIME=$(date +%s)
	docker image build -t alpineplus srcs/alpineplus/ > ./logs/docker_build_alpineplus.log
	END_TIME=$(date +%s)
	EXEC_TIME=$((END_TIME-START_TIME))
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) alpineplus finish !! ($EXEC_TIME second)${ESC_RESET}"
}

build_docker_images()
{
	# Nginx
	# PhpMyAdmin
	# MySQL
	# WordPress
	# FTPS
	# Grafana
	# InfluxDB
	for e in ${SERVICE[@]}; do
		echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_${e} start ..${ESC_RESET}"
		START_TIME=$(date +%s)
		docker image build --pull=false -t ft_${e} srcs/${e}/ > ./logs/docker_build_ft_${e}.log
		END_TIME=$(date +%s)
		EXEC_TIME=$((END_TIME-START_TIME))
		echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(docker image bulid) ft_${e} finish !! ($EXEC_TIME second)${ESC_RESET}"
	done
}

build_docker()
{
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Create Docker Image] start ..${ESC_RESET}"

	build_docker_base_image
	build_docker_images

	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Create Docker Image] finish !!${ESC_RESET}"
	echo -e ""
}

# ------------------------- apply kubernetes setting ------------------------- #

apply_kubernetes_config()
{
	# Config
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Config start ..${ESC_RESET}"
	kubectl apply -f srcs/config/config-secret.yaml >> ./logs/kubectl_apply_config.log
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Config finish !!${ESC_RESET}"
}

apply_kubernetes_metallb()
{
	# MetalLB
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) MetalLB start ..${ESC_RESET}"
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml >> ./logs/kubectl_apply_metallb.log
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml >> ./logs/kubectl_apply_metallb.log
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> ./logs/kubectl_apply_metallb.log
	kubectl apply -f srcs/metallb/metallb-configmap.yaml >> ./logs/kubectl_apply_metallb.log
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) MetalLB finish !!${ESC_RESET}"
}

apply_kubernetes()
{
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Apply Kubernetes Setting] start ..${ESC_RESET}"

	# Config
	apply_kubernetes_config

	# MetalLB
	apply_kubernetes_metallb

	# Nginx
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Nginx start ..${ESC_RESET}"
	kubectl apply -f srcs/nginx/nginx-deploy.yaml >> ./logs/kubectl_apply_nginx.log
	kubectl apply -f srcs/nginx/nginx-svc.yaml >> ./logs/kubectl_apply_nginx.log
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Nginx finish !!${ESC_RESET}"

	# PhpMyAdmin
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) PhpMyAdmin start ..${ESC_RESET}"
	kubectl apply -f srcs/phpmyadmin/phpmyadmin-deploy.yaml >> ./logs/kubectl_apply_phpmyadmin.log
	kubectl apply -f srcs/phpmyadmin/phpmyadmin-svc.yaml >> ./logs/kubectl_apply_phpmyadmin.log
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) PhpMyAdmin finish !!${ESC_RESET}"

	# MySQL
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) MySQL start ..${ESC_RESET}"
	kubectl apply -f srcs/mysql/mysql-pv.yaml >> ./logs/kubectl_apply_mysql.log
	kubectl apply -f srcs/mysql/mysql-pvc.yaml >> ./logs/kubectl_apply_mysql.log
	kubectl apply -f srcs/mysql/mysql-deploy.yaml >> ./logs/kubectl_apply_mysql.log
	kubectl apply -f srcs/mysql/mysql-svc.yaml >> ./logs/kubectl_apply_mysql.log
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) MySQL finish !!${ESC_RESET}"

	# WordPress
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) WordPress start ..${ESC_RESET}"
	kubectl apply -f srcs/wordpress/wordpress-pv.yaml >> ./logs/kubectl_apply_wordpress.log
	kubectl apply -f srcs/wordpress/wordpress-pvc.yaml >> ./logs/kubectl_apply_wordpress.log
	kubectl apply -f srcs/wordpress/wordpress-deploy.yaml >> ./logs/kubectl_apply_wordpress.log
	kubectl apply -f srcs/wordpress/wordpress-svc.yaml >> ./logs/kubectl_apply_wordpress.log
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) WordPress finish !!${ESC_RESET}"

	# FTPS
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) FTPS start ..${ESC_RESET}"
	kubectl apply -f srcs/ftps/ftps-pv.yaml >> ./logs/kubectl_apply_ftps.log
	kubectl apply -f srcs/ftps/ftps-pvc.yaml >> ./logs/kubectl_apply_ftps.log
	kubectl apply -f srcs/ftps/ftps-deploy.yaml >> ./logs/kubectl_apply_ftps.log
	kubectl apply -f srcs/ftps/ftps-svc.yaml >> ./logs/kubectl_apply_ftps.log
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) FTPS finish !!${ESC_RESET}"

	# Grafana
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Grafana start ..${ESC_RESET}"
	kubectl apply -f srcs/grafana/grafana-deploy.yaml >> ./logs/kubectl_apply_grafana.log
	kubectl apply -f srcs/grafana/grafana-svc.yaml >> ./logs/kubectl_apply_grafana.log
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) Grafana finish !!${ESC_RESET}"

	# InfluxDB
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) InfluxDB start ..${ESC_RESET}"
	kubectl apply -f srcs/influxdb/influxdb-pv.yaml >> ./logs/kubectl_apply_influxdb.log
	kubectl apply -f srcs/influxdb/influxdb-pvc.yaml >> ./logs/kubectl_apply_influxdb.log
	kubectl apply -f srcs/influxdb/influxdb-deploy.yaml >> ./logs/kubectl_apply_influxdb.log
	kubectl apply -f srcs/influxdb/influxdb-svc.yaml >> ./logs/kubectl_apply_influxdb.log
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_YELLOW}(kubectl apply) InfluxDB finish !!${ESC_RESET}"

	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Apply Kubernetes Setting] finish !!${ESC_RESET}"
	echo -e ""
}

# =============================== Run Scripts ================================ #

print_title_ascii_art
stop_minikube
start_minikube
build_docker
apply_kubernetes
show_dashboard

# ============================================================================ #
