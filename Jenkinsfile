pipeline {
  agent any
  stages {
    stage('Prepare Parallel Build') {
      steps {
        script{
          bat 'powershell.exe  -file ./build_utils.ps1 jobconfigurator linkcopy "Win64,Android,WSAPlayer"'
        }
      }
    }

stage('Test') {
      parallel {
        stage('Test Windows') {
          steps {
           script {
	                def platform = "Win64"
	                def unity_project_version_file = readYaml file: 'ProjectSettings/ProjectVersion.txt'
	                def unity_version = unity_project_version_file.m_EditorVersion
	                def build_method ="AutoBuildScript.BuildCurrentPlatform"
                  def project_workspace = WORKSPACE+"/jobconfigurator"+ "-" + platform
	                if (isUnix()) {

	                } else {
	                    def unity_location = "\""+ UNITY_EDITORS_LOCATION +"\\"+ unity_version + "\\Editor\\Unity.exe\""
	                    bat unity_location + " -batchmode -runTests -testPlatform editmode -silent-crashes -stackTraceLogType Full -logfile - -testResults TestEditMode.xml -projectpath " + project_workspace
	         		    bat unity_location + " -batchmode -runTests -testPlatform playmode -silent-crashes -stackTraceLogType Full -logfile - -testResults TestPlayMode.xml -projectpath " + project_workspace
	         
	                }
	            }
   	            nunit testResultsPattern: "Test*.xml"
          }
        }

        stage('Test Android') {
          script {
	                def platform = "Android"
	                def unity_project_version_file = readYaml file: 'ProjectSettings/ProjectVersion.txt'
	                def unity_version = unity_project_version_file.m_EditorVersion
	                def build_method ="AutoBuildScript.BuildCurrentPlatform"
                  def project_workspace = WORKSPACE+"/jobconfigurator"+ "-" + platform
	                if (isUnix()) {

	                } else {
	                    def unity_location = "\""+ UNITY_EDITORS_LOCATION +"\\"+ unity_version + "\\Editor\\Unity.exe\""
	                    bat unity_location + " -batchmode -runTests -testPlatform editmode -silent-crashes -stackTraceLogType Full -logfile - -testResults TestEditMode.xml -projectpath " + project_workspace
	         		    bat unity_location + " -batchmode -runTests -testPlatform playmode -silent-crashes -stackTraceLogType Full -logfile - -testResults TestPlayMode.xml -projectpath " + project_workspace
	         
	                }
	            }
   	            nunit testResultsPattern: "Test*.xml"
          }
        }

        stage('Test UWP') {
          script {
	                def platform = "WSAPlayer"
	                def unity_project_version_file = readYaml file: 'ProjectSettings/ProjectVersion.txt'
	                def unity_version = unity_project_version_file.m_EditorVersion
	                def build_method ="AutoBuildScript.BuildCurrentPlatform"
                  def project_workspace = WORKSPACE+"/jobconfigurator"+ "-" + platform
	                if (isUnix()) {

	                } else {
	                    def unity_location = "\""+ UNITY_EDITORS_LOCATION +"\\"+ unity_version + "\\Editor\\Unity.exe\""
	                    bat unity_location + " -batchmode -runTests -testPlatform editmode -silent-crashes -stackTraceLogType Full -logfile - -testResults TestEditMode.xml -projectpath " + project_workspace
	         		    bat unity_location + " -batchmode -runTests -testPlatform playmode -silent-crashes -stackTraceLogType Full -logfile - -testResults TestPlayMode.xml -projectpath " + project_workspace
	         
	                }
	            }
   	            nunit testResultsPattern: "Test*.xml"
          }
        }

      }
    }
}

    stage('Build') {
      parallel {
        stage('Build Windows') {
          script {
                     def platform = "Win64"
                    def unity_project_version_file = readYaml file: 'ProjectSettings/ProjectVersion.txt'
                    def unity_version = unity_project_version_file.m_EditorVersion
                	def build_method =GetBuildMethodForPlatform(PLATFORM, BUILD_TYPE)
                  def project_workspace = WORKSPACE+"/jobconfigurator"+ "-" + platform
                    if (isUnix()) {

                    } else {
                        def unity_location = "\""+ UNITY_EDITORS_LOCATION +"\\"+ unity_version + "\\Editor\\Unity.exe\""
                        bat unity_location + " -quit -batchmode -executeMethod AutoBuildScript." + build_method + " -silent-crashes -stackTraceLogType Full -logfile - -projectpath " + project_workspace
                    }
                }
        }

        stage('Build Android') {
          script {
                     def platform = "Android"
                    def unity_project_version_file = readYaml file: 'ProjectSettings/ProjectVersion.txt'
                    def unity_version = unity_project_version_file.m_EditorVersion
                	def build_method =GetBuildMethodForPlatform(PLATFORM, BUILD_TYPE)
                  def project_workspace = WORKSPACE+"/jobconfigurator"+ "-" + platform
                    if (isUnix()) {

                    } else {
                        def unity_location = "\""+ UNITY_EDITORS_LOCATION +"\\"+ unity_version + "\\Editor\\Unity.exe\""
                        bat unity_location + " -quit -batchmode -executeMethod AutoBuildScript." + build_method + " -silent-crashes -stackTraceLogType Full -logfile - -projectpath " + project_workspace
                    }
                }
        }

        stage('Build UWP') {
          script {
                     def platform = "WSAPlayer"
                    def unity_project_version_file = readYaml file: 'ProjectSettings/ProjectVersion.txt'
                    def unity_version = unity_project_version_file.m_EditorVersion
                	def build_method =GetBuildMethodForPlatform(PLATFORM, BUILD_TYPE)
                  def project_workspace = WORKSPACE+"/jobconfigurator"+ "-" + platform
                    if (isUnix()) {

                    } else {
                        def unity_location = "\""+ UNITY_EDITORS_LOCATION +"\\"+ unity_version + "\\Editor\\Unity.exe\""
                        bat unity_location + " -quit -batchmode -executeMethod AutoBuildScript." + build_method + " -silent-crashes -stackTraceLogType Full -logfile - -projectpath " + project_workspace
                    }
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