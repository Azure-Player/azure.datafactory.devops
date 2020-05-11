[CmdletBinding()]
param()

<#
	.SYNOPSIS
    Publishes Azure Data Factory using code from JSON files specified DAC publish profile from your solution.

	.DESCRIPTION
    Publishes Azure Data Factory using code from JSON files specified DAC publish profile from your solution.

    Script written by (c) Kamil Nowinski (SQLPlayer.net blog), 2020 for Azure DevOps extension
    Source code and documentation: https://github.com/SQLPlayer/azure.datafactory.devops
	This PowerShell script is released under the MIT license http://www.opensource.org/licenses/MIT

    Depends on PowerShell module azure.datafactory.tools 
    written by (c) Kamil Nowinski, 2020 https://github.com/SQLPlayer/azure.datafactory.tools
#>

Trace-VstsEnteringInvocation $MyInvocation
try {

    # import required modules
	$ModulePath = "$PSScriptRoot\ps_modules\azure.datafactory.tools\azure.datafactory.tools.psd1"
    Import-Module -Name $ModulePath
    $config = Import-PowerShellDataFile $ModulePath
    Write-Output "Tools Version: $($config.ModuleVersion)"

    #Get inputs params
    [string]$RootFolder = Get-VstsInput -Name "DataFactoryCodePath" -Require;
    [string]$DataFactoryName = Get-VstsInput -Name "DataFactoryName" -Require;
    [string]$ResourceGroupName = Get-VstsInput -Name  "ResourceGroupName" -Require;
    [string]$Location = Get-VstsInput -Name "Location" -Require;

    $global:ErrorActionPreference = 'Stop';

    Write-Host "Invoking Publish-AdfV2FromJson (https://github.com/SQLPlayer/azure.datafactory.tools) with the following parameters:";
    Write-Host "DataFactoryName:    $DataFactoryName";
    Write-Host "RootFolder:         $RootFolder";
    Write-Host "ResourceGroupName:  $ResourceGroupName";
    Write-Host "Location:           $Location";

    Publish-AdfV2FromJson -RootFolder "$RootFolder" `
        -ResourceGroupName "$ResourceGroupName" `
        -DataFactoryName "$DataFactoryName" `
        -Location "$Location"


} finally {
    Trace-VstsLeavingInvocation $MyInvocation
}


