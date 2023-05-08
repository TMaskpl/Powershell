[CmdletBinding()]
param(
    [string]$ScriptPath = "C:\Windows\Temp\Scripts\",
    [string]$log="S:\TMaskPL.log",
    [string]$share="\\10.40.222.201\pool-nvm\Script",
    [string]$user="smb",
    [string]$pass="thc401"
)


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

Get-Date | Out-File -FilePath $log -Append

$env:COMPUTERNAME
robocopy /xc /xn /xo S: $ScriptPath *.ps1 *.cmd *.py *.exe /LOG+:S:\TMask_$env:COMPUTERNAME.log


$files = Get-ChildItem -Filter "TM_*.ps1" $ScriptPath | % { $_.FullName }
$files
foreach ($f in $files){
    if ($f -ne $null) {

    powershell.exe -ExecutionPolicy Bypass -File $f
    }
}

#Remove-SmbMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction IgnorembMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction Ignore
