#!/bin/bash
  if [[ $(aws eks list-clusters  --region=us-east-2) == *Monitoring-kubernetes-cluster* ]]
    then
        echo " Cluster exists "
        
    else
        eksctl create  cluster -f ./eks/eksctl_templet.yaml
    fi
