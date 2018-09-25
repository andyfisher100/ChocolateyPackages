$ErrorActionPreference = 'Stop';

Update-SessionEnvironment

#Get the windows installer path
$wpi = Get-Command WebPICMD | ForEach-Object { $_.Path }
"Installing $env:chocolateyPackageName using Microsoft Web Platform Installer"
Start-ChocolateyProcessAsAdmin $wpi -statements "/Install /Products:MicrosoftAzure-ServiceFabric-CoreSDK /AcceptEULA"