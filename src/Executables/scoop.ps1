#Set-ExecutionPolicy RemoteSigned -Force -scope CurrentUser
iwr -useb get.scoop.sh -outfile 'install.ps1'
.\install.ps1 -RunAsAdmin -ScoopDir "$env:ProgramData\Scoop" -ScoopGlobalDir "$env:ProgramData\Scoop\GlobalScoopApps"
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

$sysPath = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + "$env:ProgramData\Scoop\shims"
setx path $sysPath -m
setx SCOOP "$env:ProgramData\Scoop" -m

icacls "$env:ProgramData\Scoop" /grant Everyone:F /t | Out-Null
icacls "$env:ProgramData\Scoop" /grant Users:F /t | Out-Null

scoop install git --global
scoop bucket add extras
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$forwardData = $env:ProgramData.Replace('\','/')
git config --global --add safe.directory "$forwardData/Scoop/buckets/extras"