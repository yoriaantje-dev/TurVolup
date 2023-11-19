cls
@echo off
set /p VersionNumber=VersionNumber? 
cd D:\PrivateDev\TurVolup\turven_bij_volupia
echo Building debug
call cmd.exe /c flutter build apk --debug
copy .\build\app\outputs\flutter-apk\app-debug.apk ..\app-releases\TurVolup_v%VersionNumber%-DEBUG.apk
echo Building release
call cmd.exe /c flutter build apk --release
copy .\build\app\outputs\flutter-apk\app-release.apk ..\app-releases\TurVolup_v%VersionNumber%.apk
echo Done, saved and exported.