. .\Get-ApplicationPath.ps1

function addEntries($portsArray ,$ipv4, $TCPUDP , $UpnpWizardFolderPath){
    Set-Location -Path $UpnpWizardFolderPath
    foreach ( $entry in $portsArray)
    {
        ./UPnPWizardC.exe -add bf1 -ip $ipv4 -intport $entry -extport $entry -protocol $TCPUDP -lease 2592000 
    }
}

#tcp ports to forward found online for steam (https://portforward.com/battlefield-1/)
$TCP = @(5222, 9988, 17502, 20000, 20100, 22990, 27015,27030, 27036,27037, 42127)
#udp ports to forward found online for steam(https://portforward.com/battlefield-1/)
$UDP = @(3659, 4380, 14000,14016, 22990,23006, 25200,25300, 27000,27031, 27036)

# get current PC netword address
$ipV4addresses = Test-Connection -ComputerName (hostname) -Count 1  | Select -ExpandProperty IPV4Address;
$ipv4 = $ipV4addresses.IPAddressToString;

# check if UPnP Wizard tool is available 
$wizardPath = Get-ApplicationPath -ApplicationName "UPnP Wizard"

if ($wizardPath) {
   
    Write-Host "UPnP Wizard is installed..."
    Write-Host "Adding Entries"
    addEntries -portsArray $TCP -ipv4 $ipv4 -TCPUDP TCP -UpnpWizardFolderPath $wizardPath
    addEntries -portsArray $UDP -ipv4 $ipv4 -TCPUDP UDP -UpnpWizardFolderPath $wizardPath
    Write-Host "Finished"
} else {
    Write-Host "UPnP Wizard is required but not installed, Please install it first https://www.xldevelopment.net/upnpwiz.php"
    Write-Host "Failed ... Exiting"
}


