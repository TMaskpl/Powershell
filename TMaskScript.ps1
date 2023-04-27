$ScriptPath = "C:\Windows\Temp\Scripts\"


Remove-SmbMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction Ignore

 
$net = new-object -ComObject WScript.Network
$net.MapNetworkDrive("S:", "\\IP\pool-nvm", $false, "smb", "hasło")
$ec = $?
$ec


Get-Date | Out-File -FilePath "S:\Script\TMaskPL.log" -Append
Copy-Item "S:\Script\*" -Destination $ScriptPath

$files = Get-ChildItem -Filter "*.ps1" $ScriptPath 

foreach ($f in $files){
    Write-Output "$f +'.local'"
}

Remove-SmbMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction Ignore
$ec = $?
$ec
