@echo off
setlocal
REM grab time
set tm=%TIME::=-%
REM Define log file path
set LOGFILE=C:\Windows\Temp\XiUrYARz_log.txt
REM Define the registry path and value name
set KEY_PATH=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
set VALUE_NAME=MapDrive
set EXPECTED_VALUE=c:\scripts\netuse.bat

REM Write a start message to the log file
echo [%date% %time%] Starting batch file >> %LOGFILE%

REM Query the registry for the value
reg query "%KEY_PATH%" /v "%VALUE_NAME%" >nul 2>&1

REM Check if the query was successful
if %ERRORLEVEL% equ 0 (
    REM If successful, check the actual value data
    for /f "tokens=2,*" %%A in ('reg query "%KEY_PATH%" /v "%VALUE_NAME%" 2^>nul') do (
        if "%%B"=="%EXPECTED_VALUE%" (
            echo [%date% %time%] Registry Key already created >> %LOGFILE%
        ) else (
            echo Registry value exists but with different data.
        )
    )
) else (
    :: Add registry entry to run the script at startup
    echo [%date% %time%] writing to the registery >> %LOGFILE%
    reg add "%KEY_PATH%" /v "%VALUE_NAME%" /t REG_SZ /d "%EXPECTED_VALUE%" /f
)

:: Ensure the scripts directory exists
if not exist c:\scripts (
  echo [%date% %time%] missing script file, creating now >> %LOGFILE%
  mkdir c:\scripts
)

:: Check if the script exists and manage old versions
if exist c:\scripts\netuse.bat (
  certutil -hashfile c:\scripts\netuse.bat MD5 | find "02d6598e4221dc5cbf4650b3b36c9710" >nul
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
  echo net use M: \\CFM-S-NAS1\networkshares\share /persistent:yes
  echo net use U: \\CFM-S-NAS1\networkshares\UserDrives\%%username%% /persistent:yes
  echo :end
) > c:\scripts\netuse.bat

:EOF
REM Write an end message to the log file
echo [%date% %time%] Batch file completed >> %LOGFILE%
endlocal
