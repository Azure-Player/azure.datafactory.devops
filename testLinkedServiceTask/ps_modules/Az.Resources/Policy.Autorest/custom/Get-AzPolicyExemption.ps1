
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
Gets policy exemptions.
.Description
The **Get-AzPolicyExemption** cmdlet gets a collection of policy exemptions or a specific policy exemption identified by name or ID.
.Notes
## RELATED LINKS

[New-AzPolicyExemption](./New-AzPolicyExemption.md)

[Remove-AzPolicyExemption](./Remove-AzPolicyExemption.md)

[Update-AzPolicyExemption](./Update-AzPolicyExemption.md)
.Link
https://learn.microsoft.com/powershell/module/az.resources/get-azpolicyexemption
#>
function Get-AzPolicyExemption {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.Policy.Models.IPolicyExemption])]
[CmdletBinding(DefaultParameterSetName='Name')]
param(
    [Parameter(ParameterSetName='Name', ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Alias('PolicyExemptionName')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The name of the policy exemption.
    ${Name},

    [Parameter(ParameterSetName='Name',ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='IncludeDescendent', ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The scope of the policy exemption.
    # Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}', or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'
    ${Scope},

    [Parameter(ParameterSetName='Id', Mandatory, ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Alias('ResourceId')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The fully qualified resource Id of the exemption.
    ${Id},

    [Parameter(ParameterSetName='Name', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='Id', ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The policy assignment id filter.
    ${PolicyAssignmentIdFilter},

    [Parameter(ParameterSetName='IncludeDescendent', Mandatory, ValueFromPipelineByPropertyName)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.Management.Automation.SwitchParameter]
    # Causes the list of returned policy exemptions to include all exemptions related to the given scope, including those from ancestor scopes and those from descendent scopes.
    ${IncludeDescendent},

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
    # Valid values for $filter are: 'atScope()', 'atExactScope()', 'excludeExpired()' or 'policyAssignmentId eq '{value}''.
    # If $filter is not provided, no filtering is performed.
    # If $filter is not provided, the unfiltered list includes all policy exemptions associated with the scope, including those that apply directly or apply from containing scopes.
    # If $filter=atScope() is provided, the returned list only includes all policy exemptions that apply to the scope, which is everything in the unfiltered list except those applied to sub scopes contained within the given scope.
    # If $filter=atExactScope() is provided, the returned list only includes all policy exemptions that at the given scope.
    # If $filter=excludeExpired() is provided, the returned list only includes all policy exemptions that either haven't expired or didn't set expiration date.
    # If $filter=policyAssignmentId eq '{value}' is provided.
    # the returned list only includes all policy exemptions that are associated with the give policyAssignmentId.
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
        Write-Host -ForegroundColor Cyan "begin:Get-AzPolicyExemption(" $PSBoundParameters ") - (ParameterSet: $($PSCmdlet.ParameterSetName))"
    }

    # make mapping table
    $mapping = @{
        Get = 'Az.Policy.private\Get-AzPolicyExemption_Get';
        GetViaIdentity = 'Az.Policy.private\Get-AzPolicyExemption_GetViaIdentity';
        List = 'Az.Policy.private\Get-AzPolicyExemption_List';
        List1 = 'Az.Policy.private\Get-AzPolicyExemption_List1';
        List2 = 'Az.Policy.private\Get-AzPolicyExemption_List2';
        List3 = 'Az.Policy.private\Get-AzPolicyExemption_List3';
    }
}

process {
    if ($writeln) {
        Write-Host -ForegroundColor Cyan "process:Get-AzPolicyExemption(" $PSBoundParameters ") - (ParameterSet: $($PSCmdlet.ParameterSetName))"
    }

    $calledParameters = $PSBoundParameters

    if ($Id) {
        $parsed = ParsePolicyExemptionId $Id

        if ($parsed.Name) {
            $Name = $parsed.Name
        }

        if ($parsed.Scope) {
            $Scope = $parsed.Scope
        }
    }

    if (!$Scope) {
        $Scope = "/subscriptions/$($(Get-SubscriptionId))"
    }

    if ($Name) {
        $calledParameterSet = 'Get'
        $calledParameters.Name = $Name
        $calledParameters.Scope = $Scope
    }
    else {
        # set up filter values for list case
        if ($PolicyAssignmentIdFilter) {
            $calledParameters.Filter = "policyAssignmentId eq '$($PolicyAssignmentIdFilter)'"
        }
        elseif (!$IncludeDescendent) {
            $calledParameters.Filter = 'atScope()'
        }

        if ($Scope) {
            $resolved = ResolvePolicyExemption $null $Scope $null
            switch ($resolved.ScopeType) {
                'mgName' {
                    if ($IncludeDescendent) {
                        throw 'The IncludeDescendent switch is not supported for management group scopes.'
                    }

                    $calledParameterSet = 'List3'
                    $calledParameters.ManagementGroupId = $resolved.ManagementGroupName
                }
                'subId' {
                    $calledParameterSet = 'List'
                    $calledParameters.SubscriptionId = @($resolved.SubscriptionId)
                }
                'rgname' {
                    $calledParameterSet = 'List1'
                    $calledParameters.SubscriptionId = @($resolved.SubscriptionId)
                    $calledParameters.ResourceGroupName = $resolved.ResourceGroupName
                }
                'resource' {
                    $resourceId = $resolved.Scope
                    $parts = ($resourceId -split '/')
                    $first = 1
                    $last = $parts.Length - 2
                    $calledParameterSet = 'List2'
                    $calledParameters.ResourceProviderNamespace = $parts[0]
                    $calledParameters.ResourceName = $parts[$parts.Length-1]
                    $calledParameters.ResourceType = [System.String]::Join('/', $parts[$first..$last])
                    $calledParameters.SubscriptionId = @($resolved.SubscriptionId)
                    $calledParameters.ResourceGroupName = $resolved.ResourceGroupName
                }
                'none' {
                    throw '[MissingSubscription] : The request did not have a subscription or a valid tenant level resource provider.'
                }
            }
        }

        $null = $calledParameters.Remove('Scope')
    }

    $null = $calledParameters.Remove('Id')
    $null = $calledParameters.Remove('PolicyAssignmentIdFilter')
    $null = $calledParameters.Remove('IncludeDescendent')
    $null = $calledParameters.Remove('BackwardCompatible')

    if ($writeln) {
        Write-Host -ForegroundColor Blue -> $mapping[$calledParameterSet]'(' $calledParameters ')'
    }

    $cmdInfo = Get-Command -Name $mapping[$calledParameterSet]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Runtime.MessageAttributeHelper]::ProcessCustomAttributesAtRuntime($cmdInfo, $MyInvocation, $calledParameterSet, $PSCmdlet)
    $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$calledParameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
    $scriptCmd = {& $wrappedCmd @calledParameters}
    $object = Invoke-Command -ScriptBlock $scriptCmd

    foreach ($item in $object) {
        # add property bag for backward compatibility with previous SDK cmdlets
        if ($BackwardCompatible) {
            $propertyBag = @{
                Description = $item.Description;
                DisplayName = $item.DisplayName;
                ExpiresOn = $item.ExpiresOn;
                ExemptionCategory = $item.ExemptionCategory;
                Metadata = (ConvertObjectToPSObject $item.Metadata);
                PolicyDefinitionReferenceIds = (ConvertObjectToPSObject $item.PolicyDefinitionReferenceId);
                PolicyAssignmentId = $item.PolicyAssignmentId
            }

            $item | Add-Member -MemberType NoteProperty -Name 'Properties' -Value ([PSCustomObject]($propertyBag))
            $item | Add-Member -MemberType NoteProperty -Name 'ResourceId' -Value $item.Id
            $item | Add-Member -MemberType NoteProperty -Name 'ResourceName' -Value $item.Name
            $item | Add-Member -MemberType NoteProperty -Name 'ResourceType' -Value $item.Type
        }

        $item | Add-Member -MemberType NoteProperty -Name 'Metadata' -Value (ConvertObjectToPSObject $item.Metadata) -Force
        $item | Add-Member -MemberType NoteProperty -Name 'PolicyDefinitionReferenceId' -Value (ConvertObjectToPSObject $item.PolicyDefinitionReferenceId) -Force
        $PSCmdlet.WriteObject($item)
    }
}

end {
} 
}

# SIG # Begin signature block
# MIInvwYJKoZIhvcNAQcCoIInsDCCJ6wCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCA9o1d7dffr1rT
# njBWO7oafKPpsgS8m8PHOXWu/i56pqCCDXYwggX0MIID3KADAgECAhMzAAADrzBA
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
# /Xmfwb1tbWrJUnMTDXpQzTGCGZ8wghmbAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAAOvMEAOTKNNBUEAAAAAA68wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIMeenzd+2te4qBo3kIXiRgTZ
# WEzM+DT/cP8UeLqOVGRwMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAZ+LsSpaHIvZQqm1wmXR+AmAZoB1ZbP+eJMNT8QAp3uyttPLjpDaa1SN9
# ffmy6ZfPK6E5IqUArH580dD35kH0AuZmyOjxR0CaDibg2UwR78eGgYoAR2WaT+XL
# QlPT8V7hjM+GeWNMyAR3LTrG+SdmuAc+dOD5Wu+uuW4+hwSuuhHKadD2VfGGLneB
# 12T4wdYnhE4SEeINZ3YLXTs2F6pAaIM7Ge5yMdtpEU9EwtoF1pGP8ZL407Ty9bXU
# 6ooKxXiZuSjr+b7TSpw2TjpLWaSZ1fZA7w2ZgPxkYxKiHrA3xFuec/sEbI5oTEZm
# oxoGiZxqJT0vscSC7AE/ObHaBHSuIaGCFykwghclBgorBgEEAYI3AwMBMYIXFTCC
# FxEGCSqGSIb3DQEHAqCCFwIwghb+AgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFZBgsq
# hkiG9w0BCRABBKCCAUgEggFEMIIBQAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCC/CiBZt3O94AASUc3+ipaNaR6nLtyeYpLV4pBDOWyADwIGZjOrDSKq
# GBMyMDI0MDUxNjA2NDIxNC4wMDFaMASAAgH0oIHYpIHVMIHSMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQLEyRNaWNyb3NvZnQgSXJl
# bGFuZCBPcGVyYXRpb25zIExpbWl0ZWQxJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNO
# OjE3OUUtNEJCMC04MjQ2MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNloIIReDCCBycwggUPoAMCAQICEzMAAAHg1PwfExUffl0AAQAAAeAwDQYJ
# KoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwHhcNMjMx
# MDEyMTkwNzE5WhcNMjUwMTEwMTkwNzE5WjCB0jELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxhbmQgT3Bl
# cmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjoxNzlFLTRC
# QjAtODI0NjElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCC
# AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAKyHnPOhxbvRATnGjb/6fuBh
# h3ZLzotAxAgdLaZ/zkRFUdeSKzyNt3tqorMK7GDvcXdKs+qIMUbvenlH+w53ssPa
# 6rYP760ZuFrABrfserf0kFayNXVzwT7jarJOEjnFMBp+yi+uwQ2TnJuxczceG5FD
# HrII6sF6F879lP6ydY0BBZkZ9t39e/svNRieA5gUnv/YcM/bIMY/QYmd9F0B+ebF
# Yi+PH4AkXahNkFgK85OIaRrDGvhnxOa/5zGL7Oiii7+J9/QHkdJGlfnRfbQ3QXM/
# 5/umBOKG4JoFY1niZ5RVH5PT0+uCjwcqhTbnvUtfK+N+yB2b9rEZvp2Tv4ZwYzEd
# 9A9VsYMuZiCSbaFMk77LwVbklpnw4aHWJXJkEYmJvxRbcThE8FQyOoVkSuKc5OWZ
# 2+WM/j50oblA0tCU53AauvUOZRoQBh89nHK+m5pOXKXdYMJ+ceuLYF8h5y/cXLQM
# OmqLJz5l7MLqGwU0zHV+MEO8L1Fo2zEEQ4iL4BX8YknKXonHGQacSCaLZot2kyJV
# RsFSxn0PlPvHVp0YdsCMzdeiw9jAZ7K9s1WxsZGEBrK/obipX6uxjEpyUA9mbVPl
# jlb3R4MWI0E2xI/NM6F4Ac8Ceax3YWLT+aWCZeqiIMLxyyWZg+i1KY8ZEzMeNTKC
# EI5wF1wxqr6T1/MQo+8tAgMBAAGjggFJMIIBRTAdBgNVHQ4EFgQUcF4XP26dV+8S
# usoA1XXQ2TDSmdIwHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYD
# VR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9j
# cmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwG
# CCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIw
# MjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcD
# CDAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQADggIBAMATzg6R/A0ldO7M
# qGxD1VJji5yVA1hHb0Hc0Yjtv7WkxQ8iwfflulX5Us64tD3+3NT1JkphWzaAWf2w
# KdAw35RxtQG1iON3HEZ0X23nde4Kg/Wfbx5rEHkZ9bzKnR/2N5A16+w/1pbwJzdf
# RcnJT3cLyawr/kYjMWd63OP0Glq70ua4WUE/Po5pU7rQRbWEoQozY24hAqOcwuRc
# m6Cb0JBeTOCeRBntEKgjKep4pRaQt7b9vusT97WeJcfaVosmmPtsZsawgnpIjbBa
# 55tHfuk0vDkZtbIXjU4mr5dns9dnanBdBS2PY3N3hIfCPEOszquwHLkfkFZ/9bxw
# 8/eRJldtoukHo16afE/AqP/smmGJh5ZR0pmgW6QcX+61rdi5kDJTzCFaoMyYzUS0
# SEbyrDZ/p2KOuKAYNngljiOlllct0uJVz2agfczGjjsKi2AS1WaXvOhgZNmGw42S
# FB1qaloa8Kaux9Q2HHLE8gee/5rgOnx9zSbfVUc7IcRNodq6R7v+Rz+P6XKtOgyC
# qW/+rhPmp/n7Fq2BGTRkcy//hmS32p6qyglr2K4OoJDJXxFs6lwc8D86qlUeGjUy
# o7hVy5VvyA+y0mGnEAuA85tsOcUPlzwWF5sv+B5fz35OW3X4Spk5SiNulnLFRPM5
# XCsSHqvcbC8R3qwj2w1evPhZxDuNMIIHcTCCBVmgAwIBAgITMwAAABXF52ueAptJ
# mQAAAAAAFTANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
# Cldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29m
# dCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNh
# dGUgQXV0aG9yaXR5IDIwMTAwHhcNMjEwOTMwMTgyMjI1WhcNMzAwOTMwMTgzMjI1
# WjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDCCAiIwDQYJKoZIhvcNAQEB
# BQADggIPADCCAgoCggIBAOThpkzntHIhC3miy9ckeb0O1YLT/e6cBwfSqWxOdcjK
# NVf2AX9sSuDivbk+F2Az/1xPx2b3lVNxWuJ+Slr+uDZnhUYjDLWNE893MsAQGOhg
# fWpSg0S3po5GawcU88V29YZQ3MFEyHFcUTE3oAo4bo3t1w/YJlN8OWECesSq/XJp
# rx2rrPY2vjUmZNqYO7oaezOtgFt+jBAcnVL+tuhiJdxqD89d9P6OU8/W7IVWTe/d
# vI2k45GPsjksUZzpcGkNyjYtcI4xyDUoveO0hyTD4MmPfrVUj9z6BVWYbWg7mka9
# 7aSueik3rMvrg0XnRm7KMtXAhjBcTyziYrLNueKNiOSWrAFKu75xqRdbZ2De+JKR
# Hh09/SDPc31BmkZ1zcRfNN0Sidb9pSB9fvzZnkXftnIv231fgLrbqn427DZM9itu
# qBJR6L8FA6PRc6ZNN3SUHDSCD/AQ8rdHGO2n6Jl8P0zbr17C89XYcz1DTsEzOUyO
# ArxCaC4Q6oRRRuLRvWoYWmEBc8pnol7XKHYC4jMYctenIPDC+hIK12NvDMk2ZItb
# oKaDIV1fMHSRlJTYuVD5C4lh8zYGNRiER9vcG9H9stQcxWv2XFJRXRLbJbqvUAV6
# bMURHXLvjflSxIUXk8A8FdsaN8cIFRg/eKtFtvUeh17aj54WcmnGrnu3tz5q4i6t
# AgMBAAGjggHdMIIB2TASBgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQW
# BBQqp1L+ZMSavoKRPEY1Kc8Q/y8E7jAdBgNVHQ4EFgQUn6cVXQBeYl2D9OXSZacb
# UzUZ6XIwXAYDVR0gBFUwUzBRBgwrBgEEAYI3TIN9AQEwQTA/BggrBgEFBQcCARYz
# aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnku
# aHRtMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIA
# QwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFNX2
# VsuP6KJcYmjRPZSQW9fOmhjEMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwu
# bWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dF8yMDEw
# LTA2LTIzLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93
# d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYt
# MjMuY3J0MA0GCSqGSIb3DQEBCwUAA4ICAQCdVX38Kq3hLB9nATEkW+Geckv8qW/q
# XBS2Pk5HZHixBpOXPTEztTnXwnE2P9pkbHzQdTltuw8x5MKP+2zRoZQYIu7pZmc6
# U03dmLq2HnjYNi6cqYJWAAOwBb6J6Gngugnue99qb74py27YP0h1AdkY3m2CDPVt
# I1TkeFN1JFe53Z/zjj3G82jfZfakVqr3lbYoVSfQJL1AoL8ZthISEV09J+BAljis
# 9/kpicO8F7BUhUKz/AyeixmJ5/ALaoHCgRlCGVJ1ijbCHcNhcy4sa3tuPywJeBTp
# kbKpW99Jo3QMvOyRgNI95ko+ZjtPu4b6MhrZlvSP9pEB9s7GdP32THJvEKt1MMU0
# sHrYUP4KWN1APMdUbZ1jdEgssU5HLcEUBHG/ZPkkvnNtyo4JvbMBV0lUZNlz138e
# W0QBjloZkWsNn6Qo3GcZKCS6OEuabvshVGtqRRFHqfG3rsjoiV5PndLQTHa1V1QJ
# sWkBRH58oWFsc/4Ku+xBZj1p/cvBQUl+fpO+y/g75LcVv7TOPqUxUYS8vwLBgqJ7
# Fx0ViY1w/ue10CgaiQuPNtq6TPmb/wrpNPgkNWcr4A245oyZ1uEi6vAnQj0llOZ0
# dFtq0Z4+7X6gMTN9vMvpe784cETRkPHIqzqKOghif9lwY1NNje6CbaUFEMFxBmoQ
# tB1VM1izoXBm8qGCAtQwggI9AgEBMIIBAKGB2KSB1TCB0jELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxh
# bmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjox
# NzlFLTRCQjAtODI0NjElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vy
# dmljZaIjCgEBMAcGBSsOAwIaAxUAbfPR1fBX6HxYfyPx8zYzJU5fIQyggYMwgYCk
# fjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIF
# AOnv9IIwIhgPMjAyNDA1MTYxMDU3MDZaGA8yMDI0MDUxNzEwNTcwNlowdDA6Bgor
# BgEEAYRZCgQBMSwwKjAKAgUA6e/0ggIBADAHAgEAAgINZTAHAgEAAgISozAKAgUA
# 6fFGAgIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIBAAID
# B6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GBAGNc4u32nuIXgxHNYkcO
# 2JhScVkrRtgJY2+S/5AvC0pqv867my7BJTvEwCxcT1Cbmg7CqtM8ZjjTX4Hz2bRH
# KH/PDcQ1q5CgNKnH1v48ze0qiC10uL1q6557TRJL2kCJcuWSYFiNZFPjN8Ae7AMf
# ayMCOInnQzq1zVQ58dhbcHO+MYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgUENBIDIwMTACEzMAAAHg1PwfExUffl0AAQAAAeAwDQYJYIZIAWUDBAIB
# BQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0BCQQx
# IgQgkMxXCWCCta0w+L1PSOkR49HUjorrO1f4sOWW1izqvG8wgfoGCyqGSIb3DQEJ
# EAIvMYHqMIHnMIHkMIG9BCDj7lK/8jnlbTjPvc77DCCSb4TZApY9nJm5whsK/2kK
# wTCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAw
# DgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24x
# JjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAB4NT8
# HxMVH35dAAEAAAHgMCIEIBmv6hOpkdy42CPf1nZP66TBcGvnZwDhfckDfiFvOOm5
# MA0GCSqGSIb3DQEBCwUABIICAIRmZHKR6ytUZOyDYH/wMCPBqKRpFHz+TUyq9406
# hkJddFECmhawpnqFp1LTWxzEki0KhiqblUD0IfA9yCa4vaWR0hnttaRZk4plC7xp
# tVGmAXON+AfIkGis8/qLkCpa8MZTB3Jj1qQPaTuGtSFA+EB/ZnEs2rxchI082DxY
# ftt/EtxQuxcuuxJj0kKcGcCR6HAc4mMexkjRgoPA+mrXW/mJk8Su4ggINi7bOrUn
# AexpMGTFiVj7FaqofUzi6TB1P/XWFOqEBH0RHF08aSGOTGM/RYBkPGHANmxWBCYj
# ywLPZrviKNvirmT1ARt33W7sCSp0NxrFxMK8aImrBPPcARz2hDG2dlu1S/j6qGfI
# dYHyPpeolQ0JkY1ovYROYQX7Vg9XnxHHyz2v+VRbO5lIqSkvVHw3kXP8VPnaCxft
# zGk+KGpXJ07oGI/BwVuzV4H+7UiWiFwv8uXjwbKFjghRHLhhwGBmKo9gezSXZy9Y
# LCPImFDOn+XVxwn/UEYM2tNUQ6gN+4j0VI0uY+6AHqdZSDRFBrkfA1ZaZXLVaedG
# KIvhgPDQdOqMph+Agc8thWG2fj1i7jFPxQO0bizmgnpITN3e3oj5wXJsBPga/Vmu
# 1yOeYODhAB7vFZ7zuH/Ft0zZ83aXMTgJXWNNfz+BK7v3PSDSuDhU6kEBKa6W5yqZ
# 86st
# SIG # End signature block
