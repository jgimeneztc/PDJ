pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'building'
                
            
                sh '''
                set -ex
               
                
                
                '''
            
            }
        }

        stage('Tag') {
            steps {
                echo 'Tag'
            
                sh '''
                set -ex
                assas

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
            setGitHubPullRequestStatus("Build succeeded", "SUCCESS");
        }
        failure {
            setGitHubPullRequestStatus("Build succeeded", "SUCCESS");
        }
    }
}
