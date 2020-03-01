pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script{
                    def platform  = PLATFORM
                    def unity_project_version_file = readYaml file: 'ProjectSettings/ProjectVersion.txt'
                    def unity_version = unity_project_version_file.m_EditorVersion
                    def buid_method = "PerformWindowsBuild"
                    if(platform=="windows"){
                         buid_method = "PerformWindowsBuild"
                    }else if(platform=="android"){
                        build_method = "PerformAndroidBuild"
                    }else if(platform=="ios"){
                        build_method = "PerformIOSBuild"
                    } else if(platform=="windows_uas"){
                        build_method = "PerformWindowsUniversalAppStoreBuild"
                    }
                    if(BUILD_TYPE=="develop"){
                        buid_method=buid_method+"Develop"
                    }
                    if(isUnix()){
                     	
                    }else{
	                    def unity_location = "D:\\Programs\\Windows\\Unity\\"+ unity_version+ "\\Editor\\Unity.exe" 
	                    bat unity_location + " -quit -batchmode -executeMethod AutoBuildScript."+ buid_method+" -silent-crashes -stackTraceLogType Full -logfile ./Builds/"+ platform+ "/build.log -projectpath "+WORKSPACE
                    }
                }
            }
            post{
                success{
                    office365ConnectorSend message: "Build Sucessifull", webhookUrl:"https://outlook.office.com/webhook/b9949e65-9e33-4de0-9ca9-02069d1fed8e@7f347c10-2b11-4d69-8c0f-ec32980bdb29/IncomingWebhook/41387506ea1d426092d38bde80fd942f/fc45340d-61f3-4ccf-b294-725b91663df1"
                }
                failure{

office365ConnectorSend message: "Build Failed", webhookUrl:"https://outlook.office.com/webhook/b9949e65-9e33-4de0-9ca9-02069d1fed8e@7f347c10-2b11-4d69-8c0f-ec32980bdb29/IncomingWebhook/41387506ea1d426092d38bde80fd942f/fc45340d-61f3-4ccf-b294-725b91663df1"
           
                }
            }
        }
        
    }
}