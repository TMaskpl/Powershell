# Run
# powershell.exe -executionpolicy bypass -file .\dns-softera.ps1  -IpDns "1.1.1.1"

param(
    $IpDns
)

$Idx = Get-DnsClientServerAddress | Select-Object -ExpandProperty InterfaceIndex -Property InterfaceIndex
$Idx = $Idx | Get-Unique
$Idx

foreach ($i in $Idx) {
    Set-DnsClientServerAddress -InterfaceIndex $i -ServerAddresses ($IpDns)
}

Get-DnsClientServerAddress
