pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'building'
                withCredentials([
                    $class: "AmazonWebServicesCredentialsBinding",
                    credentialsId: 'aws_credential',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
            
                sh '''
                set -ex

                docker build --tag jgimeneztc/pdj:latest .                    
                aws ecr get-login --region us-east-2
                docker tag test-svc:latest https://922038103956.dkr.ecr.us-east-2.amazonaws.com/test-svc:latest
                docker push https://922038103956.dkr.ecr.us-east-2.amazonaws.com/test-svc:latest
                '''
            }
            }
        }
        //  stage('Tag') {
        //     steps {
        //         echo 'pushing'
                
                
        //         withCredentials([
        //             usernamePassword(
        //                 credentialsId: '4112bbea-dbb1-4372-b033-0e8c3848dcba',
        //                 usernameVariable: 'USERNAME',
        //                 passwordVariable: 'PASSWORD')
        //             ]) 
        //             {
        //             sh '''
        //             set -ex
        //                 // docker login -u="${USERNAME}" -p="${PASSWORD}" 

                       
    
        //                 // docker push jgimeneztc/pdj:latest
                    
        //             '''
        //         }
        //     }
        // }
    }
}