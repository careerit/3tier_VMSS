#!/usr/bin/env bash
set -x
source /etc/lsb-release

sudo DEBIAN_FRONTEND="noninteractive" apt-get -y dist-upgrade

sudo apt-get update -y
sudo apt-get install apache2 -y



sudo apt-get install python-pip software-properties-common -y

sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" -y

sudo apt-get update

sudo apt-get install docker-ce -y

sudo adduser $USER docker


# Setting up kubeadm

sudo apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl



# Initialize kubeadm

#!/usr/bin/env bash
set -x
source /etc/lsb-release

sudo DEBIAN_FRONTEND="noninteractive" apt-get -y dist-upgrade

sudo apt-get update -y


sudo apt-get install python-pip software-properties-common jq -y
 