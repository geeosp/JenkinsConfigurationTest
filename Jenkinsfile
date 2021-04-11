pipeline {
  agent any
  stages {
    stage('Prepare Parallel Build') {
      steps {
        powershell 'script'
      }
    }

    stage('Build for Windows') {
      parallel {
        stage('Build for Windows') {
          steps {
            powershell(script: 'build.ps1', returnStatus: true, returnStdout: true)
          }
        }

        stage('Build for Android') {
          steps {
            powershell(script: 'build.ps1', returnStdout: true, returnStatus: true)
          }
        }

        stage('Build UWP') {
          steps {
            powershell(script: 'build.ps1', returnStdout: true, returnStatus: true)
          }
        }

      }
    }

    stage('Test') {
      steps {
        powershell 'Test Windows'
      }
    }

    stage('Archive Artifacts') {
      steps {
        archiveArtifacts 'asdasd'
      }
    }

  }
}