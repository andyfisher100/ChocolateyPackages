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
    return get-osArchitecture
}

function install-WebPlatformInstaller
{
    Param(
        $url,
        $scriptPath)
    
    # install the service fabric sdk
    $outpath = Invoke-WebRequest $url -OutFile "$scriptPath\WebPlatformInstaller.msi" -UseBasicParsing;
    Start-Process "msiexec" -ArgumentList '/i', $outpath, '/passive', '/quiet', '/norestart', '/qn' -NoNewWindow -Wait; 
    Remove-Item $outpath
}

function install-ServiceFabricSdk
{
    Param(
        $installer)

    & $installer /Install /Products:MicrosoftAzure-ServiceFabric-CoreSDK /AcceptEULA
}

function install-chocolateypackage
{
    $script_path = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
    $osArch = get-osArchitecture    

    if ($osArch -eq 64) {
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
        install-WebPlatformInstaller -url $url -scriptPath $script_path
    }

    install-ServiceFabricSdk -installer $installer
}