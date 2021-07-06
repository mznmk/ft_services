#!/bin/sh

# ================================ Variables ================================= #

# ------------------------------- font / color ------------------------------- #

ESC_RESET='\033[0m'
ESC_FNT_BOLD='\033[1m'
ESC_CLR_GREEN='\033[38;5;02m'
ESC_CLR_YELLOW='\033[38;5;03m'
ESC_CLR_CYAN='\033[38;5;06m'

# ================================= Scripts ================================== #

# ============================= Title ASCII ART ============================== #

echo "${ESC_FNT_BOLD}${ESC_CLR_CYAN}      _                  "
echo '  ___| | ___  __ _ _ __  '
echo ' / __| |/ _ \/ _` | `_ \ '
echo '| (__| |  __/ (_| | | | |'
echo ' \___|_|\___|\__,_|_| |_|'
echo "${ESC_RESET}"

# ============================ working directory ============================= #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Working Directory] start ..${ESC_RESET}"

rm -rf /data

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Working Directory] finish !!${ESC_RESET}"
echo ""

# =================================== logs =================================== #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Install Logs] start !!${ESC_RESET}"

rm -rf ./logs/*.log

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Install Logs] finish !!${ESC_RESET}"
echo ""

# ================================ kubernetes ================================ #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Kubernetes Setting] start !!${ESC_RESET}"

kubectl delete pod --all
kubectl delete service --all
kubectl delete deployment --all
# kubectl delete pv --all
kubectl delete pvc --all
kubectl delete secret --all

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Kubernetes Setting] finish !!${ESC_RESET}"
echo ""

# ================================== docker ================================== #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Docker Image] start !!${ESC_RESET}"

docker image rm ft_influxdb
docker image rm ft_grafana
docker image rm ft_ftps
docker image rm ft_wordpress
docker image rm ft_mysql
docker image rm ft_phpmyadmin
docker image rm ft_nginx
docker image rm alpineplus
docker image rm alpine

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Delete Docker Image] finish !!${ESC_RESET}"
echo ""

# ================================= minikube ================================= #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Stop Minikube Setting] start !!${ESC_RESET}"

minikube stop
minikube delete

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Stop Minikube Setting] finish !!${ESC_RESET}"
echo ""

# ============================================================================ #
