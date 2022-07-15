#cxlogon installer
new-module -name cxlogon -scriptblock {
  $uri = "http://pub.nxfilter.org/cxlogon-win-1.0.4.msi"
  $file = 'cxlogon-win-1.0.4.msi'
  $temp = $Env:windir + "\Temp\"
  $soft_name = 'cxlogon'

Function Install-Project {

  $find = Get-WmiObject -Class Win32_Product -Filter "Name LIKE `'$soft_name`'"

  if ($find -eq $null) {
    $tmp = "$temp$file"
    $client = New-Object System.Net.WebClient
    $client.DownloadFile($uri, $tmp)

    msiexec /i $tmp /qn
    Echo "Tried installing $soft_name"
  } else {
    Echo "ERROR: $soft_name is already installed."
    Echo $find

  }

  }

  set-alias install -value Install-Project

  export-modulemember -function 'Install-Project' -alias 'install'
}
