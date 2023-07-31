# Usage: PowerShell .\wsl_backup.ps1

PowerShell -Command "Set-ExecutionPolicy Unrestricted"
$DateTime = Get-Date -Format "yyyyMMdd_HHmmss"
$FileName = "E:\wsl_ubuntu_20_$DateTime.tar"
wsl --export Ubuntu-20.04 $FileName
