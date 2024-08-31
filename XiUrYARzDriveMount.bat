@echo off
set tm=%TIME::=-%

:: Ensure the scripts directory exists
if not exist c:\scripts (
  mkdir c:\scripts
)

:: Add registry entry to run the script at startup
reg add hklm\software\microsoft\windows\currentversion\run /v mapdrive /t REG_SZ /d "c:\scripts\netuse.bat" /f

:: Check if the script exists and manage old versions
if exist c:\scripts\netuse.bat (
  certutil -hashfile c:\scripts\netuse.bat MD5 | find "b9f4c73a9f83507ea1de858661ca8cf0" >nul
  if not errorlevel 1 (
    :: If hash matches, skip to EOF
    goto EOF
  )
  :: If hash does not match, back up the old script and create a new one
  copy c:\scripts\netuse.bat c:\scripts\netuse%tm%.bat
  del c:\scripts\netuse.bat
)
:: Create the new netuse.bat script
(
  echo @echo off
  echo net use * /delete /yes
  echo :mount
  echo net use M: \\CFM-S-NAS1\networkshares\eClinicalWorks_Documents /persistent:yes
  echo net use U: \\CFM-S-NAS1\networkshares\UserDrives\%%username%% /persistent:yes
  echo :end
) > c:\scripts\netuse.bat

:EOF
