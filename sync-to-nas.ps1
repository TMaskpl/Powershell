##################################################
#                                                #
#__author__ = "biuro@tmask.pl"                   #
#__copyright__ = "Copyright (C) 2023 TMask.pl"   #
#__license__ = "MIT License"                     #
#__version__ = "1.0"                             #
#                                                #
##################################################


# Sync to NAS 

$D = (Get-Date -format  yyyy-MM-dd)

Remove-SmbMapping -LocalPath "N:" -Force -erroraction 'silentlycontinue'

New-SmbMapping -LocalPath N: -RemotePath \\IP-NAS\NAS-SMB -UserName <user> -Password '<pass>'


# SQL 

$destination = "N:\SQL"
$files = Get-ChildItem E:\SQL\ -Filter *$D*.bak | % { $_.FullName }

ForEach ($f in $files)
{ 
echo "$f"
copy "$f" $destination
}


# FS

$destination = "N:\FS"
$files = Get-ChildItem E:\ZIP\ -Filter *$D*.zip | % { $_.FullName }

ForEach ($f in $files)
{ 
echo "$f"
copy "$f" $destination
}

Remove-SmbMapping -LocalPath "N:" -Force
