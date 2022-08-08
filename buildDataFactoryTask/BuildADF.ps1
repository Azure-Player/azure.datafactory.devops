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
    [string]$SubscriptionId = Get-VstsInput -Name "SubscriptionId"
    [string]$ResourceGroup = Get-VstsInput -Name "ResourceGroup"
    [string]$AdfUtilitiesVersion = Get-VstsInput -Name "AdfUtilitiesVersion"
    [string]$OutputFolder = Get-VstsInput -Name "OutputFolder"
    
    $global:ErrorActionPreference = 'Continue';

    Write-Host "Invoking Test-AdfCode (https://github.com/SQLPlayer/azure.datafactory.tools) with the following parameters:";
    Write-Host "RootFolder:         $RootFolder";
    Write-Host "Action:             $Action";
    Write-Host "ConfigFolder:       $ConfigFolder";

    if ($Action -eq 'Build')
    {
        $r = Test-AdfCode -RootFolder "$RootFolder" -ConfigPath $ConfigFolder

        # Set pipeline output variable
        Write-Host "##vso[task.setvariable variable=AdfBuildTaskErrors]$($r.ErrorCount)"
        Write-Host "##vso[task.setvariable variable=AdfBuildTaskWarnings]$($r.WarningCount)"

        # Fail if any errors.
        if ($r.ErrorCount -gt 0) {
            Write-VstsSetResult -Result 'Failed' -Message "Build failed." -DoNotThrow
        }
    }

    if ($Action -eq 'Export')
    {
        if ($null -eq $OutputFolder -or $OutputFolder -eq '') { $OutputFolder = 'ArmTemplate' }

        Export-AdfToArmTemplate -RootFolder $RootFolder `
            -SubscriptionId $SubscriptionId `
            -ResourceGroup $ResourceGroup `
            -AdfUtilitiesVersion $AdfUtilitiesVersion `
            -OutputFolder $OutputFolder

        $expectedFile = Join-Path (Join-Path $RootFolder $OutputFolder) 'ARMTemplateForFactory.json'
        if (!(Test-Path -Path $expectedFile)) {
            Write-VstsSetResult -Result 'Failed' -Message "Export failed. ARMTemplateForFactory.json file couldn't be found." -DoNotThrow
        }

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

