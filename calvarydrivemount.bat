echo off
set tm=%TIME::=-%
if exist c:\scripts (
  goto next
  ) else (
  mkdir c:\scripts
  )
:next
if exist c:\scripts\netuse.bat (
  copy c:\scripts\netuse.bat c:\scripts\netuse%tm%.bat
  del c:\scripts\netuse.bat
  )
echo @echo off > c:\scripts\netuse.bat
echo net use * /delete /yes >> c:\scripts\netuse.bat
echo call :checkcall 192.168.0. mount >> c:\scripts\netuse.bat
echo goto end >> c:\scripts\netuse.bat
echo :checkcall >> c:\scripts\netuse.bat
echo ipconfig ^| find /c "%%1" ^>NUL 2^>NUL >> c:\scripts\netuse.bat
echo if "%%errorlevel%%"=="1" goto :EOF >> c:\scripts\netuse.bat
echo if "%%errorlevel%%"=="0" goto %%2 >> c:\scripts\netuse.bat
echo :mount >> c:\scripts\netuse.bat
echo net use N: \\nas.calvarycorvallis.org\AdminShare /persistent:yes >> c:\scripts\netuse.bat
echo net use F: \\nas.calvarycorvallis.org\Financial /persistent:yes >> c:\scripts\netuse.bat
echo net use G: \\nas.calvarycorvallis.org\GeneralShare /persistent:yes >> c:\scripts\netuse.bat
echo net use M: \\nas.calvarycorvallis.org\Media /persistent:yes >> c:\scripts\netuse.bat
echo :mount2 >> c:\scripts\netuse.bat
echo echo "Mount 2" >> c:\scripts\netuse.bat
echo :end  >> c:\scripts\netuse.bat