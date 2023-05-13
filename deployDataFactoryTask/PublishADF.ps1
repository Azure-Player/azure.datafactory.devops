[CmdletBinding()]
param()

<#
	.SYNOPSIS
    Publishes Azure Data Factory using code from JSON files.

	.DESCRIPTION
    Publishes Azure Data Factory using code from JSON files.

    Script written by (c) Kamil Nowinski (AzurePlayer.net blog), 2020 for Azure DevOps extension
    Source code and documentation: https://github.com/Azure-Player/azure.datafactory.devops
	This PowerShell script is released under the MIT license http://www.opensource.org/licenses/MIT

    Depends on PowerShell module azure.datafactory.tools 
    written by (c) Kamil Nowinski, 2020 https://github.com/Azure-Player/azure.datafactory.tools
#>

Trace-VstsEnteringInvocation $MyInvocation
try {

    # import required modules
	$ModulePathADFT = "$PSScriptRoot\ps_modules\azure.datafactory.tools\azure.datafactory.tools.psd1"
    #$config = Import-PowerShellDataFile $ModulePathADFT
    #Write-Output "Azure.DataFactory.Tools version: $($config.ModuleVersion)"
    Write-Output "PowerShell: $($PSVersionTable.PSVersion) $($PSVersionTable.PSEdition)"

    #Get-Module -ListAvailable

    $ModulePathAcc = "$PSScriptRoot\ps_modules\Az.Accounts\Az.Accounts.psd1"
    Import-Module -Name $ModulePathAcc
    $ModulePathRes = "$PSScriptRoot\ps_modules\Az.Resources\Az.Resources.psd1"
    Import-Module -Name $ModulePathRes
	$ModulePathADF = "$PSScriptRoot\ps_modules\Az.DataFactory\Az.DataFactory.psd1"
    Import-Module -Name $ModulePathADF
    Import-Module -Name $ModulePathADFT


    . "$PSScriptRoot\Utility.ps1"

    #$serviceName = Get-VstsInput -Name ConnectedServiceNameARM -Require
    $serviceName = Get-VstsInput -Name ConnectedServiceName -Require
    $endpointObject = Get-VstsEndpoint -Name $serviceName -Require
    $endpoint = ConvertTo-Json $endpointObject
    #$CoreAzArgument = "-endpoint '$endpoint'"
    . "$PSScriptRoot\CoreAz.ps1" -endpoint $endpoint


    #Get-Module -ListAvailable

    # Get inputs params
    [string]$RootFolder = Get-VstsInput -Name "DataFactoryCodePath" -Require;
    [string]$DataFactoryName = Get-VstsInput -Name "DataFactoryName" -Require;
    [string]$ResourceGroupName = Get-VstsInput -Name  "ResourceGroupName" -Require;
    [string]$Location = Get-VstsInput -Name "Location" -Require;
    [string]$StageType = Get-VstsInput -Name "StageType" -Require;
    [string]$StageCode = Get-VstsInput -Name "StageCode";
    [string]$StageConfigFile = Get-VstsInput -Name "StageConfigFile";
    [boolean]$DeleteNotInSource = Get-VstsInput -Name "DeleteNotInSource" -AsBool;
    [boolean]$StopStartTriggers = Get-VstsInput -Name "StopStartTriggers" -AsBool;
    [boolean]$CreateNewInstance = Get-VstsInput -Name "CreateNewInstance" -AsBool;
    [string]$FilteringType = Get-VstsInput -Name FilteringType -Require;
    [string]$FilterTextFile = Get-VstsInput -Name FilterTextFile;
    [string]$FilterText = Get-VstsInput -Name FilterText;
    [string]$PublishMethod = Get-VstsInput -Name PublishMethod;
    [boolean]$DoNotStopStartExcludedTriggers = Get-VstsInput -Name "DoNotStopStartExcludedTriggers" -AsBool;
    [boolean]$DoNotDeleteExcludedObjects = Get-VstsInput -Name "DoNotDeleteExcludedObjects" -AsBool;
    [boolean]$IgnoreLackOfReferencedObject = Get-VstsInput -Name "IgnoreLackOfReferencedObject" -AsBool;
    [boolean]$IncrementalDeployment = Get-VstsInput -Name "IncrementalDeployment" -AsBool;
    #$input_pwsh = Get-VstsInput -Name 'pwsh' -AsBool
    
    $global:ErrorActionPreference = 'Stop';
    if ($FilteringType -eq "None") { $FilteringYesNo = "NO" } else { $FilteringYesNo = ("YES ({0})" -f $FilteringType) }
    if ([string]::IsNullOrWhitespace($PublishMethod)) { $PublishMethod = "AzResource" }

    Write-Debug "Invoking Publish-AdfV2FromJson (https://github.com/SQLPlayer/azure.datafactory.tools) with the following parameters:";
    Write-Debug "DataFactoryName:    $DataFactoryName";
    Write-Debug "RootFolder:         $RootFolder";
    Write-Debug "ResourceGroupName:  $ResourceGroupName";
    Write-Debug "Location:           $Location";
    Write-Debug "Stage:              $StageCode";
    Write-Debug "Filtering:          $FilteringYesNo";
    Write-Debug "PublishMethod:      $PublishMethod";

    # Options
    $opt = New-AdfPublishOption 
    $opt.DeleteNotInSource = $DeleteNotInSource
    $opt.StopStartTriggers = $StopStartTriggers
    $opt.CreateNewInstance = $CreateNewInstance
    $opt.DoNotStopStartExcludedTriggers = $DoNotStopStartExcludedTriggers
    $opt.DoNotDeleteExcludedObjects = $DoNotDeleteExcludedObjects
    $opt.IgnoreLackOfReferencedObject = $IgnoreLackOfReferencedObject
    $opt.IncrementalDeployment = $IncrementalDeployment

    # Validate the Filtering Type
    if ($FilteringType -ne "None") {
        if ($FilteringType -eq "FilePath") {
            if ($FilterTextFile -match '[\r\n]' -or [string]::IsNullOrWhitespace($FilterTextFile)) {
                throw ("Invalid script path '{0}'. Invalid path characters specified." -f $FilterTextFile)
            }
            $FilterText = Get-Content -Path $FilterTextFile -Raw -Encoding 'UTF8'
        }
        $FilterArray = $FilterText.Replace(',', "`n").Replace("`r`n", "`n").Split("`n");

        # Include/Exclude options
        $FilterArray | Where-Object { ($_.Trim().Length -gt 0 -or $_.Trim().StartsWith('+')) -and (!$_.Trim().StartsWith('-')) } | ForEach-Object {
            $i = $_.Trim().Replace('+', '')
            Write-Verbose "- Include: $i"
            $opt.Includes.Add($i, "");
        }
        Write-Host "$($opt.Includes.Count) rule(s)/object(s) added to be included in deployment."

        $FilterArray | Where-Object { $_.Trim().StartsWith('-') } | ForEach-Object {
            $e = $_.Trim().Substring(1)
            Write-Verbose "- Exclude: $e"
            $opt.Excludes.Add($e, "");
        }
        Write-Host "$($opt.Excludes.Count) rule(s)/object(s) added to be excluded from deployment."
    }

    if ($StageType -eq "Stage") {
        $Stage = $StageCode
    } else {
        $ext = [System.IO.Path]::GetExtension($StageConfigFile.ToLower())
        $allowedExt = '.csv', '.json'
        if (!$allowedExt.Contains($ext)) {
            throw ("Invalid config file name '{0}'. File must ends either with '.csv' or '.json'." -f $StageConfigFile)
        }
        $Stage = $StageConfigFile
    }

    $null = Publish-AdfV2FromJson -RootFolder "$RootFolder" `
        -ResourceGroupName "$ResourceGroupName" `
        -DataFactoryName "$DataFactoryName" `
        -Location "$Location" `
        -Option $opt -Stage "$Stage" `
        -Method $PublishMethod

    Write-Host ""
    Write-Host "========================================================================================================="
    Write-Host "    - How much helpful this extension Task for Azure Data Factory is?                                    "
    Write-Host "    - If you like it, if it saves your time or maybe something could be done better?                     "
    Write-Host "    - I would be really appreciate when you rate this tool and leave your honest comment.                "
    Write-Host "(https://marketplace.visualstudio.com/items?itemName=SQLPlayer.DataFactoryTools&ssr=false#review-details)"
    Write-Host "                         THE COMMUNITY WOULD LOVE TO HEAR YOUR FEEDBACK !                                "
    Write-Host "                                            Me either :)                                        Thanks!  "
    Write-Host "=========================================================================================================";
    Write-Host ""
    

} finally {
    Trace-VstsLeavingInvocation $MyInvocation
}

