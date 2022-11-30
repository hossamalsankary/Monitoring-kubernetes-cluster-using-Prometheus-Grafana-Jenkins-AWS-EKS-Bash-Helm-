#!/bin/bash
sudo apt-get update

sudo apt-get install -y ca-certificates curl

sudo apt-get install -y apt-transport-https

sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https:/$

echo  "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] ht$

sudo apt-get update

sudo apt-get install -y kubectl