
# ----------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Gets policy set definitions.
.Description
The **Get-AzPolicySetDefinition** cmdlet gets a collection of policy set definitions or a specific policy set definition identified by name or ID.
.Notes
## RELATED LINKS

[New-AzPolicySetDefinition](./New-AzPolicySetDefinition.md)

[Remove-AzPolicySetDefinition](./Remove-AzPolicySetDefinition.md)

[Update-AzPolicySetDefinition](./Update-AzPolicySetDefinition.md)
.Link
https://learn.microsoft.com/powershell/module/az.resources/get-azpolicysetdefinition
#>
function Get-AzPolicySetDefinition {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.Policy.Models.IPolicySetDefinition])]
[CmdletBinding(DefaultParameterSetName='Name')]
param(
    [Parameter(ParameterSetName='Name', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='ManagementGroupName', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='SubscriptionId', ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Alias('PolicySetDefinitionName')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The name of the policy definition to get.
    ${Name},

    [Parameter(ParameterSetName='Id', Mandatory, ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Alias('ResourceId')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The full Id of the policy definition to get.
    ${Id},

    [Parameter(ParameterSetName='ManagementGroupName', Mandatory, ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='Builtin', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='Custom', ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The name of the management group.
    ${ManagementGroupName},

    [Parameter(ParameterSetName='SubscriptionId', Mandatory, ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='Builtin', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='Custom', ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='Builtin', Mandatory, ValueFromPipelineByPropertyName)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Query')]
    [System.Management.Automation.SwitchParameter]
    # Causes cmdlet to return only built-in policy definitions.
    ${Builtin},

    [Parameter(ParameterSetName='Custom', Mandatory, ValueFromPipelineByPropertyName)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Query')]
    [System.Management.Automation.SwitchParameter]
    # Causes cmdlet to return only custom policy definitions.
    ${Custom},

    [Parameter()]
    [Obsolete('This parameter is a temporary bridge to new types and formats and will be removed in a future release.')]
    [System.Management.Automation.SwitchParameter]
    # Causes cmdlet to return artifacts using legacy format placing policy-specific properties in a property bag object.
    ${BackwardCompatible} = $false,

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Models.IPolicyIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Query')]
    [System.String]
    # The filter to apply on the operation.
    # Valid values for $filter are: 'atExactScope()', 'policyType -eq {value}' or 'category eq '{value}''.
    # If $filter is not provided, no filtering is performed.
    # If $filter=atExactScope() is provided, the returned list only includes all policy set definitions that at the given scope.
    # If $filter='policyType -eq {value}' is provided, the returned list only includes all policy set definitions whose type match the {value}.
    # Possible policyType values are NotSpecified, Builtin, Custom, and Static.
    # If $filter='category -eq {value}' is provided, the returned list only includes all policy set definitions whose category match the {value}.
    ${Filter},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The DefaultProfile parameter is not functional.
    # Use the SubscriptionId parameter when available if executing the cmdlet against a different subscription.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    # turn on console debug messages
    $writeln = ($PSCmdlet.MyInvocation.BoundParameters.Debug -as [bool]) -or ($PSCmdlet.MyInvocation.BoundParameters.Verbose -as [bool])

    if ($writeln) {
        Write-Host -ForegroundColor Cyan "begin:Get-AzPolicySetDefinition(" $PSBoundParameters ") - (ParameterSet: $($PSCmdlet.ParameterSetName))"
    }

    # mapping table of generated cmdlet parameter sets
    $mapping = @{
        Get = 'Az.Policy.private\Get-AzPolicySetDefinition_Get';
        Get1 = 'Az.Policy.private\Get-AzPolicySetDefinition_Get1';
        GetViaIdentity = 'Az.Policy.private\Get-AzPolicySetDefinition_GetViaIdentity';
        GetViaIdentity1 = 'Az.Policy.private\Get-AzPolicySetDefinition_GetViaIdentity1';
        List = 'Az.Policy.private\Get-AzPolicySetDefinition_List';
        List1 = 'Az.Policy.private\Get-AzPolicySetDefinition_List1';
        BuiltinId='Az.Policy.private\Get-AzPolicySetDefinitionBuilt_GetViaIdentity';
        BuiltinGet='Az.Policy.private\Get-AzPolicySetDefinitionBuilt_Get';
        BuiltinList='Az.Policy.private\Get-AzPolicySetDefinitionBuilt_List';
    }
}

process {
    if ($writeln) {
        Write-Host -ForegroundColor Cyan "process:Get-AzPolicySetDefinition(" $PSBoundParameters ") - (ParameterSet: $($PSCmdlet.ParameterSetName))"
    }

    # ensure fallback try/catch is invoked if necessary
    $PSBoundParameters['ErrorAction'] = 'Stop'

    # handle disallowed cases not handled by PS parameter attributes
    if ($PSBoundParameters['SubscriptionId'] -and $PSBoundParameters['ManagementGroupName']) {
        throw 'Only ManagementGroupName or SubscriptionId can be provided, not both.'
    }

    # handle specific parameter sets
    $parameterSet = $PSCmdlet.ParameterSetName
    $calledParameterSet = 'List'

    switch ($parameterSet) {
        'Builtin' {
            $PSBoundParameters.Add('Filter', "policyType eq 'Builtin'")
        }
        'Custom' {
            $PSBoundParameters.Add('Filter', "policyType eq 'Custom'")
        }
        'Id' {
            $parsed = ParsePolicySetDefinitionId $Id   # function is imported from Helpers.psm1
            switch ($parsed.ScopeType)
            {
                'subid' {
                    $PSBoundParameters['SubscriptionId'] = $parsed['SubscriptionId']
                    if ($parsed['Name']) {
                        $calledParameterSet = 'Get';
                        $PSBoundParameters['Name'] = $parsed['Name']
                    }
                }
                'mgname' {
                    $PSBoundParameters['ManagementGroupName'] = $parsed['ManagementGroupName']
                    $PSBoundParameters['Name'] = $parsed['Name']
                    $calledParameterSet = 'Get1';
                }
                'builtin' {
                    $calledParameterSet = 'BuiltinId'
                    $PSBoundParameters['InputObject'] = @{ 'Id' = $PSBoundParameters['Id'] }
                }
            }
        }
    }

    # this check is needed because builtin Ids are special (no subId, no mgId)
    if ($calledParameterSet -ne 'BuiltinId') {
        # determine parameter set for call to generated cmdlet
        if ($PSBoundParameters['SubscriptionId']) {
            if ($PSBoundParameters['Name']) {
                $calledParameterSet = 'Get';
            }
            else {
                $calledParameterSet = 'List';
            }
        }
        elseif ($PSBoundParameters['ManagementGroupName']) {
            $PSBoundParameters['ManagementGroupId'] = $PSBoundParameters['ManagementGroupName']
            if ($PSBoundParameters['Name']) {
                $calledParameterSet = 'Get1'
            }
            else {
                $calledParameterSet = 'List1'
            }
        }
        elseif ($parameterSet -ne 'Id') {
            $PSBoundParameters['SubscriptionId'] = (Get-SubscriptionId)
            if ($PSBoundParameters['Name']) {
                $calledParameterSet = 'Get'
            }
        }
    }

    # remove parameters not used by generated cmdlets
    $null = $PSBoundParameters.Remove('BackwardCompatible')
    $null = $PSBoundParameters.Remove('ManagementGroupName')
    $null = $PSBoundParameters.Remove('Id')
    $null = $PSBoundParameters.Remove('Builtin')
    $null = $PSBoundParameters.Remove('Custom')

    if ($writeln) {
        Write-Host -ForegroundColor Blue -> $mapping[$calledParameterSet]'(' $PSBoundParameters ')'
    }

    $cmdInfo = Get-Command -Name $mapping[$calledParameterSet]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Runtime.MessageAttributeHelper]::ProcessCustomAttributesAtRuntime($cmdInfo, $MyInvocation, $calledParameterSet, $PSCmdlet)
    $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$calledParameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
    $scriptCmd = {& $wrappedCmd @PSBoundParameters}

    # get output and fix up for backward compatibility
    try {
        $output = Invoke-Command -ScriptBlock $scriptCmd
    }
    catch {
        if (($_.Exception.Message -like '*PolicySetDefinitionNotFound*') -and $PSBoundParameters.Name -and $PSBoundParameters.SubscriptionId) {

            # failed by name at subscription level, try builtins
            $PSBoundParameters.PolicySetDefinitionName = $PSBoundParameters.Name
            $null = $PSBoundParameters.Remove('Name')
            $null = $PSBoundParameters.Remove('SubscriptionId')

            $cmdInfo = Get-Command -Name $mapping['BuiltinGet']
            [Microsoft.Azure.PowerShell.Cmdlets.Policy.Runtime.MessageAttributeHelper]::ProcessCustomAttributesAtRuntime($cmdInfo, $MyInvocation, $calledParameterSet, $PSCmdlet)
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping['BuiltinGet']), [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = {& $wrappedCmd @PSBoundParameters}

            if ($writeln) {
                Write-Host -ForegroundColor Blue -> $mapping['BuiltinGet']'(' $PSBoundParameters ')'
            }

            $output = Invoke-Command -ScriptBlock $scriptCmd
        }
        else {
            throw
        }
    }

    foreach ($item in $output) {
        # add property bag for backward compatibility with previous SDK cmdlets
        if ($BackwardCompatible) {
            $propertyBag = @{
                Description = $item.Description;
                DisplayName = $item.DisplayName;
                Metadata = ConvertObjectToPSObject $item.Metadata;
                Parameters = ConvertObjectToPSObject $item.Parameter;
                PolicyDefinitionGroups = ConvertObjectToPSObject $item.PolicyDefinitionGroup;
                PolicyDefinitions = ConvertObjectToPSObject $item.PolicyDefinition;
                PolicyType = $item.PolicyType
            }

            $item | Add-Member -MemberType NoteProperty -Name 'Properties' -Value ([PSCustomObject]($propertyBag))
            $item | Add-Member -MemberType NoteProperty -Name 'ResourceId' -Value $item.Id
            $item | Add-Member -MemberType NoteProperty -Name 'ResourceName' -Value $item.Name
            $item | Add-Member -MemberType NoteProperty -Name 'ResourceType' -Value $item.Type
            $item | Add-Member -MemberType NoteProperty -Name 'PolicySetDefinitionId' -Value $item.Id
        }

        # use PSCustomObject for JSON properties
        $item | Add-Member -MemberType NoteProperty -Name 'Metadata' -Value (ConvertObjectToPSObject $item.Metadata) -Force
        $item | Add-Member -MemberType NoteProperty -Name 'Parameter' -Value (ConvertObjectToPSObject $item.Parameter) -Force
        $item | Add-Member -MemberType NoteProperty -Name 'PolicyDefinitionGroup' -Value (ConvertObjectToPSObject $item.PolicyDefinitionGroup) -Force
        $item | Add-Member -MemberType NoteProperty -Name 'PolicyDefinition' -Value (ConvertObjectToPSObject $item.PolicyDefinition) -Force
        $PSCmdlet.WriteObject($item)
    }
}

end {
}
}

# SIG # Begin signature block
# MIIoKQYJKoZIhvcNAQcCoIIoGjCCKBYCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCC2hQVK8GwV4/W+
# 8R8fnS4ZunsHCZhKntZiDYcBg9bS46CCDXYwggX0MIID3KADAgECAhMzAAADrzBA
# DkyjTQVBAAAAAAOvMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjMxMTE2MTkwOTAwWhcNMjQxMTE0MTkwOTAwWjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDOS8s1ra6f0YGtg0OhEaQa/t3Q+q1MEHhWJhqQVuO5amYXQpy8MDPNoJYk+FWA
# hePP5LxwcSge5aen+f5Q6WNPd6EDxGzotvVpNi5ve0H97S3F7C/axDfKxyNh21MG
# 0W8Sb0vxi/vorcLHOL9i+t2D6yvvDzLlEefUCbQV/zGCBjXGlYJcUj6RAzXyeNAN
# xSpKXAGd7Fh+ocGHPPphcD9LQTOJgG7Y7aYztHqBLJiQQ4eAgZNU4ac6+8LnEGAL
# go1ydC5BJEuJQjYKbNTy959HrKSu7LO3Ws0w8jw6pYdC1IMpdTkk2puTgY2PDNzB
# tLM4evG7FYer3WX+8t1UMYNTAgMBAAGjggFzMIIBbzAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQURxxxNPIEPGSO8kqz+bgCAQWGXsEw
# RQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEW
# MBQGA1UEBRMNMjMwMDEyKzUwMTgyNjAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzci
# tW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEG
# CCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0
# MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAISxFt/zR2frTFPB45Yd
# mhZpB2nNJoOoi+qlgcTlnO4QwlYN1w/vYwbDy/oFJolD5r6FMJd0RGcgEM8q9TgQ
# 2OC7gQEmhweVJ7yuKJlQBH7P7Pg5RiqgV3cSonJ+OM4kFHbP3gPLiyzssSQdRuPY
# 1mIWoGg9i7Y4ZC8ST7WhpSyc0pns2XsUe1XsIjaUcGu7zd7gg97eCUiLRdVklPmp
# XobH9CEAWakRUGNICYN2AgjhRTC4j3KJfqMkU04R6Toyh4/Toswm1uoDcGr5laYn
# TfcX3u5WnJqJLhuPe8Uj9kGAOcyo0O1mNwDa+LhFEzB6CB32+wfJMumfr6degvLT
# e8x55urQLeTjimBQgS49BSUkhFN7ois3cZyNpnrMca5AZaC7pLI72vuqSsSlLalG
# OcZmPHZGYJqZ0BacN274OZ80Q8B11iNokns9Od348bMb5Z4fihxaBWebl8kWEi2O
# PvQImOAeq3nt7UWJBzJYLAGEpfasaA3ZQgIcEXdD+uwo6ymMzDY6UamFOfYqYWXk
# ntxDGu7ngD2ugKUuccYKJJRiiz+LAUcj90BVcSHRLQop9N8zoALr/1sJuwPrVAtx
# HNEgSW+AKBqIxYWM4Ev32l6agSUAezLMbq5f3d8x9qzT031jMDT+sUAoCw0M5wVt
# CUQcqINPuYjbS1WgJyZIiEkBMIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkq
# hkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
# IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEwOTA5WjB+MQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQg
# Q29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
# CgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+laUKq4BjgaBEm6f8MMHt03
# a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc6Whe0t+bU7IKLMOv2akr
# rnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4Ddato88tt8zpcoRb0Rrrg
# OGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+lD3v++MrWhAfTVYoonpy
# 4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nkkDstrjNYxbc+/jLTswM9
# sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6A4aN91/w0FK/jJSHvMAh
# dCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmdX4jiJV3TIUs+UsS1Vz8k
# A/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL5zmhD+kjSbwYuER8ReTB
# w3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zdsGbiwZeBe+3W7UvnSSmn
# Eyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3T8HhhUSJxAlMxdSlQy90
# lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS4NaIjAsCAwEAAaOCAe0w
# ggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRIbmTlUAXTgqoXNzcitW2o
# ynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYD
# VR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBDuRQFTuHqp8cx0SOJNDBa
# BgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2Ny
# bC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3JsMF4GCCsG
# AQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3J0MIGfBgNV
# HSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEFBQcCARYzaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1hcnljcHMuaHRtMEAGCCsG
# AQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkAYwB5AF8AcwB0AGEAdABl
# AG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn8oalmOBUeRou09h0ZyKb
# C5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7v0epo/Np22O/IjWll11l
# hJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0bpdS1HXeUOeLpZMlEPXh6
# I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/KmtYSWMfCWluWpiW5IP0
# wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvyCInWH8MyGOLwxS3OW560
# STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBpmLJZiWhub6e3dMNABQam
# ASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJihsMdYzaXht/a8/jyFqGa
# J+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYbBL7fQccOKO7eZS/sl/ah
# XJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbSoqKfenoi+kiVH6v7RyOA
# 9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sLgOppO6/8MO0ETI7f33Vt
# Y5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtXcVZOSEXAQsmbdlsKgEhr
# /Xmfwb1tbWrJUnMTDXpQzTGCGgkwghoFAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAAOvMEAOTKNNBUEAAAAAA68wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIOVW2kp27dHdQ7oY1iIAW36G
# 39Doi72cm09Bd/yTjhwCMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAWPxBDOsWmBpUnE8j1Mvke4L3cvIZfVAGLznsVy6LcA/MiY5sx8mDGrFW
# Jg+8qAJToBKjDNuJCbljCvK9gwGzn2tS18iyOW5ZTQVIpVrTq2jiVD5U4qY33gW+
# soDfXLLQ//amuoz8nCnLaoKEXhkURzdyxsfsLZ02EGQSJGNioHg+atIahI35CBBT
# mk+4K7ZuWPyv3aB65GegojiJtQUpqNtGQQgTgF6dw1d0e7PPRFPp3H0k3BCTnXbX
# LihGF5fxMJsKrf2m7M65lPqNHk7z0X62ogcOodDipbVfA8cgoQ5N9dHH5BSMQ5/e
# 6s2E90zfeMF45oeETPHN6bPtXOw6l6GCF5MwghePBgorBgEEAYI3AwMBMYIXfzCC
# F3sGCSqGSIb3DQEHAqCCF2wwghdoAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFRBgsq
# hkiG9w0BCRABBKCCAUAEggE8MIIBOAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCCPK1lsuc1uHlAM9n9mIYQrZ8R+MenfMjBo/IuDqd/yhwIGZjOTWhEQ
# GBIyMDI0MDUxNjA2NDIxMS45MlowBIACAfSggdGkgc4wgcsxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJTAjBgNVBAsTHE1pY3Jvc29mdCBBbWVy
# aWNhIE9wZXJhdGlvbnMxJzAlBgNVBAsTHm5TaGllbGQgVFNTIEVTTjo3RjAwLTA1
# RTAtRDk0NzElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaCC
# EeowggcgMIIFCKADAgECAhMzAAAB8Cp8HVk75h+tAAEAAAHwMA0GCSqGSIb3DQEB
# CwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
# EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNV
# BAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMB4XDTIzMTIwNjE4NDU1
# MVoXDTI1MDMwNTE4NDU1MVowgcsxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJTAjBgNVBAsTHE1pY3Jvc29mdCBBbWVyaWNhIE9wZXJhdGlvbnMx
# JzAlBgNVBAsTHm5TaGllbGQgVFNTIEVTTjo3RjAwLTA1RTAtRDk0NzElMCMGA1UE
# AxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCCAiIwDQYJKoZIhvcNAQEB
# BQADggIPADCCAgoCggIBALUeLVOjOHc7RzMTzF9GevKaUk0JoZaiaY/LR4g1/7gQ
# mvut/y1LOWATwiXhmPjxPl9NM4CHqchNF/aUrv66lydn/GDQAqgNikFA5asv05sV
# KHKUgd+v8NDg+xFfwZG0ie4mwyTBKDrdt8HhDZSKQwQ/8K1keLzFble0Aqn3lyze
# a9QIy8gADzcmv9TIAMAIldVTiZpiKxzNTPsnXXV4PUqsb2ZD4hOCdFH9fbFMMwLP
# 6KjxlkUcbARmD5ze+Y+nzubg6o4pbKFyoxS6k+947+BAL1G/izMs0YNqh494rohT
# QmpwaNerFtwShL+zWEKA93tTHphZ5atRdrFtv4miyA5rNSBQazVqqmcuPPRgp9Sq
# fyLlNuZHV2oSVHhAD45l95WGlOiesziwT8yUnUkulHYXAAgdR4x+i1c1CLK1h9EF
# Q4kcV4lgR+VmBWTRfH/iRkF3OAVA85Z9V3Y2jNeULZ6ka1SNqW4Daiw69AdnMY6g
# pO9ZQ9f30yywY5s7TEkd3QPKA/8kBWn5tEYmpra7sCoubb60BPbrIjm95xwOY1my
# De8OHUdykIlr1ClFb8wPdr4AXbKBXWxGcZVRUbdU4NfcGEZPxMxT8aJTLeHsKVc7
# GZn7B4K4g7MKRMNsrk6UBLypI+mCn5caU4sQ9ozfUyB/phOmkBp4/SimHHfjmiG3
# AgMBAAGjggFJMIIBRTAdBgNVHQ4EFgQU0IKyp1dHL8yaNkZVMC/HtgVamyUwHwYD
# VR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYDVR0fBFgwVjBUoFKgUIZO
# aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jcmwvTWljcm9zb2Z0JTIw
# VGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwGCCsGAQUFBwEBBGAwXjBc
# BggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0
# cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcnQwDAYD
# VR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAOBgNVHQ8BAf8EBAMC
# B4AwDQYJKoZIhvcNAQELBQADggIBADgi9JueviMQ+CjlbjGPf/7R0IbCzPzrdAZn
# aYH1nhLC0YYsy/B+xFSzc0iU8P8uxYDF1VgeSUDPAtPBDkz49F3L3YMZ+3IQ4Ywd
# +63sarwvdFRy+u+vQAv80218SlsASQIXOx57G1jmzeHOPetfbC+gFmbbK2HBwt5m
# YyAdAKaNmn/bR8dYmCuM9iOx7pEMm1ROW9SyOv7zvz+36+tAQiqWZ5sJ4SL5VBXF
# zvAXQu4xPD+AJZ1yoeiovnYmi3ErNjyNlJDtxw0eELh4cYVGlop6JJDQZe2VsYhs
# /iRbU7cnOUqN/AbrY0JK9+YzWI8P3RdiIWbv/yaBHXoCap58Ox+MEJbB/eqF4gx+
# BnNap4TPyVoWYzwN2ReO44JAT/YvRPGGuNS10yQBN9d1mNhGWxwEPKvzMYyWmsUL
# stzGoJeWHGG13YIz6alxNzxEHYPcSivRR2g/fpD2vhdYJVX/YqfQBe29bG8h/I4W
# blouXR4TOSF+/9eZSUF44ISVLuN111akGVCMm4cdQeM5UZeWslPtfiGJwXWjbfHl
# T6Puo8oFx6vI/b/WjF+Ydzq4FeVcEq6RX9AJkFUCIExgmGeS1qRYemj24h5KdhPp
# DHvB/ZFq5gcgRHxItGZuUzM86z4kdDOu+HvFK3HfXQs6n7QNo5ezzGNm+Gmf5a5m
# KPlGZmKMMIIHcTCCBVmgAwIBAgITMwAAABXF52ueAptJmQAAAAAAFTANBgkqhkiG
# 9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAO
# BgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEy
# MDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIw
# MTAwHhcNMjEwOTMwMTgyMjI1WhcNMzAwOTMwMTgzMjI1WjB8MQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGlt
# ZS1TdGFtcCBQQ0EgMjAxMDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB
# AOThpkzntHIhC3miy9ckeb0O1YLT/e6cBwfSqWxOdcjKNVf2AX9sSuDivbk+F2Az
# /1xPx2b3lVNxWuJ+Slr+uDZnhUYjDLWNE893MsAQGOhgfWpSg0S3po5GawcU88V2
# 9YZQ3MFEyHFcUTE3oAo4bo3t1w/YJlN8OWECesSq/XJprx2rrPY2vjUmZNqYO7oa
# ezOtgFt+jBAcnVL+tuhiJdxqD89d9P6OU8/W7IVWTe/dvI2k45GPsjksUZzpcGkN
# yjYtcI4xyDUoveO0hyTD4MmPfrVUj9z6BVWYbWg7mka97aSueik3rMvrg0XnRm7K
# MtXAhjBcTyziYrLNueKNiOSWrAFKu75xqRdbZ2De+JKRHh09/SDPc31BmkZ1zcRf
# NN0Sidb9pSB9fvzZnkXftnIv231fgLrbqn427DZM9ituqBJR6L8FA6PRc6ZNN3SU
# HDSCD/AQ8rdHGO2n6Jl8P0zbr17C89XYcz1DTsEzOUyOArxCaC4Q6oRRRuLRvWoY
# WmEBc8pnol7XKHYC4jMYctenIPDC+hIK12NvDMk2ZItboKaDIV1fMHSRlJTYuVD5
# C4lh8zYGNRiER9vcG9H9stQcxWv2XFJRXRLbJbqvUAV6bMURHXLvjflSxIUXk8A8
# FdsaN8cIFRg/eKtFtvUeh17aj54WcmnGrnu3tz5q4i6tAgMBAAGjggHdMIIB2TAS
# BgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQWBBQqp1L+ZMSavoKRPEY1
# Kc8Q/y8E7jAdBgNVHQ4EFgQUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXAYDVR0gBFUw
# UzBRBgwrBgEEAYI3TIN9AQEwQTA/BggrBgEFBQcCARYzaHR0cDovL3d3dy5taWNy
# b3NvZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnkuaHRtMBMGA1UdJQQMMAoG
# CCsGAQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQEAwIB
# hjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFNX2VsuP6KJcYmjRPZSQW9fO
# mhjEMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9w
# a2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNybDBaBggr
# BgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNv
# bS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3J0MA0GCSqGSIb3
# DQEBCwUAA4ICAQCdVX38Kq3hLB9nATEkW+Geckv8qW/qXBS2Pk5HZHixBpOXPTEz
# tTnXwnE2P9pkbHzQdTltuw8x5MKP+2zRoZQYIu7pZmc6U03dmLq2HnjYNi6cqYJW
# AAOwBb6J6Gngugnue99qb74py27YP0h1AdkY3m2CDPVtI1TkeFN1JFe53Z/zjj3G
# 82jfZfakVqr3lbYoVSfQJL1AoL8ZthISEV09J+BAljis9/kpicO8F7BUhUKz/Aye
# ixmJ5/ALaoHCgRlCGVJ1ijbCHcNhcy4sa3tuPywJeBTpkbKpW99Jo3QMvOyRgNI9
# 5ko+ZjtPu4b6MhrZlvSP9pEB9s7GdP32THJvEKt1MMU0sHrYUP4KWN1APMdUbZ1j
# dEgssU5HLcEUBHG/ZPkkvnNtyo4JvbMBV0lUZNlz138eW0QBjloZkWsNn6Qo3GcZ
# KCS6OEuabvshVGtqRRFHqfG3rsjoiV5PndLQTHa1V1QJsWkBRH58oWFsc/4Ku+xB
# Zj1p/cvBQUl+fpO+y/g75LcVv7TOPqUxUYS8vwLBgqJ7Fx0ViY1w/ue10CgaiQuP
# Ntq6TPmb/wrpNPgkNWcr4A245oyZ1uEi6vAnQj0llOZ0dFtq0Z4+7X6gMTN9vMvp
# e784cETRkPHIqzqKOghif9lwY1NNje6CbaUFEMFxBmoQtB1VM1izoXBm8qGCA00w
# ggI1AgEBMIH5oYHRpIHOMIHLMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1lcmljYSBPcGVyYXRpb25zMScw
# JQYDVQQLEx5uU2hpZWxkIFRTUyBFU046N0YwMC0wNUUwLUQ5NDcxJTAjBgNVBAMT
# HE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2WiIwoBATAHBgUrDgMCGgMVAMIo
# Bkoq/mWx0LbKgwYpiJDLv2n/oIGDMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAg
# UENBIDIwMTAwDQYJKoZIhvcNAQELBQACBQDp790GMCIYDzIwMjQwNTE2MDExNjU0
# WhgPMjAyNDA1MTcwMTE2NTRaMHQwOgYKKwYBBAGEWQoEATEsMCowCgIFAOnv3QYC
# AQAwBwIBAAICDlMwBwIBAAICE0IwCgIFAOnxLoYCAQAwNgYKKwYBBAGEWQoEAjEo
# MCYwDAYKKwYBBAGEWQoDAqAKMAgCAQACAwehIKEKMAgCAQACAwGGoDANBgkqhkiG
# 9w0BAQsFAAOCAQEASCgwvivxZBojII6gMuYmpX2QsY/ErUa5sjw1eMFdsITsUdwz
# HGMaWDRPXnh907d1m/Z2gjebUYy/j1IcNNzolSdjuv79n718DpTO+49+Q4TqjXTz
# N5z9s9CthPF5rjGp1DybgZqFtwf8EOeH4GjL05fli2oKxzx55v0jmsKZYT/NZCgS
# 3MSsTuxcrcD1x2SlhDRfBODdhhvRjKjW6sIz2ss9ZdlvPRv1mmpInlH92g+DxadZ
# DBx+WsOiB24Hbe7goRjRaglTT+xGYWfCp9AZwAeEuTjr/HeGi2oxYN4pxqhjp4D1
# 40lDHd37X3RaWuj7q4Am1ZB2UohU83XHrB9IczGCBA0wggQJAgEBMIGTMHwxCzAJ
# BgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25k
# MR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jv
# c29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAB8Cp8HVk75h+tAAEAAAHwMA0G
# CWCGSAFlAwQCAQUAoIIBSjAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwLwYJ
# KoZIhvcNAQkEMSIEIPDGk5VRueiVfbL7+vlUDRYCUdezVjMCJJVDyG4Dfif5MIH6
# BgsqhkiG9w0BCRACLzGB6jCB5zCB5DCBvQQgXAGao6Vy/eRTuYAHmxZHvhAUCJLq
# Zv4IzpqycUBlS4swgZgwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAx
# MAITMwAAAfAqfB1ZO+YfrQABAAAB8DAiBCA/Fm2fG6sBa4zHx+z40Yp2KnfZ5rgc
# hNuZiJTlaeCFuTANBgkqhkiG9w0BAQsFAASCAgBtdQINHlNY1gC+T3ATaiYk4zX8
# HZuuIIwgJDLkmQFU2+Y8OhAGnQTK2lctkzWpgpMbzZcM+OZyY6qmwrtKu4J7h0e1
# S3kbJOlomODsWsH57Je+JIxYIsGDFfHDuXzg+Xt6jY0+IyNtBtZGt01dYBUhQ46G
# bk9Sb4D8VZDd78MdC+mHEFCo/5byalGWabEUVkh/lAsZhnVXgTDGxltJvh2LtvgR
# pExwoAf/eg83aO+REeOdtZsgOU4O+vYfkCHagDvpH2yIoTooMuGu2vMl9j4en5VC
# BprIsr9l7dweBMl3kK4eUfaT3SX68kghImoW8uKwmHhWgM+fmK45H9A8P/Q0lsn1
# oanWyh7J90Rka/zN1FQK4JtJNdYq8ztUMQ6KrJhvBp6d6i01EIzf+LhVpLi3mBnb
# RW2w7liqxumVnam9uBKsCoZn2ms+FedwH2bTtVwCVQFueHImVwUwWE1IKO44MkO1
# Rfh/RY0ChhSDroixuPnNkgtduuyizlUYlt5t/7OayIRYu3H0h56N3EghP0GddWMV
# O4ws1mIdrEiFjfkEbIEpvmtuKCedObExEyJPvkmW21MxuKphRbVWEK4DKMDaWc5T
# RUiArMhzBvugkg+21nwPcVGt/prQDygFVEqyjD3AThVAccZCJBmK1ESaAP/+DFNB
# mm4OBLmh2ku9LIuNrA==
# SIG # End signature block
