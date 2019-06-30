pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'make' 
                echo 'Building ${env.PROJECT_NAME} ${env.PLATFORM} ${env.BUILD_ID}..'
            }
        }
        
    }
}