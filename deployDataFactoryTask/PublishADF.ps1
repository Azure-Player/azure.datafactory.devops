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

    # Get inputs for the task
    $connectedServiceName = Get-VstsInput -Name ConnectedServiceName -Require
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
    [boolean]$IsDryRun = Get-VstsInput -Name "IsDryRun" -AsBool;
    [boolean]$IncrementalDeployment = Get-VstsInput -Name "IncrementalDeployment" -AsBool;
    [string]$TriggerStopMethod = Get-VstsInput -Name "TriggerStopMethod";
    [string]$TriggerStartMethod = Get-VstsInput -Name "TriggerStartMethod";
    #$input_pwsh = Get-VstsInput -Name 'pwsh' -AsBool

try {

    # Initialize Azure.
    Import-Module $PSScriptRoot\ps_modules\VstsAzureHelpers_

    $endpoint = Get-VstsEndpoint -Name $connectedServiceName -Require

    # Update PSModulePath for hosted agent
    . "$PSScriptRoot\Utility.ps1"

    CleanUp-PSModulePathForHostedAgent

    $vstsEndpoint = Get-VstsEndpoint -Name SystemVssConnection -Require
    $vstsAccessToken = $vstsEndpoint.auth.parameters.AccessToken

    if (Get-Module Az.Accounts -ListAvailable) {
        $encryptedToken = ConvertTo-SecureString $vstsAccessToken -AsPlainText -Force
        Initialize-AzModule -Endpoint $endpoint -connectedServiceNameARM $connectedServiceName -encryptedToken $encryptedToken
    }
    else {
        Write-Verbose "No module found with name: Az.Accounts"
        throw ("Could not find the module Az.Accounts with given version. If the module was recently installed, retry after restarting the Azure Pipelines task agent.")
    }
    $azureUtility = Get-AzureUtility
    Write-Verbose -Verbose "Loading $azureUtility"
    dir "./ps_modules/VstsAzureRestHelpers_"
    Write-Verbose -Verbose "DIR2"
    $p = "$PSScriptRoot/ps_modules/VstsAzureRestHelpers_"
    dir $p
    Write-Verbose "Resolving path: $p"
    Write-Verbose (Resolve-Path $p)
    . "$PSScriptRoot/$azureUtility"

    #### MAIN EXECUTION OF THE TASK BEGINS HERE ####

    # import required modules
	$ModulePathADFT = "$PSScriptRoot\ps_modules\azure.datafactory.tools\azure.datafactory.tools.psd1"
    #$config = Import-PowerShellDataFile $ModulePathADFT
    #Write-Output "Azure.DataFactory.Tools version: $($config.ModuleVersion)"
    Write-Output "PowerShell: $($PSVersionTable.PSVersion) $($PSVersionTable.PSEdition)"

    Write-Host "Listing all imported modules..."
    Get-Module
    # $ModulePathAcc = "$PSScriptRoot\ps_modules\Az.Accounts\Az.Accounts.psd1"
    # Import-Module -Name $ModulePathAcc
    #$ModulePathRes = "$PSScriptRoot\ps_modules\Az.Resources\Az.Resources.psd1"
    #Import-Module -Name $ModulePathRes
	$ModulePathADF = "$PSScriptRoot\ps_modules\Az.DataFactory\Az.DataFactory.psd1"
    Import-Module -Name $ModulePathADF
    Import-Module -Name $ModulePathADFT

    $global:ErrorActionPreference = 'Stop';
    if ($FilteringType -eq "None") { $FilteringYesNo = "NO" } else { $FilteringYesNo = ("YES ({0})" -f $FilteringType) }
    if ([string]::IsNullOrWhitespace($PublishMethod)) { $PublishMethod = "AzResource" }

    Write-Debug "Invoking Publish-AdfV2FromJson (https://github.com/Azure-Player/azure.datafactory.tools) with the following parameters:";
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
    $opt.TriggerStopMethod = $TriggerStopMethod
    $opt.TriggerStartMethod = $TriggerStartMethod

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
        -Method $PublishMethod `
        -DryRun:$IsDryRun

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
    Disconnect-AzureAndClearContext -authScheme $endpoint.Auth.Scheme -ErrorAction SilentlyContinue
}
