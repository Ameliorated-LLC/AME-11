for /f "usebackq tokens=2 delims=\" %%A in (`reg query "HKEY_USERS" ^| findstr /r /x /c:"HKEY_USERS\\S-.*" /c:"HKEY_USERS\\AME_UserHive_[^_]*"`) do (
	if "%%A"=="AME_UserHive_Default" (
		call :SETTINGSCALL "%SYSTEMDRIVE%\Users\Default\AppData\Roaming"
	) else (
		for /f "usebackq tokens=2* delims= " %%B in (`reg query "HKU\%%A\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "AppData" 2^>^&1 ^| findstr /R /X /C:".*AppData[ ]*REG_SZ[ ].*"`) do (
			call :SETTINGSCALL "%%C"
		)
	)
)
exit /b 0

:SETTINGSCALL

mkdir "%1\nomacs\Image Lounge"
copy /y "nomacssettings.ini" "%1\nomacs\Image Lounge\settings.ini"