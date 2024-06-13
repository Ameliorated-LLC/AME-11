

for /f "usebackq delims=" %%E in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers" /s /f "WLIDCredentialProvider" ^| findstr /c:"Credential Providers\\"`) do reg delete "%%E" /f

REM takeown /f "%WINDIR%\System32\en-US\credprovhost.dll.mui"
REM icacls "%WINDIR%\System32\en-US\credprovhost.dll.mui" /reset
REM certutil -hashfile "%WINDIR%\System32\en-US\credprovhost.dll.mui" md5 | findstr /i /c:"7AED5636DB4388798718F09C53348F49" /c:"36320488BF78869BD369013CBE93C22A" || EXIT /B 1

ame-hexer "%WINDIR%\System32\en-US\credprovhost.dll.mui" "4F 00 74 00 68 00 65 00 72 00 20 00 75 00 73 00 65 00 72" "4C 00 6F 00 67 00 69 00 6E 00 00 00 00 00 00 00 00 00 00"