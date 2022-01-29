# Game Integrity Verifier
A tool that uploads your Black Ops 2 patches to google drive.

## General Information
- Script uses Gdrive and 7zip to execute successfully so if you don't have<br>
  7z.exe or gdrive.exe in your C:\Windows directory, it installs it for you.
- You may need to authorize gdrive to upload to files to your google drive. 
  [See Google Drive Authorization](#google-drive-authorization).
- Tool only works for Plutonium version of BO2.

## Google Drive Authorization
This script makes use of [Gdrive](https://github.com/prasmussen/gdrive), a tool used to interact with your google drive profile<br>
through command line. You may be prompted in your terminal window to authorize the <br>
use of your profile for the execution of this script (uploading your patches).<br>When prompted do the following:
- Click the link in your terminal.
- Allow gdrive to access your profile.
- Copy the authorization code given to you by google drive and paste it in your <br>
  terminal then press enter.
- Script should now resume execution. 
- You will likely only be prompted for authorization once in your first startup of the script.

## TO-DO
- Install 7z.exe if it doesnt exist in Windows directory and Program Files.
- Delete any .tar/.zip/.exe files in the working directory after copying them to their target directories.
- Might be useful to echo some variables for each .gsc file to a stats file.
    ### Use:
    - Record the name of the file with the last date it was modified. 
    - Record the size of the file.***
    - Record the date and time this operation is being executed.
    - Goal is to reduce possible file modifications to the uploaded files. 

## Additional Nice-to-Have Features
- Download decompiler and decompile scripts before uploading.

