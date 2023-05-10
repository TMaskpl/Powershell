```

##################################################
#                                                #
#__author__ = "biuro@tmask.pl"                   #
#__copyright__ = "Copyright (C) 2023 TMask.pl"   #
#__license__ = "MIT License"                     #
#__version__ = "1.0"                             #
#                                                #
##################################################
```





# Powershell


### set-dns.ps1

Ustawienie na sztywno serwera DNS na wszystkie dostępne interfejsy w Windows

#### RunAs Administrator

powershell.exe -executionpolicy bypass -file .\dns-softera.ps1  -IpDns "IP DNS"




#### Ustawienie folderu użytkowinika jako read-only

read-only-profile.ps1

#### RunAs Administrator

powershell.exe -executionpolicy bypass -file .\read-only-profile.ps1  -U "Login użytkowika"
