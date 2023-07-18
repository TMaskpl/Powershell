##################################################
#                                                #
#__author__ = "biuro@tmask.pl"                   #
#__copyright__ = "Copyright (C) 2023 TMask.pl"   #
#__license__ = "MIT License"                     #
#__version__ = "1.0"                             #
#                                                #
##################################################


$Webhook = "https://hooks.slack.com/services/***************"
$ContentType= 'application/json'
$Body = @"
    {
        "username": "Daniel Niemczok",
        "icon_emoji": ":ghost:",
        "text": "Hello World",
    }
"@
Invoke-RestMethod -uri $Webhook -Method Post -body $Body -ContentType $ContentType
