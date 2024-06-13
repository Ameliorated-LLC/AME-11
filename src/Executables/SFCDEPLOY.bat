@echo OFF

:sfcCmdChecks

if not exist "%~dp0\sfc.exe" (
		echo. & echo No supplied sfc.exe detected
		exit /b 2
)

:sfc1ExeCheck

if exist "%SYSTEMROOT%\System32\sfc1.exe" (
	echo sfc1.exe already exists, assigning permissions... & echo.

	echo takeown /f "%SYSTEMROOT%\System32\sfc.exe" /a
	takeown /f "%SYSTEMROOT%\System32\sfc.exe" /a
	echo icacls "%SYSTEMROOT%\System32\sfc.exe" /grant Administrators:F
	icacls "%SYSTEMROOT%\System32\sfc.exe" /grant Administrators:F
	echo del /q /f "%SYSTEMROOT%\System32\sfc.exe"
	del /q /f "%SYSTEMROOT%\System32\sfc.exe"
)



:managePermissions

echo Assigning permissions and renaming sfc.exe... & echo.

@echo ON

if exist "%SYSTEMROOT%\System32\sfc.exe" (
	takeown /f "%SYSTEMROOT%\System32\sfc.exe" /a > NUL 2>&1
	icacls "%SYSTEMROOT%\System32\sfc.exe" /grant Administrators:F > NUL 2>&1
	rename "%SYSTEMROOT%\System32\sfc.exe" "sfc1.exe" > NUL 2>&1
)
copy /y "sfc.exe" "%SYSTEMROOT%\System32" 1> NUL

takeown /f "%SYSTEMROOT%\System32\en-US\sfc.exe.mui" /a > NUL 2>&1
icacls "%SYSTEMROOT%\System32\en-US\sfc.exe.mui" /grant Administrators:F > NUL 2>&1
rename "%SYSTEMROOT%\System32\en-US\sfc.exe.mui" "sfc1.exe.mui" > NUL 2>&1

PowerShell -NoP -C "Get-Acl '%SYSTEMROOT%\System32\diskmgmt.msc' | Set-Acl '%SYSTEMROOT%\System32\sfc.exe'" > NUL 2>&1
PowerShell -NoP -C "Get-Acl '%SYSTEMROOT%\System32\diskmgmt.msc' | Set-Acl '%SYSTEMROOT%\System32\sfc1.exe'" > NUL 2>&1
PowerShell -NoP -C "Get-Acl '%SYSTEMROOT%\System32\diskmgmt.msc' | Set-Acl '%SYSTEMROOT%\System32\sfc1.exe.mui'" > NUL 2>&1
goto complete

:complete

@echo Successfully deployed sfc modification.
@exit /b 0
