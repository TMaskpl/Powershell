$ScriptPath = "C:\Windows\Temp\Scripts"

if (-not(Test-Path -Path $ScriptPath\Bginfo64.exe.SEM -PathType Leaf)) 
{
    $ScriptPath\Bginfo64.exe /accepteula /silent /timer 0 
    New-Item -ItemType "file" -Path $ScriptPath\Bginfo64.exe.SEM
}
