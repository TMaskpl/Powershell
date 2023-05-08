$ScriptPath = "C:\Windows\Temp\Scripts"

if (-not(Test-Path -Path $ScriptPath\Bginfo64.exe.SEM -PathType Leaf)) 
{
    cmd.exe /c  $ScriptPath\Bginfo64.exe /timer:0 /nolicprompt /silent
    New-Item -ItemType "file" -Path $ScriptPath\Bginfo64.exe.SEM
}
