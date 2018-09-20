$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsPath\sf-sdk-install.ps1"
  
try 
{
    install-chocolateypackage -toolspath $toolsPath
 
} catch {
    if ($_.Exception.InnerException) {
        $msg = $_.Exception.InnerException.Message
    } else {
        $msg = $_.Exception.Message
    }
    throw 
}