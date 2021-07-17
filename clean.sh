#!/bin/bash

# ================================ Variables ================================= #

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
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_CYAN}      _                  "
	echo -e '  ___| | ___  __ _ _ __  '
	echo -e ' / __| |/ _ \/ _` | `_ \ '
	echo -e '| (__| |  __/ (_| | | | |'
	echo -e ' \___|_|\___|\__,_|_| |_|'
	echo -e "${ESC_RESET}"
}

# ------------------------------- delete logs -------------------------------- #

delete_logs()
{
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Install Logs] start !!${ESC_RESET}"

	rm -rf ./logs/*.log

	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Install Logs] finish !!${ESC_RESET}"
	echo -e ""
}

# ------------------------ delete kubernetes setting ------------------------- #

delete_kubernetes()
{
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Kubernetes Setting] start !!${ESC_RESET}"

	kubectl delete pod --all
	kubectl delete service --all
	kubectl delete deployment --all
	# kubectl delete pv --all
	kubectl delete pvc --all
	kubectl delete secret --all

	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Kubernetes Setting] finish !!${ESC_RESET}"
	echo -e ""
}

# --------------------------- delete docker images --------------------------- #

delete_docker()
{
	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Docker Image] start !!${ESC_RESET}"

	docker image rm ft_influxdb
	docker image rm ft_grafana
	docker image rm ft_ftps
	docker image rm ft_wordpress
	docker image rm ft_mysql
	docker image rm ft_phpmyadmin
	docker image rm ft_nginx
	docker image rm alpineplus
	docker image rm alpine

	echo -e "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Docker Image] finish !!${ESC_RESET}"
	echo -e ""
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

# =============================== Run Scripts ================================ #

print_title_ascii_art
delete_logs
delete_kubernetes
delete_docker
stop_minikube

# ============================================================================ #
