# check if web installer is already installed
function test-FileExists 
{
    param (
        $filename)
        
    return Test-Path $filename
}

function get-programfilesdir 
{
    $programFiles = (Get-Item "Env:ProgramFiles").Value 
    return $programFiles
}

function get-osArchitecture
{
    return (Get-Item "Env:PROCESSOR_ARCHITECTURE").Value 
}

function install-WebPlatformInstaller
{
    Param(
        $url,
        $scriptPath)
    
    # install the service fabric sdk
    $msiPath = "$scriptPath\WebPlatformInstaller.msi"
    Invoke-WebRequest $url -OutFile $msiPath -UseBasicParsing;
    Start-Process "msiexec" -ArgumentList '/i', "$msiPath", '/passive', '/quiet', '/norestart', '/qn' -NoNewWindow -Wait;
    Remove-Item $msiPath
}

function install-ServiceFabricSdk
{
    Param(
        $installer)

    & $installer /Install /Products:MicrosoftAzure-ServiceFabric-CoreSDK /AcceptEULA
}

function install-chocolateypackage
{
    param(
        $toolspath
    )

    $osArch = get-osArchitecture    

    if ($osArch -eq "AMD64") {
        $url = "https://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/WebPlatformInstaller_amd64_en-US.msi"
        $exe = "WebpiCmd-x64.exe"        
    }
    else {
        $url = "https://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/WebPlatformInstaller_x86_en-US.msi"
        $exe = "WebpiCmd.exe"
    }

    $program_files = get-programfilesdir
    $webInstaller = "$program_files\Microsoft\Web Platform Installer\$exe"
    $VerifyWI = test-FileExists -filename $webInstaller

    if ($VerifyWI -eq $false)
    {
        install-WebPlatformInstaller -url $url -scriptPath $toolspath
    }

    install-ServiceFabricSdk -installer $webInstaller
}