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
                
                docker build .
                docker images
                docker push 922038103956.dkr.ecr.us-east-2.amazonaws.com/test_repository:5.0.3-php7.1-apache
                '''
            }
            }
        }
    }
}
