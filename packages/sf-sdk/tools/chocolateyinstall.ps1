$script_path = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$install_Script = $(Join-Path $script_path "sf-sdk-install.ps1")
. $install_Script
  
try {    
    chocolatey-install   
} catch {
    if ($_.Exception.InnerException) {
        $msg = $_.Exception.InnerException.Message
    } else {
        $msg = $_.Exception.Message
    }
    throw 
}