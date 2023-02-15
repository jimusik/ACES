#screenconnect installer
new-module -name ScreenConnect -scriptblock {
	$uri = "https://cwa-oraces.screenconnect.com/Bin/ConnectWiseControl.ClientSetup.exe?e=Access&y=Guest&c=Advantage%20Computing%20%26%20Electronic%20Services%20LLC&c=Main%20Office&c=&c=&c=&c=&c=&c="
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
			Start-Process $tmp /qn -Wait
	    	Echo "Tried installing $soft_name"
	  	} else {
	    	Echo "ERROR: $soft_name is already installed."
	    	Echo $find

  			}
		}
  set-alias install -value Install-Project

  export-modulemember -function 'Install-Project' -alias 'install'
}

