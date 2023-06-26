function addEntries($portsArray ,$ipv4, $TCPUDP){
    foreach ( $entry in $portsArray)
    {
        UPnPWizardC -add bf1 -ip $ipv4 -intport $entry -extport $entry -protocol $TCPUDP -lease 2592000 
    }
}

#tcp ports to forward found online for steam (https://portforward.com/battlefield-1/)
$TCP = @(5222, 9988, 17502, 20000, 20100, 22990, 27015,27030, 27036,27037, 42127)
#udp ports to forward found online for steam(https://portforward.com/battlefield-1/)
$UDP = @(3659, 4380, 14000,14016, 22990,23006, 25200,25300, 27000,27031, 27036)

# get current PC netword address
$ipV4addresses = Test-Connection -ComputerName (hostname) -Count 1  | Select -ExpandProperty IPV4Address;
$ipv4 = $ipV4addresses.IPAddressToString;

// expiration for the entries 
$lease = 2592000 # 1 month

if (Get-Command UPnPWizardC -errorAction SilentlyContinue)
{
    addEntries -portsArray $TCP -ipv4 $ipv4 -TCPUDP TCP
    addEntries -portsArray $UDP -ipv4 $ipv4 -TCPUDP UDP
}
else {
    Write-Host "UPnPWizardC does not exists, please install it and add it to environment variables"
}


Write-Host "Finished"
