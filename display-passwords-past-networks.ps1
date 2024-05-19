#IMPORTANT: RUN IN ADMIN MODE

$main = {
    while($true)
    {
        userPrompt

        $user_choice = Read-Host "`nWhich Wifi network would you like the password to? Type the NUMBER"

    }
}

function userPrompt() {
    Read-Host -Prompt "`Press [ENTER] to see all past WiFi networks your device has connected to"

    Write-Host "`nALL PAST WIFI NETWORKS:`n====================================================`n"

    $past_wifis = @()

    #Put all wifi names in a list
    foreach($detail in netsh wlan show profile ) {
        If ($detail.Contains("User Profile")) {
            $wifi_name = ($detail.Substring($detail.IndexOf(":") + 2))
            $past_wifis += $wifi_name
        }
    }

    #display all wifi names, numbered
    for ($i=0; $i -lt $past_wifis.Length; $i++) {
        Write-Host [$i] $past_wifis[$i];
        #Write-Host $past_wifis[$i]
    }

    $user_choice = Read-Host "`nWhich Wifi network would you like the password to? Type the NUMBER"

    $ssid_details = netsh wlan show profile $past_wifis[$user_choice] key=clear

    $ssid_key = $ssid_details | findstr Key
    $ssid_key = $ssid_key.Substring($ssid_key.IndexOf(":") + 2)

    $ssid_security = ($ssid_details | Select-String -Pattern 'Security key').Line
    $ssid_security = $ssid_security.Substring($ssid_security.IndexOf(":") + 2)

    If ($ssid_security -eq "Present"){
        Write-Host `n===========================`nWifi: $past_wifis[$user_choice]`nPassword: $ssid_key`n
    } ElseIf ($ssid_security -eq "Absent" ){
        Write-Host `n===========================`nWifi network $past_wifis[$user_choice] is unsecure and has no password.
    }
}

& $main



