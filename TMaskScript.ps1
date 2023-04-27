$ScriptPath = "C:\Windows\Temp\Scripts\"


Remove-SmbMapping -LocalPath ("S" + ":") -UpdateProfile -Force -ErrorAction Ignore

 
$net = new-object -ComObject WScript.Network
$net.MapNetworkDrive("S:", "\\10.40.222.201\pool-nvm", $false, "smb", "thc401")
#$ec = $?
#$ec


Get-Date | Out-File -FilePath "S:\Script\TMaskPL.log" -Append
Copy-Item "S:\Script\*" -Destination $ScriptPath

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
