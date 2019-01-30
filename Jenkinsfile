pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'building'
                
            
                sh '''
                set -ex
                exit 1
               
                
                
                '''
            
            }
        }

        stage('Tag') {
            steps {
                echo 'Tag'
            
                sh '''
                set -ex
                

                '''
            
            }
        }
        
        stage('Push') {
            steps {
                echo 'Push'
               
            }
        }
        
         
    }
    post {
        success {
            setBuildStatus("Build succeeded", "SUCCESS");
        }
        failure {
            setBuildStatus("Build succeeded", "SUCCESS");
        }
    }
}
