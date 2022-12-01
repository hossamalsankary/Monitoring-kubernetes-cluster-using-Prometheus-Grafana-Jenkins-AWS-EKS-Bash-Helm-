
## skills:
  -  Working in AWS EKS
  -  Using Jenkins to implement Continuous Integration and Continuous Deployment for k8s cluster and monitoring
  -  Working with CloudFormation to deploy clusters
  -  Building Kubernetes clusters
  -  working with to namespace monitoring and blue_prodaction
  -  install prometheus using helm
  -  configer grafana and prometheus pod and expose them 
  -  set alert for cup usege 
  -  monitoring node app and see all information about this namespace
  -  make use of bash script for helping to get every thing clean
  -  rollback 

  ## How Prometheus Works

###### Prometheus uses a pull based system that sends HTTP requests. Each request is called a scrape, and is created according to the config instructions defined in your deployment file. Each response to a scrape is parsed and stored in a repository along with the relevant metrics.

###### This repository is, essentially, a custom database deployed on a server, that can handle huge amounts of data. One Prometheus server can simultaneously monitor thousands of machines.
###### Built into Kubernetes – Prometheus works seamlessly with Kubernetes. Both Kubernetes and Prometheus are Cloud Native Computing Foundation (CNCF) projects and work seamlessly together (Prometheus is also bundled with Kubernetes).Query language and APIs – Prometheus provides APIs that enable convenient access to monitoring metrics.Many exporters and libraries – Prometheus offers a wide range of libraries and exporters for collecting application metrics.
 
 

<img src="/images/1.svg" alt="Permissions" />

## pipline
```diff 
pipeline {
  agent any
  stages {

    stage("Install Deplancey") {
      steps {

        sh 'chmod +x -R ./bashScripts/CheckIfEksctlIsExist.sh  '
        sh 'chmod +x -R ./bashScripts/Installkubectl.sh '
        sh '  ./bashScripts/Installkubectl.sh '
        sh '  ./bashScripts/CheckIfEksctlIsExist.sh '

      }
    }
    stage("Create EKS cluster") {
      steps {

        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh 'chmod +x   ./bashScripts/CreateCluster.sh '
          sh './bashScripts/CreateCluster.sh'

        }

      }

    }
    stage('create kubecontext file') {
      steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {

          sh 'aws eks update-kubeconfig --region us-east-2 --name Monitoring-kubernetes-cluster-1'
          sh 'kubectl get nodes'

        }
      }

    }
    stage("Install Helm") {
      steps {
        sh 'chmod +x   ./bashScripts/get_helm.sh  '
        sh ''
        '#!/bin/bash 
        if [
          [$(. / bashScripts / get_helm.sh) == * already * ]
        ]
        then
        echo "there"
        else
          . / get_helm.sh
        fi
          ''
        '
      }
    }

    stage("Deploy Node app") {
      steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {

          sh 'bash ./bashScripts/cheackForNameSpaces.sh'
          sh "kubectl apply -f ./k8s/deploy-node-app.yaml --namespace=blue-deployment "
        }
      }
    }

    stage("Deploy prometheus server") {
      steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {

          sh 'helm repo add prometheus-community https://prometheus-community.github.io/helm-charts'
          sh 'helm repo update'
          sh '  helm install prometheus-server prometheus-community/kube-prometheus-stack --namespace prometheus-namespace '
        }
      }
    }
    stage("expose prometheus and grafana ") {
      steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {

          sh ''
          '
          kubectl expose deployment prometheus - server - grafana--type = LoadBalancer--port = 3000--name = grafana - server--namespace prometheus - namespace
          kubectl expose pod prometheus - prometheus - server - kube - pro - prometheus - 0--type = LoadBalancer--port = 9090--name = prometheus - service--namespace prometheus - namespace

          ''
          '
        }
      }
    }

    stage("get the service") {
      steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh 'sleep 120 '
          sh 'kubectl get svc prometheus-service --namespace prometheus-namespace'
          sh 'kubectl get svc grafana-server --namespace prometheus-namespace'

        }
      }
    }

  }
  post {
    failure {
      withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {

        sh ' helm uninstall prometheus-server --namespace prometheus-namespace '
        sh ' kubectl delete svc prometheus-service   --namespace prometheus-namespace'
        sh ' kubectl delete svc grafana-server   --namespace prometheus-namespace '
      }
    }
  }

}

```
<img src="/images/1.png" alt="Permissions" />
<img src="/images/3.png" alt="Permissions" />
<img src="/images/4.png" alt="Permissions" />
<img src="/images/5.png" alt="Permissions" />
<img src="/images/6.png" alt="Permissions" />
<img src="/images/7.png" alt="Permissions" />
<img src="/images/8.png" alt="Permissions" />
<img src="/images/9.png" alt="Permissions" />
<img src="/images/10.png" alt="Permissions" />
<img src="/images/11.png" alt="Permissions" />
<img src="/images/12.png" alt="Permissions" />
<img src="/images/13.png" alt="Permissions" />
<img src="/images/15.png" alt="Permissions" />
<img src="/images/16.png" alt="Permissions" />

<img src="/images/117.png" alt="Permissions" />

<img src="/images/18.png" alt="Permissions" />

<img src="/images/119.png" alt="Permissions" />


