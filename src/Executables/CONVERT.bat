

for /f "usebackq delims=" %%E in (`PowerShell -NoP -C "(Get-LocalUser | Where {$_.PrincipalSource -eq 'MicrosoftAccount'}).Name"`) do call :CONVERTUSER "%%E"



for /f "usebackq delims=" %%E in (`reg query "HKLM\SOFTWARE\Microsoft\IdentityStore\LogonCache\Name2Sid" ^| findstr /i /c:"Name2Sid"`) do reg delete "%%E" /f
for /f "usebackq delims=" %%E in (`reg query "HKLM\SOFTWARE\Microsoft\IdentityStore\LogonCache\Sid2Name" ^| findstr /i /c:"Sid2Name"`) do reg delete "%%E" /f

rmdir /q /s "%WINDIR%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\CloudAPCache"
rmdir /q /s "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc"

for /f "usebackq delims=" %%E in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers" /s /f "NGC Credential Provider" ^| findstr /c:"Credential Providers\\"`) do reg delete "%%E" /f

for /f "usebackq delims=" %%E in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers" /s /f "WLIDCredentialProvider" ^| findstr /c:"Credential Providers\\"`) do reg delete "%%E" /f

for /f "usebackq delims=" %%E in (`reg query "HKLM\SOFTWARE\Microsoft\IdentityStore\Providers" /s /f "MicrosoftAccount" ^| findstr /c:"Providers\\"`) do reg delete "%%E" /f

exit /b 0

:CONVERTUSER

for /f "usebackq delims=" %%E in (`reg query "HKLM\SAM\SAM\Domains\Account\Users" ^| findstr /i /c:"Account\Users"`) do (

	for /f "usebackq tokens=1 delims= " %%F in (`reg query "%%E" ^| findstr /r /c:"[]*Internet" /c:"GivenName" /c:"Surname"`) do reg delete "%%E" /v "%%F" /f

)

for /f "usebackq delims=" %%E in (`PowerShell -NoP -C "(New-Object -ComObject Microsoft.DiskQuota).TranslateLogonNameToSID('%~1')"`) do set "userSID=%%E"

reg add "HKU\%userSID%\SOFTWARE\Microsoft\Windows\CurrentVersion\AccountState" /v "ExplicitLocal" /t REG_DWORD /d 1 /f

reg delete "HKU\%userSID%\SOFTWARE\Microsoft\IdentityCRL" /f

for /f "usebackq delims=" %%E in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers" /s /f "%userSID%" ^| findstr /c:"%userSID%"`) do reg delete "%%E" /f

net user "%~1" /fullname:""
net user "%~1" malte