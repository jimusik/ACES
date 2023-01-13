#wireguard installer
new-module -name wireguard -scriptblock {
  $uri = "https://download.wireguard.com/windows-client/wireguard-amd64-0.5.3.msi"
  $file = 'wireguard-amd64-0.5.3.msi'
  $temp = $Env:windir + "\Temp\"
  $soft_name = 'wireguard'

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
