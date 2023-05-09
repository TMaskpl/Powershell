##################################################
#                                                #
#__author__ = "biuro@tmask.pl"                   #
#__copyright__ = "Copyright (C) 2023 TMask.pl"   #
#__license__ = "MIT License"                     #
#__version__ = "1.0"                             #
#                                                #
##################################################


# Run
# powershell.exe -executionpolicy bypass -file .\dns-softera.ps1  -IpDns <IP DNS>
[CmdletBinding()]
param(
    [string]$IpDns="192.168.0.210"
)

$Idx = Get-DnsClientServerAddress | Select-Object -ExpandProperty InterfaceIndex -Property InterfaceIndex
$Idx = $Idx | Get-Unique
$Idx

foreach ($i in $Idx) {
    Set-DnsClientServerAddress -InterfaceIndex $i -ServerAddresses ($IpDns)  -ErrorAction Ignore
}

Get-DnsClientServerAddress
