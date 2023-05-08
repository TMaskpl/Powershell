# Run
# powershell.exe -executionpolicy bypass -file .\AddSchedulerTask

# Create folder C:\Windows\Temp\Scripts\
$ScriptPath = "C:\Windows\Temp\Scripts\"
if (Test-Path $ScriptPath) {
    Write-Output "OK"
}
else
{
    New-Item $ScriptPath -ItemType Directory
}

$TMaskScript = "TMaskScript.ps1"
if (Test-Path $TMaskScript) {
    Copy-Item "TMaskScript.ps1" -Destination $ScriptPath
}


# Add new task to scheduler Task

$Prog = $env:systemroot + "\system32\WindowsPowerShell\v1.0\powershell.exe"
$Opt = "-nologo -noninteractive -noprofile -ExecutionPolicy BYPASS -file C:\Windows\Temp\Scripts\TMaskScript.ps1"
$Action = New-ScheduledTaskAction -Execute $Prog -Argument $Opt 
$Trigger = New-ScheduledTaskTrigger -Daily -DaysInterval 1 -RandomDelay "00:15" -At "01:00"
$Trigger.Repetition = $(New-ScheduledTaskTrigger -Once -RandomDelay "00:15" -At "01:00" -RepetitionInterval "00:05").Repetition
$Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$Task = Register-ScheduledTask -Action $Action -Trigger $Trigger -Principal $Principal -TaskName "MonitorTMaskPL" -Description "Automation Script every 15 min" -Force