[CmdletBinding()]
param()

<#
	.SYNOPSIS
    Validates files of ADF in a given location, returning warnings or errors.

	.DESCRIPTION
    Validates files of ADF in a given location, returning warnings or errors.

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
    Write-Output "PowerShell: $($PSVersionTable.PSVersion) $($PSVersionTable.PSEdition)"

    #Get-Module -ListAvailable

    # $ModulePathAcc = "$PSScriptRoot\ps_modules\Az.Accounts\Az.Accounts.psd1"
    # Import-Module -Name $ModulePathAcc
    # $ModulePathRes = "$PSScriptRoot\ps_modules\Az.Resources\Az.Resources.psd1"
    # Import-Module -Name $ModulePathRes
	# $ModulePathADF = "$PSScriptRoot\ps_modules\Az.DataFactory\Az.DataFactory.psd1"
    # Import-Module -Name $ModulePathADF
    Import-Module -Name $ModulePathADFT

    # Get inputs params
    [string]$RootFolder = Get-VstsInput -Name "DataFactoryCodePath" -Require;
    
    $global:ErrorActionPreference = 'Continue';

    Write-Debug "Invoking Build-AdfCode (https://github.com/SQLPlayer/azure.datafactory.tools) with the following parameters:";
    Write-Debug "RootFolder:         $RootFolder";


    $null = Build-AdfCode -RootFolder "$RootFolder" 




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

