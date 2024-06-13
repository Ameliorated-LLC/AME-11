@echo OFF

for /f "usebackq tokens=2 delims=\" %%A in (`reg query "HKEY_USERS" ^| findstr /c:"Classes"`) do (
		call :UICALL1 "%%A"
)

for /f "usebackq tokens=2 delims=\" %%A in (`reg query "HKEY_USERS" ^| findstr /r /x /c:"HKEY_USERS\\S-.*" /c:"HKEY_USERS\\AME_UserHive_[^_]*"`) do (
	reg query "HKU\%%A" | findstr /c:"Volatile Environment" /c:"AME_UserHive_" > NUL 2>&1
		if not errorlevel 1 call :UICALL2 "%%A"
)

@exit /b 0


:UICALL1

@echo ON
:: Context Menu
reg add "HKU\%~1\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
reg add "HKU\%~1\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /t REG_SZ /d "" /f

:: Old Explorer Search
reg add "HKU\%~1\CLSID\{1d64637d-31e9-4b06-9124-e83fb178ac6e}" /f
reg add "HKU\%~1\CLSID\{1d64637d-31e9-4b06-9124-e83fb178ac6e}\TreatAs" /t REG_SZ /d "{64bc32b5-4eec-4de7-972d-bd8bd0324537}" /f
@echo OFF
exit /b 0

:UICALL2

@echo ON

reg add "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f
reg add "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 1 /f
@echo OFF
exit /b 0