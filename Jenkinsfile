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