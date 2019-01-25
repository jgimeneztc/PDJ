pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'building'

            
                sh '''
                set -ex
                
                cd ./repository
                docker build -t test_repository .
                
                '''
            
            }
        }
        stage('Tag') {
            steps {
                echo 'Tag'
            
                sh '''
                set -ex
                
                docker tag test_repository 922038103956.dkr.ecr.us-east-2.amazonaws.com/test_repository
                '''
            
            }
        }
        
        stage('Push') {
            steps {
                echo 'Push'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws_credential',
                        ACCESS_KEY: 'ACCESS_KEY', SECRET_KEY: 'SECRET_KEY']]) {
            
                sh '''
                set -ex
                readonly DOCKERLOGIN="$(aws ecr get-login --region us-east-2 --no-include-email)"
                $DOCKERLOGIN
                docker push 922038103956.dkr.ecr.us-east-2.amazonaws.com/test_repository
                '''
            }
            }
        }
        
         
    }
}
