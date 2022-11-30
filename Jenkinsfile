pipeline{
    agent any
    stages{
        stage("Create EKS cluster"){
            steps{
                sh 'chmod +x -R ./bashScripts/CheckIfEksctlIsExist.sh  '
                sh '  ./bashScripts/CheckIfEksctlIsExist.sh '

                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        
                        sh './bashScripts/CreateCluster.sh'

                     }
              
            }
            
        }
          stage("Install Helm"){
        steps{
                 sh 'chmod +x   ./bashScripts/get_helm.sh  '
                sh ' if [[ $(./bashScripts/get_helm.sh ) == *already* ]];then echo "there" ; else ./get_helm.sh ;fi; '

        }
            }
     

    
    }

}

  