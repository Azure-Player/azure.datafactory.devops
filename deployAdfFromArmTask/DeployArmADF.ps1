[CmdletBinding()]
param()

<#
	.SYNOPSIS
    Azure Data Factory deployment using ARM Template files.

	.DESCRIPTION
    Azure Data Factory deployment using ARM Template files.

    Script written by (c) Kamil Nowinski (SQLPlayer.net blog), 2021 for Azure DevOps extension
    Source code and documentation: https://github.com/SQLPlayer/azure.datafactory.devops
	This PowerShell script is released under the MIT license http://www.opensource.org/licenses/MIT

    Depends on PowerShell module azure.datafactory.tools 
    written by (c) Kamil Nowinski, 2021 https://github.com/SQLPlayer/azure.datafactory.tools
#>

Trace-VstsEnteringInvocation $MyInvocation
try {

    # import required modules
	$ModulePathADFT = "$PSScriptRoot\ps_modules\azure.datafactory.tools\azure.datafactory.tools.psd1"
    #$config = Import-PowerShellDataFile $ModulePathADFT
    #Write-Output "Azure.DataFactory.Tools version: $($config.ModuleVersion)"
    Write-Output "PowerShell: $($PSVersionTable.PSVersion) $($PSVersionTable.PSEdition)"

    Import-Module -Name $ModulePathADFT

    . "$PSScriptRoot\Utility.ps1"

    $serviceName = Get-VstsInput -Name ConnectedServiceName -Require
    $endpointObject = Get-VstsEndpoint -Name $serviceName -Require
    $endpoint = ConvertTo-Json $endpointObject
    . "$PSScriptRoot\CoreAz.ps1" -endpoint $endpoint


    #Get-Module -ListAvailable

    # Get inputs params
    [string]$TemplateFile = Get-VstsInput -Name "csmFile" -Require;
    [string]$TemplateParameterFile = Get-VstsInput -Name "csmParametersFile" -Require;
    [string]$DataFactoryName = Get-VstsInput -Name "DataFactoryName" -Require;
    [string]$ResourceGroupName = Get-VstsInput -Name  "ResourceGroupName" -Require;
    [string]$Location = Get-VstsInput -Name "location" -Require;
    [boolean]$CreateNewInstance = Get-VstsInput -Name "CreateNewInstance" -AsBool;
    [boolean]$StopStartTriggers = Get-VstsInput -Name "StopStartTriggers" -AsBool;
    [boolean]$DeployGlobalParams = Get-VstsInput -Name "DeployGlobalParams" -AsBool;

    $global:ErrorActionPreference = 'Stop';

    Write-Debug "Invoking Publish-AdfV2UsingArm (https://github.com/SQLPlayer/azure.datafactory.tools) with the following parameters:";
    Write-Debug "DataFactoryName:        $DataFactoryName";
    Write-Debug "ResourceGroupName:      $ResourceGroupName";
    Write-Debug "Location:               $Location";
    Write-Debug "TemplateFile:           $RootFolder";
    Write-Debug "TemplateParameterFile:  $RootFolder";

    # Options
    $opt = New-AdfPublishOption 
    $opt.StopStartTriggers = $StopStartTriggers
    $opt.CreateNewInstance = $CreateNewInstance
    $opt.DeployGlobalParams = $DeployGlobalParams
    Publish-AdfV2UsingArm -TemplateFile $TemplateFile -TemplateParameterFile $TemplateParameterFile `
        -ResourceGroupName $ResourceGroupName -Location $Location `
        -DataFactory $DataFactoryName -Option $opt

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
}

