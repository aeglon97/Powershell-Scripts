netsh wlan show profile

$name = Read-Host -Prompt "Enter the WLAN SSID whose password you'd like to retrieve."

netsh wlan show profile $name key=clear