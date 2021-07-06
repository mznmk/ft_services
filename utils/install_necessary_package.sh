#!/bin/sh

# ================================ Variables ================================= #

# ------------------------------- font / color ------------------------------- #

ESC_RESET='\033[0m'
ESC_FNT_BOLD='\033[1m'
ESC_CLR_CYAN='\033[38;5;06m'

# ============================= Title ASCII ART ============================== #

echo "${ESC_FNT_BOLD}${ESC_CLR_CYAN} _           _        _ _ "
echo '(_)_ __  ___| |_ __ _| | |'
echo '| | `_ \/ __| __/ _` | | |'
echo '| | | | \__ \ || (_| | | |'
echo '|_|_| |_|___/\__\__,_|_|_|'
echo "${ESC_RESET}"

# ======================= 42 VirtualBox Install Script ======================= #

# https://pastebin.com/raw/4HnnSUpe

sudo apt-get install zsh vim emacs curl gcc clang-9 lldb llvm valgrind php-cli php-curl php-gd php-intl php-json php-mbstring php-xml php-zip php-mysql php-pgsql g++ as31 nasm ruby ruby-bundler ruby-dev build-essential mysql-server sqlite3 postgresql docker.io qemu-kvm virtualbox virtualbox-qt virtualbox-dkms libx11-dev x11proto-core-dev libxt-dev libxext-dev libbsd-dev terminator nasm freeglut3 libncurses5-dev glmark2 cmake nginx docker-compose python3-pip python-pip redis && 
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl && 
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl && 
chmod +x ./kubectl && 
sudo mv ./kubectl /usr/local/bin/kubectl && 
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && 
chmod +x minikube && 
sudo mkdir -p /usr/local/bin/ && 
sudo install minikube /usr/local/bin/ && 
sudo usermod -aG docker user42 && 
newgrp docker && 
sudo add-apt-repository ppa:/longsleep/golang-backports && 
sudo apt update && 
sudo apt install golang-go && 
wget -qO- https://deb.nodesource.com/setup_13.x | sudo -E bash - && 
sudo apt install -y nodejs && 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh%

# =========================== Install for minikube =========================== #

sudo apt install conntrack

# ============================= Install for ftps ============================= #

sudo apt install lftp

# ============================================================================ #
