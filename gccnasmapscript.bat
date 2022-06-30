echo off
reg add hklm\software\microsoft\windows\currentversion\run /v mapdrive /t REG_SZ /d c:\scripts\netuse.bat /f
mkdir c:\scripts
echo net use * /delete /yes > c:\scripts\netuse.bat
echo net use S: "\\GCC-NAS2\Share" /user:%%username%% >> c:\scripts\netuse.bat