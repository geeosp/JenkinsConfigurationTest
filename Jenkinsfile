pipeline {
  agent any
  stages {
    stage('Prepare Parallel Build') {
      steps {
        powershell 'script'
      }
    }

stage('Test') {
      parallel {
        stage('Test Windows') {
          steps {
            powershell(script: 'build.ps1', returnStatus: true, returnStdout: true)
          }
        }

        stage('Test Android') {
          steps {
            powershell(script: 'build.ps1', returnStdout: true, returnStatus: true)
          }
        }

        stage('Test UWP') {
          steps {
            powershell(script: 'build.ps1', returnStdout: true, returnStatus: true)
          }
        }

      }
    }


    stage('Build') {
      parallel {
        stage('Build Windows') {
          steps {
            powershell(script: 'build.ps1', returnStatus: true, returnStdout: true)
          }
        }

        stage('Build Android') {
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

    

    stage('Archive Artifacts') {
      steps {
        archiveArtifacts 'asdasd'
      }
    }

  }
}