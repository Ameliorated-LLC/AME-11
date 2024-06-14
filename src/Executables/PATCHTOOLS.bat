copy /y "amecs.exe" "%WINDIR%\System32"
del /q /f "%WINDIR%\System32\ameck.exe"

@echo OFF

for /f "usebackq delims=" %%A in (`dir /b /a:d "%SYSTEMDRIVE%\Users" ^| findstr /v /i /x /c:"Public" /c:"Default User" /c:"All Users"`) do (
	if exist "%PROGRAMFILES%\Open-Shell" (
		mkdir "%SYSTEMDRIVE%\Users\%%A\AppData\Roaming\OpenShell\Pinned"
		echo PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SYSTEMDRIVE%\Users\%%A\AppData\Roaming\OpenShell\Pinned\Configure AME.lnk'); $S.TargetPath = '%WINDIR%\System32\amecs.exe'; $S.Save()"
		PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SYSTEMDRIVE%\Users\%%A\AppData\Roaming\OpenShell\Pinned\Configure AME.lnk'); $S.TargetPath = '%WINDIR%\System32\amecs.exe'; $S.Save()"
		del /q /f "%SYSTEMDRIVE%\Users\%%A\AppData\Roaming\OpenShell\Pinned\Central AME Script.lnk"
	)
)