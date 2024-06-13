copy /y "amecs.exe" "%WINDIR%\System32"
copy /y "ameck.exe" "%WINDIR%\System32"

@echo OFF

for /f "usebackq delims=" %%A in (`dir /b /a:d "%SYSTEMDRIVE%\Users" ^| findstr /v /i /x /c:"Public" /c:"Default User" /c:"All Users"`) do (
	if exist "%SYSTEMDRIVE%\Users\%%A\AppData\Roaming\OpenShell\Pinned" (
		echo PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SYSTEMDRIVE%\Users\%%A\AppData\Roaming\OpenShell\Pinned\Central AME Script.lnk'); $S.TargetPath = '%WINDIR%\System32\amecs.exe'; $S.Save()"
		PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SYSTEMDRIVE%\Users\%%A\AppData\Roaming\OpenShell\Pinned\Central AME Script.lnk'); $S.TargetPath = '%WINDIR%\System32\amecs.exe'; $S.Save()"
	)
)