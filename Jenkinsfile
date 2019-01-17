pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'building'
                
                sh '''
                set -ex
                docker build tag pdj:latest -t "${JOB_NAME}".
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
