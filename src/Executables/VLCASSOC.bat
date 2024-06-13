@echo OFF
for /f "usebackq tokens=2 delims=\" %%A in (`reg query "HKEY_USERS" ^| findstr /r /x /c:"HKEY_USERS\\S-.*" /c:"HKEY_USERS\\AME_UserHive_[^_]*"`) do (
	REM If the "Volatile Environment" key exists, that means it is a proper user. Built in accounts/SIDs don't have this key.
	reg query "HKU\%%A" | findstr /c:"Volatile Environment" /c:"AME_UserHive_" > NUL 2>&1
		if not errorlevel 1 (
			PowerShell -NoP -ExecutionPolicy Bypass -File assoc.ps1 "Placeholder" "%%A" ".3g2:VLC.3g2" ".3gp:VLC.3gp" ".3gp2:VLC.3gp2" ".3gpp:VLC.3gpp" ".aac:VLC.aac" ".adts:VLC.adts" ".aif:VLC.aif" ".aifc:VLC.aifc" ".aiff:VLC.aiff" ".amr:VLC.amr" ".asf:VLC.asf" ".asx:VLC.asx" ".au:VLC.au" ".avi:VLC.avi" ".cda:VLC.cda" ".flac:VLC.flac" ".m1v:VLC.m1v" ".m2t:VLC.m2t" ".m2ts:VLC.m2ts" ".m3u:VLC.m3u" ".m4a:VLC.m4a" ".m4p:VLC.m4p" ".m4v:VLC.m4v" ".mid:VLC.mid" ".mka:VLC.mka" ".mkv:VLC.mkv" ".mov:VLC.mov" ".MP2:VLC.mp2" ".mp2v:VLC.mp2v" ".mp3:VLC.mp3" ".mp4:VLC.mp4" ".mp4v:VLC.mp4v" ".mpa:VLC.mpa" ".MPE:VLC.mpe" ".mpeg:VLC.mpeg" ".mpg:VLC.mpg" ".mpv2:VLC.mpv2" ".mts:VLC.mts" ".ra:VLC.ra" ".ram:VLC.ram" ".rmi:VLC.rmi" ".s3m:VLC.s3m" ".snd:VLC.snd" ".TS:VLC.ts" ".TTS:VLC.tts" ".voc:VLC.voc" ".wav:VLC.wav" ".wma:VLC.wma" ".wmv:VLC.wmv" ".WPL:VLC.wpl" ".wvx:VLC.wvx" ".xm:VLC.xm" ".zpl:VLC.zpl" 
	)
)