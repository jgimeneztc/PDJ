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
                
                
                withCredentials([
                    usernamePassword(
                        credentialsId: '4112bbea-dbb1-4372-b033-0e8c3848dcba',
                        usernameVariable: 'USERNAME',
                        passwordVariable: 'PASSWORD')
                    ]) 
                    {
                    sh '''
                    set -ex
                        echo "${USERNAME}"
                        echo "${PASSWORD}"
                        docker login -u="${USERNAME}" -p="${PASSWORD}" 
                        docker push jgimeneztc/pdj:latest
                    
                    '''
                }
            }
        }
    }
}
