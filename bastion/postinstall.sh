#!/bin/bash

## Configure kubectl for user and create alias "kc" with completion capabilities
mkdir ~/.kube
sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config 

echo "source <(kubectl completion bash)" >> ~/.bashrc
echo "alias kc=kubectl" >> ~/.bashrc
echo "complete -F __start_kubectl kc" >> ~/.bashrc
