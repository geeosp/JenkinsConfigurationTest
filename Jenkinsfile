#!/usr/bin/env groovy
def UNITY_VERSION = "2019.1.8f1"

def BUILD_COMMAND = UNITY_EDITORS_LOCATION+UNITY_VERSION+"Unity.exe -batchmode -quit -silent-crashes -accept-apiupdate -stackTracelogtype Full -buildWindows64Player D:\\out\\"+  
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script{
                    bat  BUILD_COMMAND
                }
            }
        }
        
    }
}