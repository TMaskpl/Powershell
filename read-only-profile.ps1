##################################################
#                                                #
#__author__ = "biuro@tmask.pl"                   #
#__copyright__ = "Copyright (C) 2023 TMask.pl"   #
#__license__ = "MIT License"                     #
#__version__ = "1.0"                             #
#                                                #
##################################################


# powershell.exe -executionpolicy bypass -file .\read-only-profile.ps1  -U <Login użytkowika>

param(
    $U
)

$l = Get-ChildItem -Name -Directory "c:\Users\$U\"

foreach ($i in $l) {

$myPath = "c:\Users\$U\$i"
Get-Acl "$myPath" | fl
## get actual Acl entry
$myAcl = Get-Acl "$myPath"
$myAclEntry = "$env:COMPUTERNAME\$U","Write","Deny"
$myAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($myAclEntry)
## prepare new Acl
$myAcl.SetAccessRule($myAccessRule)
$myAcl | Set-Acl "$MyPath"
## check if added entry present
Get-Acl "$myPath" | fl *

}
