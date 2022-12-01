#! /bin/bash

namespaces=$(kubectl get namespaces)


if [[ $namespaces = *blue-deployment* ]]
then

echo " blue deployment exists "

else
echo  " create namespace green deployment "
kubectl create namespace  blue-deployment

fi 

