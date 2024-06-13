@echo off

for /f "usebackq tokens=2 delims=\" %%a in (`reg query "HKEY_USERS" ^| findstr /r /x /c:"HKEY_USERS\\S-.*" /c:"HKEY_USERS\\AME_UserHive_[^_]*"`) do (
	reg query "HKU\%%a" | findstr /c:"Volatile Environment" /c:"AME_UserHive_" > nul 2>&1
	if not errorlevel 1 (
		for /f "usebackq tokens=2* delims= " %%b in (`reg query "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "AppData" 2^>^&1 ^| findstr /r /x /c:".*AppData[ ]*REG_SZ[ ].*"`) do (
			echo del "%%c\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk" /q /f
			del "%%c\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk" /q /f
			echo del "%%c\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk" /q /f
			del "%%c\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk" /q /f
		)
	)
)

for /f "usebackq tokens=2 delims=\" %%a in (`reg query "HKEY_USERS" ^| findstr /r /x /c:"HKEY_USERS\\S-.*" /c:"HKEY_USERS\\AME_UserHive_[^_]*"`) do (
	reg query "HKU\%%a" | findstr /c:"Volatile Environment" /c:"AME_UserHive_" > nul 2>&1
	if not errorlevel 1 (
		CALL :USERREG "%%a"
	)
)

for /f "usebackq delims=" %%e in (`reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" ^| findstr /i /r /c:"Microsoft[ ]*Edge" /c:"msedge"`) do reg delete "%%e" /f

for /f "usebackq delims=" %%a in (`dir /b /a:d "%SystemDrive%\Users" ^| findstr /v /i /x /c:"Public" /c:"Default User" /c:"All Users"`) do (
	echo del /q /f "%SystemDrive%\Users\%%a\Desktop\Microsoft Edge.lnk"
	del /q /f "%SystemDrive%\Users\%%a\Desktop\Microsoft Edge.lnk"

	:: WebView
	echo rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\EdgeWebView"
	rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\EdgeWebView"

	echo rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\Edge"
	rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\Edge"

	echo rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\EdgeUpdate"
	rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\EdgeUpdate"
	
	echo rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\EdgeCore"
	rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\EdgeCore"

	echo del /q /f "%SYSTEMDRIVE%\Users\%%a\Desktop\Microsoft Edge.lnk"
	del /q /f "%SYSTEMDRIVE%\Users\%%a\Desktop\Microsoft Edge.lnk"
	echo del /q /f "%SYSTEMDRIVE%\Users\%%a\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories\Internet Explorer.lnk"
	del /q /f "%SYSTEMDRIVE%\Users\%%a\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories\Internet Explorer.lnk"
)

for /f "usebackq tokens=1* delims=\" %%A in (`schtasks /query /fo list ^| findstr /c:"\MicrosoftEdge"`) do (
	schtasks /delete /tn "%%B" /f
)

exit /b 0

:USERREG
for /f "usebackq tokens=1 delims= " %%e in (`reg query "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" ^| findstr /i /c:"MicrosoftEdge" /c:"msedge"`) do (
	echo reg delete "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "%%e" /f
	reg delete "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "%%e" /f
)