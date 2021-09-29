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
    [string]$ConfigFolder = Get-VstsInput -Name "DataFactoryConfigPath"

    $global:ErrorActionPreference = 'Continue';

    Write-Host "Invoking Test-AdfCode (https://github.com/SQLPlayer/azure.datafactory.tools) with the following parameters:";
    Write-Host "RootFolder:         $RootFolder";
    Write-Host "Action:             $Action";
    Write-Host "ConfigFolder:       $ConfigFolder";

    if ($Action -eq 'Build')
    {
        $noferrors = Test-AdfCode -RootFolder "$RootFolder" -ConfigPath $ConfigFolder
        # Fail if any errors.
        if ($noferrors -gt 0) {
            Write-VstsSetResult -Result 'Failed' -Message "Build failed." -DoNotThrow
        }
    }

    if ($Action -eq 'Export')
    {
        Set-Location $RootFolder

        Write-Host "=== Preparing package.json file..."
        $packageSourceFile = "$PSScriptRoot\ext\package.json"
        Copy-Item -Path $packageSourceFile -Destination $RootFolder
        Write-Host "=== File copied."

        # Validate and export ARM Template using @microsoft/azure-data-factory-utilities module
        Write-Host "=== Check NPM Version..."
        npm version
        Write-Host "=== Check finished."

        Write-Host "=== Installing NPM azure-data-factory-utilities..."
        npm i @microsoft/azure-data-factory-utilities
        Write-Host "=== Installation finished."

        $adf = Split-Path -Path $RootFolder -Leaf
        $adfAzurePath = "/subscriptions/ffff-ffff/resourceGroups/abcxyz/providers/Microsoft.DataFactory/factories/$adf"

        Write-Host "=== Validating & exporting ARM Template..."
        Write-Verbose "npm run build export $RootFolder $adfAzurePath ""ArmTemplate"""
        npm run build export $RootFolder $adfAzurePath "ArmTemplate"
        Write-Host "=== Export finished."
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

