const fs = require('fs').promises;
const path = require('path');
const axios = require('axios');
const xml2js = require('xml2js');

// Constants obtained from the router's UPnP description (these are placeholders and should be updated based on your router's specifics)
const soapAction = '"urn:schemas-upnp-org:service:WANIPConnection:1#AddPortMapping"';
const controlURL = 'http://192.168.100.1:1900/upnp/control/WANIPConn1'; // Adjust this URL based on actual service URL of your UPnP router

async function addPortMapping(port, protocol, internalClient) {
    const soapBody = `
        <?xml version="1.0"?>
        <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
            <s:Body>
                <u:AddPortMapping xmlns:u="urn:schemas-upnp-org:service:WANIPConnection:1">
                    <NewRemoteHost></NewRemoteHost>
                    <NewExternalPort>${port}</NewExternalPort>
                    <NewProtocol>${protocol}</NewProtocol>
                    <NewInternalPort>${port}</NewInternalPort>
                    <NewInternalClient>${internalClient}</NewInternalClient>
                    <NewEnabled>1</NewEnabled>
                    <NewPortMappingDescription>NodePortMapping</NewPortMappingDescription>
                    <NewLeaseDuration>0</NewLeaseDuration>
                </u:AddPortMapping>
            </s:Body>
        </s:Envelope>
    `;

    try {
        await axios.post(controlURL, soapBody, {
            headers: {
                'Content-Type': 'text/xml; charset=utf-8',
                'SOAPAction': soapAction
            }
        });
        console.log(`Successfully added ${protocol} entry for port ${port}`);
    } catch (error) {
        console.error(`Error adding entry for port ${port}:`, error.message);
    }
}

async function addEntries(portsArray, internalClient, TCPUDP, name) {
    for (const port of portsArray) {
        await addPortMapping(port, TCPUDP, internalClient);
    }
    console.log(`All ${TCPUDP} entries added successfully for ${name}.`);
}

async function setMappings(tcp, udp, internalClient, name) {
    console.log(`Adding Entries for ${name}`);
    await addEntries(tcp, internalClient, 'TCP', name);
    await addEntries(udp, internalClient, 'UDP', name);
    console.log(`Finished Adding ${name}`);
}

async function main() {
    const portsData = await fs.readFile(path.join(__dirname, 'ports.json'), 'utf8');
    const portsJson = JSON.parse(portsData);
    const internalClient = '192.168.100.25'; // The internal IP address you want to forward to, based on your screenshots.

    for (const entry of portsJson) {
        await setMappings(entry.tcp, entry.udp, internalClient, entry.name);
    }

    console.log('Finished adding all entries.');
}

main().catch(console.error);
