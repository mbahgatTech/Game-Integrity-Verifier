@REM Request admin privileges and rerun if not already admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

@REM set directory variables
SET checkerPath=%~dp0%
SET patchesFolder=PlutoPatchFiles"%DATE%"
SET gamePath=C:\Users\%USERNAME%\AppData\Local\Plutonium\storage\t6\scripts\zm

echo Checking game files...
CD %checkerPath%

@REM Back up
if exist %patchesFolder% (
    MD /y temp
    XCOPY /y %patchesFolder% temp\
    CD %patchesFolder%
    for %%i in (*) do (DEL %%i)  
    CD %checkerPath%
    rmdir /s /q %patchesFolder%
)

MD /y %patchesFolder%
XCOPY /y  %gamePath% %patchesFolder%\

CD %checkerPath%

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

@REM upload copies patches to google drive
echo Uploading patches to google drive...
gdrive.exe upload --recursive %patchesFolder%
timeout /t 10
