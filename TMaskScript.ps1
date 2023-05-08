[CmdletBinding()]
param(
    [string]$ScriptPath = "C:\Windows\Temp\Scripts\",
    [string]$log="S:\Script\TMaskPL.log",
    [string]$share="\\IP\pool-nvm\Script",
    [string]$user="smb",
    [string]$pass="haslo"
)



If(!(test-path -PathType container $ScriptPath))
{
      New-Item -ItemType Directory -Path $ScriptPath
}


Remove-SmbMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction Ignore
 
$net = new-object -ComObject WScript.Network
$net.MapNetworkDrive("S:", $share, $false, $user, $pass) 

Get-Date | Out-File -FilePath $log -Append

Copy-Item  -Path S:\*.ps1 -Destination $ScriptPath -ErrorAction Ignore
Copy-Item  -Path S:\*.cmd -Destination $ScriptPath -ErrorAction Ignore
Copy-Item  -Path S:\*.py -Destination $ScriptPath -ErrorAction Ignore

$files = Get-ChildItem -Filter "TM_*.ps1" $ScriptPath | % { $_.FullName }

foreach ($f in $files){
    if ($f -ne $null) {
    Write-Output $f
    powershell.exe -ExecutionPolicy Bypass -File $f
    }
}

Remove-SmbMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction IgnorembMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction Ignore
