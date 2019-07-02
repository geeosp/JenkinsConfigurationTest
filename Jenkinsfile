#!/usr/bin/env groovy
def UNITY_VERSION = "2019.1.8f1"

pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script{
                    def BUILD_COMMAND = "D:\\Programs\\Windows\\Unity"+UNITY_VERSION+"\\Editor\\Unity.exe -batchmode -quit -silent-crashes -accept-apiupdate -stackTracelogtype Full -buildWindows64Player D:\\out\\" 
                    bat  BUILD_COMMAND
                }
            }
        }
        
    }
}