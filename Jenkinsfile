#!/usr/bin/env groovy
def UNITY_VERSION = "2019.1.8f1"

pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script{
              //      bat "git clean -fdx"
                    def BUILD_COMMAND = "D:\\Programs\\Windows\\Unity\\"+UNITY_VERSION+"\\Editor\\Unity.exe -batchmode -quit -silent-crashes -accept-apiupdate -stackTracelogtype Full -logfile "+  WORKSPACE+"\\Build\\build.log -buildWindows64Player "+WORKSPACE+"\\Build\\ -projectPath "+WORKSPACE
                    bat  BUILD_COMMAND
                }
            }
        }
        
    }
}