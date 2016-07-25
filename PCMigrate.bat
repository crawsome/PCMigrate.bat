@echo. --Colin Burke -- 2016 --
@echo. --Batch file that --
@echo. Copies basic PC/User info --
@echo. Please close firefox before using. 
@echo.

@REM Set our original path for when program exits
@echo off
set "orgpath=%~dp0"

@REM Get our backup path
@echo. Where do you want to make the backup?
@echo. Press [F6] then [ENTER] when done. 
FOR /F "tokens=*" %%A IN ('MORE') DO SET INPUT=%%A
set "backpath=%INPUT%\Backup"

@REM 1. Make directories and CD into our backup path
@echo. 1.Making Backup Directory at %backpath%...
mkdir %backpath%
mkdir %backpath%\pcinfo\
mkdir %backpath%\wallpaper\
mkdir %backpath%\mozilla\
mkdir %backpath%\outlook\
cd %backpath%
@echo.

@REM 2. Move Desktop Picture
@echo. 2.Moving desktop picture to backup...
xcopy %AppData%\Microsoft\Windows\Themes\TranscodedWallpaper.jpg %backpath%\wallpaper
@echo.

@REM 3. Move IP information to backup
@echo. 3.Moving IP information to backup...
ipconfig /all > %backpath%\pcinfo\ipconfig.txt
echo User name %USERNAME%, logged into %COMPUTERNAME%, On domain %USERDOMAIN% > %backpath%\pcinfo\userinfo.txt
netstat -r > %backpath%\pcinfo\routes.txt
@echo.

@REM 4. Copy printer info to backup
@echo. 4.Copying all printer info to backup...
cd C:\Windows\System32\Printing_Admin_Scripts\en-US\
cscript prndrvr.vbs -l > %backpath%\pcinfo\printerdriverinfo.txt
cscript prnport.vbs -l > %backpath%\pcinfo\printerports.txt
cd %backpath%
@echo.

@REM 5. Copy Outlook info to backup
@echo. 5.Moving outlook folders to backup...
xcopy "C:\users\%USERNAME%\Documents\Outlook" %backpath%\outlook /E /h
xcopy "%AppData%\Microsoft\Outlook" %backpath%\outlook  /E /h
xcopy "%AppData%\Microsoft\Outlook" %backpath%\outlook /E /h
xcopy "C:\Users\%USERNAME%\Documents\Outlook Files" %backpath%\outlook /E /h
xcopy "C:\Users\%USERNAME%\My Documents\Outlook Files" %backpath%\outlook /E /h
@echo.

@REM 6. Copy Firefox profile (Not doing chrome or IE)
@echo. 6. Retrieve Firefox profile data
xcopy "%appdata%\Mozilla" %backpath%\mozilla /E /h
@echo.

@REM 7. Remind user where data is stored.
@echo. BACKUP LOCATED AT %backpath%

@REM 8. CD back to original path
cd %orgpath%
