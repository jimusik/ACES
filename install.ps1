#cxlogon installer
new-module -name cxlogon -scriptblock {
  $uri = "http://pub.nxfilter.org/cxlogon-win-1.0.4.msi"
  $file = 'cxlogon-win-1.0.4.msi'
  $temp = $Env:windir + "\Temp\"
  $soft_name = 'cxlogon'
  $logfile = $temp + "cxlogoninstaller.log"
  $logdump = $temp + "cxlogondump.log"


Function WriteLog {
  Param ([string]$LogString)
  $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
  $LogMessage = "$Stamp $LogString"
  Add-content $logfile -value $LogMessage
}

Function Install-Project {

  #Start-Transcript -Append $logdump

  $find = Get-WmiObject -Class Win32_Product -Filter "Name LIKE `'$soft_name`'"

  if ($find -eq $null) {
    $tmp = "$temp$file"
    $client = New-Object System.Net.WebClient
    $client.DownloadFile($uri, $tmp)

    msiexec /i $tmp /qn
    WriteLog "Tried installing $soft_name"
  } else {
    WriteLog "ERROR: $soft_name is already installed."
    WriteLog $find

  }
  #Stop-Transcript

  }

  set-alias install -value Install-Project

  export-modulemember -function 'Install-Project','WriteLog' -alias 'install'
}
