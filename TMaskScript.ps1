[CmdletBinding()]
param(
    [string]$ScriptPath = "C:\Windows\Temp\Scripts\",
    [string]$log="S:\TMaskPL.log",
    [string]$share="\\IP\pool-nvm\Script",
    [string]$user="smb",
    [string]$pass="haslo"
)

# Tworzenie katalogu $ScriptPath
if (Test-Path $ScriptPath) {
    Write-Output "OK"
}
else
{
    New-Item $ScriptPath -ItemType Directory
}


# Mapowanie dysku S:
if (Test-Path "S:\") {
    Write-Output "Dysk S: - OK"
}
else
{
    $net = new-object -ComObject WScript.Network
    $net.MapNetworkDrive("S:", $share, $false, $user, $pass) 
}

# Kopiowanie plików z s: na $ScriptPath
$env:COMPUTERNAME
cmd.exe /c "robocopy /xo S: $ScriptPath *.ps1 *.vbs *.cmd *.py *.exe /LOG+:S:\TMask_$env:COMPUTERNAME.log"


# Uruchomienie plików .ps1 których nazwa rozpoczyna się na TM_*.ps1 
$files = Get-ChildItem -Filter "TM_*.ps1" $ScriptPath | % { $_.FullName }
$files
foreach ($f in $files){
    if ($f -ne $null) {

    powershell.exe -ExecutionPolicy Bypass -File $f
    }
}
