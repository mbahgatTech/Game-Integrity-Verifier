@echo OFF
@REM Request admin privileges and rerun if not already admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

@REM set directory variables
SET checkerPath=%~dp0%
SET patchesFolder=PlutoPatchFiles%date:~10,4%-%date:~4,2%-%date:~7,2%
SET gamePath=C:\Users\%USERNAME%\AppData\Local\Plutonium\storage\t6\scripts\zm

echo Checking game files...
CD %checkerPath%

@REM Back up last folder
if exist %patchesFolder% (
    rmdir /s /q %patchesFolder%\prev
    MD /y temp
    XCOPY /y %patchesFolder% temp\
    rmdir /s /q %patchesFolder%
)

MD /y %patchesFolder%
XCOPY /y  %gamePath% %patchesFolder%\

@REM Copy previous versions of the patches
MD %patchesFolder%\prev
XCOPY temp\ %patchesFolder%\prev\
rmdir /s /q temp\

@REM echo some stats about the patches
dir %cd%\%patchesFolder% > %patchesFolder%\stats
CD %checkerPath%

:7z
@REM Install 7-zip and copy executable to C:\Windows
if not exist C:\"Program Files"\7-Zip\ (
    echo Installing 7-Zip...
    powershell -command "start-bitstransfer -source https://www.7-zip.org/a/7z2107-x64.exe -destination %checkerPath%\7z2107-x64.exe"
    7z2107-x64.exe /S 
)

if exist C:\"Program Files"\7-Zip\7z.exe (
    XCOPY /y C:\"Program Files"\7-Zip\7z.exe C:\Windows\
)else (
    goto 7z
)

@REM Now check if gdrive exists in windows folder. install it if it doesn't
:gdrive
if not exist C:\Windows\gdrive.exe (
    echo Installing gdrive...
    powershell -command "start-bitstransfer -source https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_windows_386.tar.gz -destination %checkerPath%\gdrive_2.1.1_windows_386.tar.gz"

    @REM Extract gdrive files
    7z.exe e -y %checkerPath%\gdrive_2.1.1_windows_386.tar.gz
    7z.exe e -y %checkerPath%\gdrive_2.1.1_windows_386.tar 
    
    @REM Copy gdrive.exe to windows folder
    if exist %checkerPath%\gdrive.exe (
        XCOPY /y %checkerPath%\gdrive.exe C:\Windows
        DEL %checkerPath%\gdrive.exe
    ) else (
        goto gdrive
    )
)

@REM Some housekeeping
DEL %checkerPath%\gdrive_2.1.1_windows_386.tar.gz
DEL %checkerPath%\gdrive_2.1.1_windows_386.tar 
DEL %checkerPath%\gdrive.exe
DEL %checkerPath%\7z2107-x64.exe

:upload
@REM upload copies patches to google drive
echo Uploading patches to google drive...
gdrive.exe upload -r %patchesFolder%

echo %patchesFolder% > tempFile.txt
for %%? in (tempFile.txt) do ( SET /A len=%%~z? - 2 )
gdrive.exe list --name-width %len% > tempFile.txt

@REM Get ID of uploaded patches folder and share link 
@REM All parsing is done using python script
lib\dist\parseFile.exe
FOR /F "tokens=* delims=" %%x in (tempFile.txt) DO SET folderID=%%x

gdrive.exe share %folderID%
gdrive.exe info %folderID% > tempFile.txt
gdrive.exe info %folderID% >> %patchesFolder%\stats

lib\dist\parseFile.exe url

echo Uploaded patches successfully on %DATE% at %TIME%. >> %patchesFolder%\stats
timeout /t 100
