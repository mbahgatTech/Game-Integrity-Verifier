@REM @echo off
SET checkerPath=%CD%
SET patchesFolder=PlutoPatchFiles"%DATE%"
SET gamePath=C:\Users\%USERNAME%\AppData\Local\Plutonium\storage\t6\scripts\zm
SET decompilerPath=%CD%

echo Checking game files...

if exist %patchesFolder% (
    if not exist temp (
        MD temp
    )
    XCOPY %patchesFolder% temp
    RMDIR %patchesFolder%
)

MD %patchesFolder%
XCOPY %gamePath% %patchesFolder%

CD %patchesFolder%
 
