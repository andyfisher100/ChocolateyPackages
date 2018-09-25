$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'web-platform-installer'
  fileType       = 'msi'
  url            = 'https://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/WebPlatformInstaller_x86_en-US.msi'
  url64bit       = 'https://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/WebPlatformInstaller_amd64_en-US.msi'

  softwareName   = "Microsoft Web Platform Installer"

  checksum       = '4277D5F72F60DFDA6D5C8F750F99FE963E0ED44ADD73E7440FDA1BC05B510D25'
  checksumType   = 'sha256'
  checksum64     = 'FD3AA11DA27A4698D9FD1FB61DCB5CAE6D95ECF70554F0D655B0CAF44B0D0AC6'
  checksumType64 = 'sha256'

  silentArgs     = '/qn'
  validExitCodes = @(0, 3010, 1641)
}
Install-ChocolateyPackage @packageArgs