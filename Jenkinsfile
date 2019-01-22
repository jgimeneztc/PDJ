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
                
                docker build -t prueba .
                aws ecr get-login --region us-east-2
                docker tag prueba:e9ae3c220b23 922038103956.dkr.ecr.us-east-2.amazonaws.com/prueba:e9ae3c220b23
                docker push 922038103956.dkr.ecr.us-east-2.amazonaws.com/prueba:e9ae3c220b23
                '''
            }
            }
        }
    }
}
