$Webhook = "https://hooks.slack.com/services/***************"
$ContentType= 'application/json'
$Body = @"
    {
        "text": "Hello World",
    }
"@
Invoke-RestMethod -uri $Webhook -Method Post -body $Body -ContentType $ContentType
