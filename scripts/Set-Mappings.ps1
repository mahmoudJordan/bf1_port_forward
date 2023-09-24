. .\Get-ApplicationPath.ps1

function addEntries($portsArray , $ipv4, $TCPUDP , $UpnpWizardFolderPath , $name) {
    Set-Location -Path $UpnpWizardFolderPath
    foreach ( $entry in $portsArray) {
        ./UPnPWizardC.exe -add $name -ip $ipv4 -intport $entry -extport $entry -protocol $TCPUDP -lease 2592000 
    }
}


function Set-Mappings($tcp , $udp , $name) {


    # get current PC netword address
    $ipV4addresses = Test-Connection -ComputerName (hostname) -Count 1  | Select -ExpandProperty IPV4Address;
    $ipv4 = $ipV4addresses.IPAddressToString;

    # check if UPnP Wizard tool is available 
    $wizardPath = Get-ApplicationPath -ApplicationName "UPnP Wizard"

    if ($wizardPath) {
   
        Write-Host "UPnP Wizard is installed..."
        Write-Host "Adding Entries"
        addEntries -portsArray $tcp -ipv4 $ipv4 -TCPUDP TCP -UpnpWizardFolderPath $wizardPath -name $name
        addEntries -portsArray $udp -ipv4 $ipv4 -TCPUDP UDP -UpnpWizardFolderPath $wizardPath -name $name
        Write-Host "Finished Adding $($name)"
    }
    else {
        Write-Host "UPnP Wizard is required but not installed, Please install it first https://www.xldevelopment.net/upnpwiz.php"
        Write-Host "Failed ... Exiting"
    }
}

