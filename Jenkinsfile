pipeline{
    agent any
    stages{
        stage("Create EKS cluster"){
            steps{
                sh 'chmod +x -R ./bashScripts/CheckIfEksctlIsExist.sh  '
                sh '  ./bashScripts/CheckIfEksctlIsExist.sh '

                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        
                          sh ' eksctl create  cluster -f ./eks/eksctl_templet.yaml --approve'

                     }
              
            }
            
        }
     

    
    }

}

