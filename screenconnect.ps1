#screenconnect installer
new-module -name ScreenConnect -scriptblock {
	$uri = "https://adv-public-package-space.sfo3.digitaloceanspaces.com/AdvConnectWiseControl.ClientSetup.exe"
	$output = "ConnectWiseControl_ClientSetup.exe"
	$soft_name = "ScreenConnect%"
	$temp = "c:\Windows\temp\"

Function Install-Project {
	
		$find = Get-WmiObject -Class Win32_Product -Filter "Name LIKE `'$soft_name`'"

		if ($find -eq $null) {
			$tmp = "$temp$output"
			$client = New-Object System.Net.WebClient
			$client.DownloadFile($uri, $tmp)


			# Install the EXE file
			Start-Process $tmp -Wait
	    	Echo "Tried installing $soft_name"
	  	} else {
	    	Echo "ERROR: $soft_name is already installed."
	    	Echo $find

  			}
		}
  set-alias install -value Install-Project

  export-modulemember -function 'Install-Project' -alias 'install'
}
}
