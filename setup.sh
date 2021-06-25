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

# ================================== docker ================================== #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Docker Setting] start ..${ESC_RESET}"

# AlpinePlus (AlpineLinux + alpha = baseimage)
docker image build -t alpineplus srcs/alpineplus/
# Nginx
docker image build --pull=false -t ft_nginx srcs/nginx/



echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Docker Setting] finish !!${ESC_RESET}"

# ================================ kubernetes ================================ #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Kubernetes Setting] start ..${ESC_RESET}"

# MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb/metallb-configmap.yaml
# Nginx
kubectl apply -f srcs/nginx/nginx.yaml



echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Kubernetes Setting] finish !!${ESC_RESET}"

# ================================= minikube ================================= #

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Minikube Dashboard] start ..${ESC_RESET}"

minikube addons list
minikube addons enable dashboard
minikube dashboard &

echo "${ESC_FNT_BOLD}${ESC_CLR_GREEN}[Start Minikube Dashboard] finish !!${ESC_RESET}"

# ============================================================================ #
