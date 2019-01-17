pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'building'
                
                sh '''
                set -ex
                docker build -t "${JOB_NAME}" .
                '''
            }
        }
    }
}
