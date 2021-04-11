param (
    [Parameter(Mandatory = $true)][string]$projectSrcFolder,
    [Parameter(Mandatory = $true)][string]$function, 
    [Parameter(Mandatory=$true)][string]$mplatforms
)

function linkCopy ($srcFolder,$platform)
{
    Write-Host $srcFolder
    Write-Host $platform

    $CurrentFolder = Get-Location
    $PlatformSrcFolder = "$CurrentFolder/$srcFolder-$platform"
    Write-Host $PlatformSrcFolder
    $CannonSrcFolder = "$CurrentFolder\$srcFolder"
    
    New-item  $PlatformSrcFolder -ItemType "directory" -Force
    $files = Get-ChildItem -Path $CannonSrcFolder -File
    foreach ($file in $files) {
        New-Item -ItemType SymbolicLink -Path "$PlatformSrcFolder/$file" -Target "$CannonSrcFolder/$file" -Force
    }
    $folders = Get-ChildItem -Path $CannonSrcFolder -Directory
    foreach ($folder in $folders) {
        New-Item -ItemType SymbolicLink -Path "$PlatformSrcFolder/$folder" -Target "$CannonSrcFolder/$folder" -Force
    }
    
    
}
$mplatforms = $mplatforms.Replace(" ", "")
$platforms = $mplatforms.Split(",")
if ($function -eq "linkcopy") {
    
    foreach($platform in $platforms) {
        
        linkCopy $projectSrcFolder $platform 
   }

    
    
}



