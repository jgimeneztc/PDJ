pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'building'
                
                sh '''
                set -ex
                docker build --tag jgimeneztc/pdj:latest .
                '''
            }
        }
         stage('Tag') {
            steps {
                echo 'pushing'
                
                sh '''
                set -ex
                docker push jgimeneztc/pdj:latest
                '''
            }
        }
    }
}
