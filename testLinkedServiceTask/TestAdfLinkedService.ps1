[CmdletBinding()]
param()

<#
	.SYNOPSIS
    Runs test connection against Linked Service(s) of ADF.

	.DESCRIPTION
    Runs test connection against Linked Service(s) of Azure Data Factory.

    Script written by (c) Kamil Nowinski (SQLPlayer.net blog), 2021 for Azure DevOps extension
    Source code and documentation: https://github.com/SQLPlayer/azure.datafactory.devops
	This PowerShell script is released under the MIT license http://www.opensource.org/licenses/MIT

    Depends on PowerShell module azure.datafactory.tools 
    written by (c) Kamil Nowinski, 2021 https://github.com/SQLPlayer/azure.datafactory.tools
#>

Trace-VstsEnteringInvocation $MyInvocation

# Get inputs for the task
[string]$DataFactoryName = Get-VstsInput -Name "DataFactoryName" -Require;
[string]$ResourceGroupName = Get-VstsInput -Name "ResourceGroupName" -Require;
[string]$LinkedServiceName = Get-VstsInput -Name "LinkedServiceName" -Require;
[string]$TenantID = $c.Subscription.TenantId                   #Get-VstsInput -Name "TenantID" -Require;
[string]$ClientID = Get-VstsInput -Name "ClientID" -Require;
[string]$ClientSecret = Get-VstsInput -Name "ClientSecret" -Require;
[string]$SubscriptionID = $c.Subscription.Id

try {

    # import required modules
	$ModulePathADFT = "$PSScriptRoot\ps_modules\azure.datafactory.tools\azure.datafactory.tools.psd1"
    Write-Output "PowerShell: $($PSVersionTable.PSVersion) $($PSVersionTable.PSEdition)"

    $ModulePathAcc = "$PSScriptRoot\ps_modules\Az.Accounts\Az.Accounts.psd1"
    Import-Module -Name $ModulePathAcc
    $ModulePathRes = "$PSScriptRoot\ps_modules\Az.Resources\Az.Resources.psd1"
    Import-Module -Name $ModulePathRes
    Import-Module -Name $ModulePathADFT

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
    . "$PSScriptRoot/$azureUtility"

    $c = Get-AzContext
    # $c.Subscription.Id
    # $c.Subscription.TenantId

    #### MAIN EXECUTION OF THE TASK BEGINS HERE ####

    $global:ErrorActionPreference = 'Continue';

    Write-Debug "Invoking Test-AdfLinkedService (https://github.com/SQLPlayer/azure.datafactory.tools) with the following parameters:";
    Write-Debug "DataFactoryName:         $DataFactoryName";
    Write-Debug "ResourceGroupName:       $ResourceGroupName";
    Write-Debug "LinkedServiceName:       $LinkedServiceName";
    Write-Debug "TenantID:                $TenantID";
    Write-Debug "ClientID:                $ClientID";
    Write-Debug "SubscriptionID:          $SubscriptionID";


    $null = Test-AdfLinkedService -LinkedServiceName $LinkedServiceName `
    -DataFactoryName $DataFactoryName `
    -ResourceGroupName $ResourceGroupName `
    -SubscriptionID $SubscriptionID `
    -TenantID $TenantID -ClientID $ClientID -ClientSecret $ClientSecret


    Write-Host ""
    Write-Host "========================================================================================================="
    Write-Host "    - How much helpful this extension Task for Azure Data Factory is?                                    "
    Write-Host "    - If you like it, if it saves your time or maybe something could be done better?                     "
    Write-Host "    - I would be really appreciate if you rate this tool and leave your honest comment.                  "
    Write-Host "(https://marketplace.visualstudio.com/items?itemName=SQLPlayer.DataFactoryTools&ssr=false#review-details)"
    Write-Host "                         THE COMMUNITY WOULD LOVE TO HEAR YOUR FEEDBACK !                                "
    Write-Host "                                            Me either :)                                        Thanks!  "
    Write-Host "=========================================================================================================";
    Write-Host ""
    

} finally {
    Trace-VstsLeavingInvocation $MyInvocation
    Disconnect-AzureAndClearContext -authScheme $endpoint.Auth.Scheme -ErrorAction SilentlyContinue
}

