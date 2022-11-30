pipeline{
    agent any
    stages{
        stage("Create EKS cluster"){
            steps{
                sh 'bash ./bashScripts/CheckIfEksctlIsExist.sh '
                sh ' eksctl ./eks/eksctl_templet.yaml'
            }
            post{
              
           
                failure{
                    echo "========A execution failed========"
                }
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}

