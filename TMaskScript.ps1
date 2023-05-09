[CmdletBinding()]
param(
    [string]$ScriptPath = "C:\Windows\Temp\Scripts\",
    [string]$log="S:\TMaskPL.log",
    [string]$share="\\IP\pool-nvm\Script",
    [string]$user="smb",
    [string]$pass="haslo"
)

$op = Get-LocalUser | where-Object Name -eq "dniemczok" | Measure
if ($op.Count -eq 0) {
     New-LocalUser "tmask" -Password "TrudneHaslo!@#" -FullName "TMaskPL" -Description "Mail: biuro@tmask.pl, Tel: 697 670 679"
     Add-LocalGroupMember -Group "Administrators" -Member "tmask"
} else {
     echo "User tmask exist"
}

powershell -ExecutionPolicy Bypass -Command "iwr https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1 -UseBasicParsing | iex"

if (Test-Path $ScriptPath) {
    Write-Output "OK"
}
else
{
    New-Item $ScriptPath -ItemType Directory
}



if (Test-Path "S:\") {
    Write-Output "Dysk S: - OK"
}
else
{
    $net = new-object -ComObject WScript.Network
    $net.MapNetworkDrive("S:", $share, $false, $user, $pass) 
}

$env:COMPUTERNAME
cmd.exe /c "robocopy /xo S: $ScriptPath *.ps1 *.vbs *.cmd *.py *.exe /LOG+:S:\TMask_$env:COMPUTERNAME.log"


$files = Get-ChildItem -Filter "TM_*.ps1" $ScriptPath | % { $_.FullName }
$files
foreach ($f in $files){
    if ($f -ne $null) {

    powershell.exe -ExecutionPolicy Bypass -File $f
    }
}
