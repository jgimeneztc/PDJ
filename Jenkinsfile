pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'building'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws_credential',
                        ACCESS_KEY: 'ACCESS_KEY', SECRET_KEY: 'SECRET_KEY']]) {
            
                sh '''
                set -ex
                
                docker build -t test_repository .
                readonly DOCKERLOGIN="$(aws ecr get-login --region us-east-2)"
                DOCKERLOGIN
                docker tag test_repository 922038103956.dkr.ecr.us-east-2.amazonaws.com/test_repository
                docker push 922038103956.dkr.ecr.us-east-2.amazonaws.com/test_repository
                '''
            }
            }
        }
    }
}
