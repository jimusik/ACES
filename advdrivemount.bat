echo off
reg add hklm\software\microsoft\windows\currentversion\run /v mapdrive /t REG_SZ /d c:\scripts\netuse.bat /f
if exists c:\scripts (
  goto next
  ) else (
  mkdir c:\scripts
  )
:next
if exists c:\scripts\netuse.bat (
  cp c:\scripts\netuse.bat c:\scripts\netuse%time%.bat
  del c:\scripts\netuse.bat
  )
echo @echo off > c:\scripts\netuse.bat
echo net use * /delete /yes >> c:\scripts\netuse.bat
echo call :checkcall 192.168.8. mount >> c:\scripts\netuse.bat
echo goto end >> c:\scripts\netuse.bat
echo :checkcall >> c:\scripts\netuse.bat
echo ipconfig ^| find /c "%%1" ^>NUL 2^>NUL >> c:\scripts\netuse.bat
echo if "%%errorlevel%%"=="1" goto :EOF >> c:\scripts\netuse.bat
echo if "%%errorlevel%%"=="0" goto %%2 >> c:\scripts\netuse.bat
echo :mount >> c:\scripts\netuse.bat
echo net use S: \\nas.advantage.support\Advantage /persistent:yes >> c:\scripts\netuse.bat
echo net use T: \\nas.advantage.support\Clients /persistent:yes >> c:\scripts\netuse.bat
echo net use U: \\nas.advantage.support\Data /persistent:yes >> c:\scripts\netuse.bat
echo :mount2 >> c:\scripts\netuse.bat
echo echo "Mount 2" >> c:\scripts\netuse.bat
echo :end  >> c:\scripts\netuse.bat
