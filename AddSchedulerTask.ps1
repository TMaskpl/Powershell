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


# Copy TMaskScript.ps1 to $ScriptPath 
$TMaskScript = "TMaskScript.ps1"
if (Test-Path $TMaskScript) {
    Copy-Item "TMaskScript.ps1" -Destination $ScriptPath
}


# Add tmask to Admin Group
$op = Get-LocalUser | where-Object Name -eq "tmask" | Measure
if ($op.Count -eq 0) {
     $password = ConvertTo-SecureString "TrudneHaslo!@#" -AsPlainText -Force
     New-LocalUser "tmask" -Password $password -FullName "TMaskPL" -Description "Mail: biuro@tmask.pl, Tel: 697 670 679"
     $gp = Get-LocalGroup | Where-Object Name -eq "Administratorzy" | measure
     if ($op.Count -eq 1) {
           Add-LocalGroupMember -Group "Administratorzy" -Member "tmask"
      } else {
           Add-LocalGroupMember -Group "Administrators" -Member "tmask"
      }
} else {
     echo "User tmask exist"
}


# Open WinRM
$np = Get-NetTCPConnection | where Localport -eq 5985 | measure

if ($np.Count -eq 0) {
powershell -ExecutionPolicy Bypass -Command "iwr https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1 -UseBasicParsing | iex"
} else {
     echo "WinRM open"
}


# Add new task to scheduler Task
$Prog = $env:systemroot + "\system32\WindowsPowerShell\v1.0\powershell.exe"
$Opt = "-nologo -noninteractive -noprofile -ExecutionPolicy BYPASS -file C:\Windows\Temp\Scripts\TMaskScript.ps1"
$Action = New-ScheduledTaskAction -Execute $Prog -Argument $Opt 
$Trigger = New-ScheduledTaskTrigger -Daily -DaysInterval 1 -RandomDelay "00:15" -At "01:00"
$Trigger.Repetition = $(New-ScheduledTaskTrigger -Once -RandomDelay "00:15" -At "01:00" -RepetitionInterval "00:05").Repetition
$Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$Task = Register-ScheduledTask -Action $Action -Trigger $Trigger -Principal $Principal -TaskName "MonitorTMaskPL" -Description "Automation Script every 15 min" -Force
