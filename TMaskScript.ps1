$ScriptPath = "C:\Windows\Temp\Scripts\"


Remove-SmbMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction Ignore

 
$net = new-object -ComObject WScript.Network
$net.MapNetworkDrive("S:", "\\test\pool-nvm", $false, "smb", "test")
#$ec = $?
#$ec


Get-Date | Out-File -FilePath "S:\Script\TMaskPL.log" -Append
Copy-Item "S:\Script\*" -Destination $ScriptPath

$files = Get-ChildItem -Filter "TM_*.ps1" $ScriptPath -Name

foreach ($f in $files){
    if ($f -ne $null) {
    Write-Output $f
    PowerShell.exe -ExecutionPolicy Bypass -File 'C:\Windows\Temp\Scripts\$f'
    }
}

Remove-SmbMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction Ignore
#$ec = $?
#$ec
