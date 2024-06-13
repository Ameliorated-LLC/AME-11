
reg query "HKLM\SOFTWARE\Clients\StartMenuInternet" /k /f "Firefox-" > "%TEMP%\Firefox-Reg-Output.txt"

set "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install -y --force --allow-empty-checksums firefox thunderbird vlc 7zip jpegview vcredist-all directx onlyoffice cascadiamono

:: Load Open-Shell menu
PowerShell -NoP -C "(New-Object -ComObject wscript.shell).SendKeys('^{ESCAPE}')"
timeout /t 1 > NUL
PowerShell -NoP -C "(New-Object -ComObject wscript.shell).SendKeys('^{ESCAPE}')"

::@PowerShell -NoP -ExecutionPolicy Bypass -C "choco install -y --force --allow-empty-checksums -n eartrumpet"

::if exist "%ALLUSERSPROFILE%\chocolatey\lib\eartrumpet\tools\release.zip" (
::	echo PowerShell -NoP -C "Expand-Archive -Path '%ALLUSERSPROFILE%\chocolatey\lib\eartrumpet\tools\release.zip' -DestinationPath '%ALLUSERSPROFILE%\EarTrumpet'"
::	PowerShell -NoP -C "Expand-Archive -Path '%ALLUSERSPROFILE%\chocolatey\lib\eartrumpet\tools\release.zip' -DestinationPath '%ALLUSERSPROFILE%\EarTrumpet'"
::	echo rmdir /q /s "%ALLUSERSPROFILE%\chocolatey\lib\eartrumpet"
::	rmdir /q /s "%ALLUSERSPROFILE%\chocolatey\lib\eartrumpet"
::	echo mkdir "%SYSTEMDRIVE%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
::	mkdir "%SYSTEMDRIVE%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
::	echo PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SYSTEMDRIVE%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\EarTrumpet.lnk'); $S.TargetPath = '%ALLUSERSPROFILE%\EarTrumpet\EarTrumpet.exe'; $S.Save()"
::	PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SYSTEMDRIVE%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\EarTrumpet.lnk'); $S.TargetPath = '%ALLUSERSPROFILE%\EarTrumpet\EarTrumpet.exe'; $S.Save()"
::)