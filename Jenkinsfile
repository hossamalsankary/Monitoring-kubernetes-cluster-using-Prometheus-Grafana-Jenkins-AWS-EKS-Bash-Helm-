pipeline{
    agent any
    stages{
        stage("Create EKS cluster"){
            steps{
                sh 'chmod +x -R ./bashScripts/CheckIfEksctlIsExist.sh  '
                sh '  ./bashScripts/CheckIfEksctlIsExist.sh '
                sh ' eksctl create cluster -f ./eks/eksctl_templet.yaml'
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

