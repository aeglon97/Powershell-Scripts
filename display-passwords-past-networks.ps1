Write-Host "Copy and paste the LAN SSID you'd like to retrieve the password of."

$name = Read-Host -Prompt "Enter the WLAN SSID whose password you'd like to retrieve."



netsh wlan show profile $name key=clear