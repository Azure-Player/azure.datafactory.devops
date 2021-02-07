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

    Import-Module -Name $ModulePathADFT

    # Get inputs params
    [string]$RootFolder = Get-VstsInput -Name "DataFactoryCodePath" -Require;
    [string]$Action     = Get-VstsInput -Name "Action" -Require;
    
    $global:ErrorActionPreference = 'Continue';

    Write-Debug "Invoking Test-AdfCode (https://github.com/SQLPlayer/azure.datafactory.tools) with the following parameters:";
    Write-Debug "RootFolder:         $RootFolder";


    $null = Test-AdfCode -RootFolder "$RootFolder" 


    if ($Action -eq 'Export')
    {
        # Validate and export ARM Template using @microsoft/azure-data-factory-utilities module
        Write-Verbose "Check NPM Version"
        npm version

        Write-Verbose "Installing NPM azure-data-factory-utilities..."
        npm i @microsoft/azure-data-factory-utilities

        $adfAzurePath = "/subscriptions/ffff-ffff/resourceGroups/abcxyz/providers/Microsoft.DataFactory/factories/adf000"

        Write-Verbose "Validating & exporting ARM Template..."
        npm run build export $RootFolder $adfAzurePath "ArmTemplate"
    }


    
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

