sc stop "AteraAgent"

sc delete "AteraAgent"

timeout -t 3

taskkill /f /im TicketingTray.exe

taskkill /f /im AteraAgent.exetaskkill /f /im AgentPackageMonitoring

taskkill /f /im AgentPackageInformation

taskkill /f /im AgentPackageRunCommande.exe

taskkill /f /im AgentPackageEventViewer.exe

taskkill /f /im AgentPackageSTRemote.exe

taskkill /f /im AgentPackageInternalPoller.exe

taskkill /f /im AgentPackageWindowsUpdate.exe

taskkill /f /im AgentPackageAgentInformation.exe

REG DELETE "HKEY_CURRENT_USER\Software\ATERA Networks" /f

REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\ATERA Networks" /f

REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{EFB51F01-9805-4293-BB16-6F17EF4CEDF2}" /f

REG DELETE "HKLM\SOFTWARE\Splashtop Inc." /f

RMDIR /S /Q "C:\Program Files\ATERA Networks\AteraAgent"

RMDIR /S /Q "C:\Program Files (x86)\ATERA Networks"

RMDIR /S /Q "C:\Program Files (x86)\Splashtop\Splashtop Remote\Server"

RMDIR /S /Q "C:\ProgramData\Splashtop\Splashtop Software Updater"

RMDIR /S /Q "C:\ProgramData\Splashtop\Temp"

Remove-Item 'Registry::HKEY_CLASSES_ROOT\Installer\Products\4758948C95C1B194AB15204D95B42292' -Recurse -ErrorAction SilentlyContinue

Remove-Item 'Registry::HKEY_CLASSES_ROOT\Installer\Products\10F15BFE50893924BB61F671FEC4DE2F' -Recurse -ErrorAction SilentlyContinue

Remove-Item 'Registry::HKEY_CLASSES_ROOT\Installer\Products\FF85A16D746FC5B49B8933204662781D' -Recurse -ErrorAction SilentlyContinue