#!/bin/sh

# ================================ Variables ================================= #

# ------------------------------- font / color ------------------------------- #

ESC_RESET='\033[0m'
ESC_FNT_BOLD='\033[1m'
ESC_FNT_FINE='\033[2m'
ESC_FNT_ITALIC='\033[3m'
ESC_FNT_ULINE='\033[4m'
ESC_CLR_BLACK='\033[38;5;00m'
ESC_CLR_RED	='\033[38;5;01m'
ESC_CLR_GREEN='\033[38;5;02m'
ESC_CLR_YELLOW='\033[38;5;03m'
ESC_CLR_BLUE='\033[38;5;04m'
ESC_CLR_MAGENTA='\033[38;5;05m'
ESC_CLR_CYAN='\033[38;5;06m'
ESC_CLR_WHITE='\033[38;5;07m'
ESC_CLR_PINK='\033[38;5;213m'

# ============================= Title ASCII ART ============================== #

echo "${ESC_FNT_BOLD}${ESC_CLR_CYAN}      _                  "
echo '  ___| | ___  __ _ _ __  '
echo ' / __| |/ _ \/ _` | `_ \ '
echo '| (__| |  __/ (_| | | | |'
echo ' \___|_|\___|\__,_|_| |_|'
echo "${ESC_RESET}"

# ================================ kubernetes ================================ #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Stop Kubernetes Setting] start !!${ESC_RESET}"

kubectl delete pods --all
kubectl delete services --all
kubectl delete deployments --all
kubectl delete PersistentVolumeClaim --all

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Stop Kubernetes Setting] finish !!${ESC_RESET}"

# ================================== docker ================================== #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Stop Docker Setting] start !!${ESC_RESET}"

docker image rm ft_nginx
docker image rm alpineplus
docker image rm alpine

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Stop Docker Setting] finish !!${ESC_RESET}"

# ================================= minikube ================================= #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Stop Minikube Setting] start !!${ESC_RESET}"

minikube stop
minikube delete

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Stop Minikube Setting] finish !!${ESC_RESET}"

# ============================================================================ #
