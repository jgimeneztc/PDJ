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
                
                withCredentials([usernamePassword(credentialsId: '4112bbea-dbb1-4372-b033-0e8c3848dcba', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                
                docker push jgimeneztc/pdj:latest
                }
                
                '''
            }
        }
    }
}
