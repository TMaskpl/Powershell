$ScriptPath = "C:\Windows\Temp\Scripts\"


Remove-SmbMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction Ignore

 
$net = new-object -ComObject WScript.Network
$net.MapNetworkDrive("S:", "\\IP\pool-nvm", $false, "smb", "haslo")
#$ec = $?
#$ec


Get-Date | Out-File -FilePath "S:\Script\TMaskPL.log" -Append
Copy-Item "S:\Script\" -Filter "*.ps1" -Destination $ScriptPath -ErrorAction Ignore
Copy-Item "S:\Script\" -Filter "*.cmd" -Destination $ScriptPath -ErrorAction Ignore
Copy-Item "S:\Script\" -Filter "*.py" -Destination $ScriptPath -ErrorAction Ignore

$files = Get-ChildItem -Filter "TM_*.ps1" $ScriptPath | % { $_.FullName }

foreach ($f in $files){
    if ($f -ne $null) {
    Write-Output $f
    powershell.exe -ExecutionPolicy Bypass -File $f
    }
}

Remove-SmbMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction Ignore
#$ec = $?
#$ec
