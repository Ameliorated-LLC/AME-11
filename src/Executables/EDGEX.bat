:: Removes ActiveX item in open with menu
reg delete "HKCR\Applications\iexplore.exe" /f

:: Removes ActiveX item in open with menu for XML files
reg delete "HKCR\xmlfile" /f

:: Removes internet explorer option when setting default browser in settings
reg delete "HKLM\SOFTWARE\Microsoft\Internet Explorer" /f
reg delete "HKLM\SOFTWARE\RegisteredApplications" /v "Internet Explorer" /f
reg delete "HKLM\SOFTWARE\Clients\StartMenuInternet\IEXPLORE.EXE" /f