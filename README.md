# Game Integrity Verifier
A tool that uploads your Black Ops 2 patches to google drive.

## General Information
- Tool is used to publish user's modified game files to allow verification of the integrity of these files. 
- Tool uses Gdrive and 7zip to execute successfully so if you don't have
  7z.exe or gdrive.exe in your C:\Windows directory, it installs it for you.
- You may need to authorize gdrive to upload files to your google drive. 
  [See Google Drive Authorization](#google-drive-authorization).
- Tool only works for Plutonium version of BO2.

## Google Drive Authorization
This script makes use of [Gdrive](https://github.com/prasmussen/gdrive), a tool used to interact with your google drive profile
through command line. You will be prompted in your terminal window to authorize the use of your profile for the initial execution of this 
script (uploading your patches). When prompted do the following:
- Click the link in your terminal.
- Allow gdrive to access your profile.
- Copy the authorization code given to you by google drive and paste it in your terminal then press enter.
- Script should now resume execution. 
- You will only be prompted for authorization once in your first startup of the script.

## Additional Nice-to-Have Features
- Download decompiler and decompile scripts before uploading.
- Encode stats into binary.
- OBS plugin to present link in some way on the recording/stream. 

