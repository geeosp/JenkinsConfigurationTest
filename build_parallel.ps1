param (
   [Parameter(Mandatory = $true)][string][ValidateSet('test', 'build', 'dlc', 'parse', IgnoreCase)]$FUNCTION_CALL, #test/build/dlc/parse
   [Parameter (Mandatory=$true)][string]$mplatforms,#Unity platfoms to build, in string format, separated by comma: Ex: "Win64,PS4,XboxOne"
   [Parameter(Mandatory = $true)][string][ValidateSet('Test', 'Live', 'Dev')]$BUILD_TYPE, #Dev/Live/Test
   [Parameter(Mandatory = $true)][string]$WORKSPACE_DIR, #path to Unity project, parent of Assets and ProjectSettings
   [Parameter(Mandatory = $true)][string]$UNITY_TOOL, #Path to Unity version folder: The parent of Editor/Unity.exe
   [Parameter(Mandatory = $true)][string]$ORBIS_SDK_TOOL, #path to orbis installation
   [Parameter(Mandatory = $true)][string]$DURANGO_XDK_TOOL, #path to durango installation
   [Parameter(Mandatory = $true)][string]$SWITCH_SDK_FOR_UNITY, #path to switch sdk for provided unity version
   [Parameter(Mandatory = $true)][string]$PYTHON_TOOL# Path to python installation
   
   #[Parameter(Mandatory = $true)][string]$SCE_ORBIS_SDK_DIR,
)

$platforms = $mplatforms.Split(",")
Write-Host "[Kokku] Workspace directory : $WORKSPACE_DIR"
Write-Host "[Kokku] Target Platform: $TARGET_PLATFORM"
Write-Host "[Kokku] Build Type: $BUILD_TYPE"
Write-Host "[Kokku] Unity tool: $UNITY_TOOL"
Write-Host "[Kokku] Orbis SDK tool: $ORBIS_SDK_TOOL"
Write-Host "[Kokku] Durango SDK tool: $DURANGO_XDK_TOOL"
Write-Host "[Kokku] Switch SDK tool: $SWITCH_SDK_FOR_UNITY"
Write-Host "[Kokku] Python tool: $PYTHON_TOOL"



$env:Path = "$ORBIS_SDK_TOOL\host_tools\bin;$env:Path"
$env:SCE_ORBIS_SDK_DIR = $ORBIS_SDK_TOOL
$env:SCE_ROOT_DIR = $ORBIS_SDK_TOOL

$env:DurangoXDK = "$DURANGO_XDK_TOOL\XDK\"
$env:XboxOneExtensionSDKLatest = "$DURANGO_XDK_TOOL\180712\v8.0\"
$env:XboxOneXDKLatest = "$DURANGO_XDK_TOOL\180712\"

$env:NINTENDO_SDK_ROOT = "$SWITCH_SDK_FOR_UNITY"

$env:PythonPath = $PYTHON_TOOL

$name = "$UNITY_TOOL/Editor/Unity.exe"


#turn off the firewall
Set-NetFirewallProfile -All -Enabled False
Set-NetFirewallProfile -Profile Domain, Private, Public -Enabled False



Set-Content "build.log" ""

function PrintLogFile ($platform,$logType,   $logFile){
   Write-Host $platform
   Write-Host  $logType
   Write-Host  $logFile
   Write-Host "[Kokku] ------------ Begin of $logType Log for $platform ------------"
   gc $logFile
   Write-Host "[Kokku] ------------ End of $logType Log for $platform ------------"

}

if ($FUNCTION_CALL -eq "test") {

   $testProcesses = @()
   $errorCode = 0
   For ($i = 0; $i -lt $platforms.Count; $i++) {
      $TARGET_PLATFORM = $platforms[$i]
      Write-Host "[Kokku] Start $TARGET_PLATFORM  Unity Edit Mode Testing Process:"
      $params = '-runTests','testPlatform',  $TARGET_PLATFORM , '-testResults',"$WORKSPACE_DIR/TestResults/$TARGET_PLATFORM.xml" , '-buildTarget', $TARGET_PLATFORM,  '-projectPath', "$WORKSPACE_DIR-$TARGET_PLATFORM", '-logFile', "$WORKSPACE_DIR/Logs/$TARGET_PLATFORM-Test.log", '-batchmode'
      #   Write-Host "Arguments for $TARGET_PLATFORM $params"
      $process = Start-Process -FilePath $name $params -PassThru -NoNewWindow
      $testProcesses += $process
   }
   For ($i = 0; $i -lt $platforms.Count; $i++) {
      $process = $testProcesses[$i]
      $platform = $platforms[$i]
      $process.WaitForExit()
      $exitCode = $process.ExitCode
      PrintLogFile $platform "Test" "$WORKSPACE_DIR/Logs/$TARGET_PLATFORM-Test.log"
      Write-Host "[Kokku] Test EditMode for $platform Finished with ExitCode $exitCode"
   }



exit 0# $errorCode


}

if ($FUNCTION_CALL -eq "build") {

   $buildProcesses = @()
   For ($i = 0; $i -lt $platforms.Count; $i++) {
      $TARGET_PLATFORM = $platforms[$i]
      Write-Host "[Kokku] Start $TARGET_PLATFORM  Unity Build Process:"
      $params = '-batchmode', 'nographics', '-buildTarget', $TARGET_PLATFORM, "-BuildType $BUILD_TYPE", '-executeMethod', 'BuildingTools.GenericBuild', '-quit', '-projectPath', "$WORKSPACE_DIR-$TARGET_PLATFORM", '-logFile', "$WORKSPACE_DIR/Logs/$TARGET_PLATFORM-Build.log"
      Write-Host "Arguments for $TARGET_PLATFORM $params"
      $process = Start-Process -FilePath $name $params -PassThru -NoNewWindow  
      $buildProcesses += $process
   }
   $errorCode = 0
   
   For ($i = 0; $i -lt $platforms.Count; $i++) {
      $process = $buildProcesses[$i]
      $platform = $platforms[$i]
      $process.WaitForExit()
      PrintLogFile $platform "Build" "$WORKSPACE_DIR/Logs/$TARGET_PLATFORM-Build.log"
   }
   exit 0#$errorCode;
}

if($FUNCTION_CALL -eq "clean"){
   Write-Host "[Kokku] Start Cleaning build:"

}
