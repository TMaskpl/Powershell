##################################################
#                                                #
#__author__ = "biuro@tmask.pl"                   #
#__copyright__ = "Copyright (C) 2023 TMask.pl"   #
#__license__ = "MIT License"                     #
#__version__ = "1.0"                             #
#                                                #
##################################################


# Ustawienie tapety BGinfo

$ScriptPath = "C:\Windows\Temp\Scripts"

if (-not(Test-Path -Path $ScriptPath\Bginfo64.exe.SEM -PathType Leaf)) 
{
    cmd.exe /c  $ScriptPath\Bginfo64.exe $ScriptPath\tmask.bgi /timer:0 /nolicprompt /silent
    New-Item -ItemType "file" -Path $ScriptPath\Bginfo64.exe.SEM
}
