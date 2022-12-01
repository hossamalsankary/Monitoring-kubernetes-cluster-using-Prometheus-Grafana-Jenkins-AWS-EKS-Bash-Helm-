#!/bin/bash

 sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
 sudo curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
 sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
 # for fix the (error: exec plugin: invalid apiVersion "client.authentication.k8s.io/v1alpha1")
sed -i -e "s,client.authentication.k8s.io/v1alpha1,client.authentication.k8s.io/v1beta1,g" ~/.kube/config
 