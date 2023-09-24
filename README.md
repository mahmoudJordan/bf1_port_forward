# games_port_forward

The **port_forward** project provides a PowerShell script that automates UPnP port mapping for Battlefield 1 using UPnPWizardC. By utilizing this script, you can enhance your gaming experience by reducing latency, particularly in online gameplay where low latency and ping are crucial.

To successfully use this script, please ensure that you meet the following requirements:

1. **UPnPWizardC Installation**: You need to install UPnPWizardC, a tool that facilitates communication with your router and enables the addition of internal and external mappings. You can download UPnPWizardC from the following link: [UPnPWizardC](https://www.xldevelopment.net/upnpwiz.php).

2. **Enable UPnP in Your Router Configuration**: Most modern routers have UPnP disabled by default. To utilize this script, you must enable UPnP in your router's configuration. For instructions on enabling UPnP, please refer to the documentation or the following guide: [How to Enable UPnP (Universal Plug and Play)](https://appuals.com/how-to-enable-upnp-universal-plug-n-play/).

3. **Allow PowerShell Script Execution**: PowerShell scripts are disabled on Windows by default due to security reasons. To run the script successfully, you need to allow PowerShell script execution. Please refer to the following guide for instructions on enabling PowerShell script execution: [How to Allow PowerShell Scripts Execution](https://superuser.com/questions/106360/how-to-enable-execution-of-powershell-scripts).

**Note regarding Security Concerns**:

It is essential to be aware of potential security risks associated with UPnP port mapping and PowerShell script execution. UPnP port mapping can introduce vulnerabilities if not properly configured. By enabling UPnP, you are granting automatic access to your router, potentially allowing malicious software or attackers to manipulate network settings.

Regarding PowerShell script execution, it is crucial to exercise caution when running scripts obtained from untrusted sources. Malicious scripts can harm your system or compromise your data. Always ensure that you only run scripts from trusted and verified sources.

Please review and understand the security implications before enabling UPnP and running PowerShell scripts. It is recommended to disable UPnP and maintain strict control over script execution policies unless you fully trust the source and understand the potential risks involved.

We hope that this project enhances your Battlefield 1 gaming experience, but we strongly encourage you to prioritize your network security and take necessary precautions to protect your system and data.
