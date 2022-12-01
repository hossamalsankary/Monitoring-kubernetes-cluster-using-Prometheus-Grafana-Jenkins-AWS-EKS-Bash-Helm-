pipeline{
    agent any
    stages{

        stage("Install Deplancey"){
            steps{
              

                sh 'chmod +x -R ./bashScripts/CheckIfEksctlIsExist.sh  '
                 sh 'chmod +x -R ./bashScripts/Installkubectl.sh '
                 sh '  ./bashScripts/Installkubectl.sh '
                sh '  ./bashScripts/CheckIfEksctlIsExist.sh '

            }
        }
        stage("Create EKS cluster"){
            steps{

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
    stage("Install Helm"){
        steps{
                sh 'chmod +x   ./bashScripts/get_helm.sh  '
                sh '''#!/bin/bash 
                if [[ $(./bashScripts/get_helm.sh ) == *already* ]]
                then
                 echo "there" 
                else 
                 ./get_helm.sh 
                fi
                '''
          }
     }
    stage("Create prod namespaces")
        steps{
         sh 'kubectl create namespace blue 1>suceed 2>error'
         sh 'kubectl create namespace prometheus 1>suceed 2>error'
         
        }
     stage("Deploy Node app"){
        steps{

            sh "kubectl apply -f ./k8s/deploy-node-app.yaml --namespace=blue"
        }
     }

     stage("Deploy prometheus server")
        steps{
         sh 'helm repo add prometheus-community https://prometheus-community.github.io/helm-charts'
         sh 'helm repo update'
         sh '  helm install prometheus-server prometheus-community/kube-prometheus-stack --create-namespace '

        }
     

    
    }

}

  