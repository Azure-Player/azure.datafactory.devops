
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
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
Lists entities from users or get entity from users by key
.Description
Lists entities from users or get entity from users by key
.Link
https://docs.microsoft.com/powershell/module/az.resources/get-azaduser
#>
function Get-AzADUser {
    [OutputType([Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphUser])]
    [CmdletBinding(DefaultParameterSetName='List', PositionalBinding=$false)]
    param(
        [Parameter(ParameterSetName='ObjectIdParameterSet', Mandatory)]
        [System.String]
        # key: id of user
        ${ObjectId},
    
        [Parameter(ParameterSetName='StartsWithParameterSet', Mandatory)]
        [System.String]
        [Alias('SearchString')]
        # user display name starts with
        ${StartsWith},
    
        [Parameter(ParameterSetName='DisplayNameParameterSet', Mandatory)]
        [System.String]
        # user display name
        ${DisplayName},
    
        [Parameter(ParameterSetName='UPNParameterSet', Mandatory)]
        [System.String]
        [Alias('UPN')]
        # user principal name
        ${UserPrincipalName},
    
        [Parameter(ParameterSetName='MailParameterSet', Mandatory)]
        [System.String]
        # user mail address
        ${Mail},

        [Parameter(ParameterSetName='SignedInUser', Mandatory)]
        [System.Management.Automation.SwitchParameter]
        # user mail address
        ${SignedIn},

        [Parameter()]
        [AllowEmptyCollection()]
        [System.String[]]
        # Expand related entities
        ${Expand},
    
        [Parameter()]
        [AllowEmptyCollection()]
        [System.String[]]
        # Select properties to be returned
        ${Select},

        [Parameter(ParameterSetName='List')]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Query')]
        [System.Management.Automation.SwitchParameter]
        # Include count of items
        ${Count},
    
        [Parameter(ParameterSetName='List')]
        [Parameter(ParameterSetName='StartsWithParameterSet')]
        [Parameter(ParameterSetName='DisplayNameParameterSet')]
        [Parameter(ParameterSetName='MailParameterSet')]
        [System.UInt64]
        # Gets only the first 'n' objects.
        ${First},
    
        [Parameter(ParameterSetName='List')]
        [Parameter(ParameterSetName='StartsWithParameterSet')]
        [Parameter(ParameterSetName='DisplayNameParameterSet')]
        [Parameter(ParameterSetName='MailParameterSet')]
        [System.UInt64]
        # Ignores the first 'n' objects and then gets the remaining objects.
        ${Skip},

        [Parameter(HelpMessage = "Append properties selected with default properties when this switch is on, only works with parameter '-Select'.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        ${AppendSelected},
    
        [Parameter(ParameterSetName='List')]
        [System.String]
        # Filter items by property values, for more detail about filter query please see: https://learn.microsoft.com/en-us/graph/filter-query-parameter
        ${Filter},
    
        [Parameter(ParameterSetName='List')]
        [AllowEmptyCollection()]
        [System.String[]]
        # Order items by property values
        ${Orderby},
    
        [Parameter(ParameterSetName='List')]
        [System.String]
        # Search items by search phrases
        ${Search},
    
        [Parameter(ParameterSetName='List')]
        [System.String]
        # Indicates the requested consistency level.
        # Documentation URL: https://developer.microsoft.com/en-us/office/blogs/microsoft-graph-advanced-queries-for-directory-objects-are-now-generally-available/
        ${ConsistencyLevel},
    
        [Parameter()]
        [Alias("AzContext", "AzureRmContext", "AzureCredential")]
        [ValidateNotNull()]
        [System.Management.Automation.PSObject]
        # The credentials, account, tenant, and subscription used for communication with Azure.
        ${DefaultProfile},
    
        [Parameter(DontShow)]
        [System.Management.Automation.SwitchParameter]
        # Wait for .NET debugger to attach
        ${Break},
    
        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be appended to the front of the pipeline
        ${HttpPipelineAppend},
    
        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be prepended to the front of the pipeline
        ${HttpPipelinePrepend},
    
        [Parameter(DontShow)]
        [System.Uri]
        # The URI for the proxy server to use
        ${Proxy},
    
        [Parameter(DontShow)]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        # Credentials for a proxy server to use for the remote call
        ${ProxyCredential},
    
        [Parameter(DontShow)]
        [System.Management.Automation.SwitchParameter]
        # Use the default credentials for the proxy
        ${ProxyUseDefaultCredentials}
    )
    
    process {
        if ($PSBoundParameters['AppendSelected'] -and $PSBoundParameters['Select']) {
            $PSBoundParameters['Select'] += @('DisplayName', 'Id', 'DeletedDateTime', 'UserPrincipalName', 'UsageLocation', 'GivenName', 'SurName', 'AccountEnabled', 'MailNickName', 'Mail')
            $null = $PSBoundParameters.Remove('AppendSelected')
        }

        if('SignedInUser' -eq $PSCmdlet.ParameterSetName) {
            $null = $PSBoundParameters.Remove('SignedIn')
            Az.MSGraph.private\Get-AzADUserSigned_Get @PSBoundParameters
            return
        }

        switch ($PSCmdlet.ParameterSetName) {
            'ObjectIdParameterSet' {
                $PSBOundParameters['UserId'] = $PSBOundParameters['ObjectId']
                $null = $PSBoundParameters.Remove('ObjectId')
                break
            }
            'StartsWithParameterSet' {
                $PSBOundParameters['Filter'] = "startsWith(DisplayName, '$($PSBOundParameters['StartsWith'])')"
                $null = $PSBoundParameters.Remove('StartsWith')
                break
            }
            'DisplayNameParameterSet' {
                $PSBOundParameters['Filter'] = "displayName eq '$($PSBOundParameters['DisplayName'])'"
                $null = $PSBoundParameters.Remove('DisplayName')
                break
            }
            'UPNParameterSet' {
                $PSBOundParameters['Filter'] = "userPrincipalName eq '$($PSBOundParameters['UserPrincipalName'])'"
                $null = $PSBoundParameters.Remove('UserPrincipalName')
                break
            }
            'MailParameterSet' {
                $PSBOundParameters['Filter'] = "mail eq '$($PSBOundParameters['Mail'])'"
                $null = $PSBoundParameters.Remove('Mail')
                break
            }
            default {
                break
            }
        }

        Az.MSGraph.internal\Get-AzADUser @PSBoundParameters
    }
}
    
# SIG # Begin signature block
# MIInrQYJKoZIhvcNAQcCoIInnjCCJ5oCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDFju+PM3Aip7O1
# lpYpb/AJJbHVQvwK06TC3K0kJEgrDaCCDYEwggX/MIID56ADAgECAhMzAAACzI61
# lqa90clOAAAAAALMMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjIwNTEyMjA0NjAxWhcNMjMwNTExMjA0NjAxWjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQCiTbHs68bADvNud97NzcdP0zh0mRr4VpDv68KobjQFybVAuVgiINf9aG2zQtWK
# No6+2X2Ix65KGcBXuZyEi0oBUAAGnIe5O5q/Y0Ij0WwDyMWaVad2Te4r1Eic3HWH
# UfiiNjF0ETHKg3qa7DCyUqwsR9q5SaXuHlYCwM+m59Nl3jKnYnKLLfzhl13wImV9
# DF8N76ANkRyK6BYoc9I6hHF2MCTQYWbQ4fXgzKhgzj4zeabWgfu+ZJCiFLkogvc0
# RVb0x3DtyxMbl/3e45Eu+sn/x6EVwbJZVvtQYcmdGF1yAYht+JnNmWwAxL8MgHMz
# xEcoY1Q1JtstiY3+u3ulGMvhAgMBAAGjggF+MIIBejAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUiLhHjTKWzIqVIp+sM2rOHH11rfQw
# UAYDVR0RBEkwR6RFMEMxKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVyYXRpb25zIFB1
# ZXJ0byBSaWNvMRYwFAYDVQQFEw0yMzAwMTIrNDcwNTI5MB8GA1UdIwQYMBaAFEhu
# ZOVQBdOCqhc3NyK1bajKdQKVMFQGA1UdHwRNMEswSaBHoEWGQ2h0dHA6Ly93d3cu
# bWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY0NvZFNpZ1BDQTIwMTFfMjAxMS0w
# Ny0wOC5jcmwwYQYIKwYBBQUHAQEEVTBTMFEGCCsGAQUFBzAChkVodHRwOi8vd3d3
# Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRzL01pY0NvZFNpZ1BDQTIwMTFfMjAx
# MS0wNy0wOC5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQsFAAOCAgEAeA8D
# sOAHS53MTIHYu8bbXrO6yQtRD6JfyMWeXaLu3Nc8PDnFc1efYq/F3MGx/aiwNbcs
# J2MU7BKNWTP5JQVBA2GNIeR3mScXqnOsv1XqXPvZeISDVWLaBQzceItdIwgo6B13
# vxlkkSYMvB0Dr3Yw7/W9U4Wk5K/RDOnIGvmKqKi3AwyxlV1mpefy729FKaWT7edB
# d3I4+hldMY8sdfDPjWRtJzjMjXZs41OUOwtHccPazjjC7KndzvZHx/0VWL8n0NT/
# 404vftnXKifMZkS4p2sB3oK+6kCcsyWsgS/3eYGw1Fe4MOnin1RhgrW1rHPODJTG
# AUOmW4wc3Q6KKr2zve7sMDZe9tfylonPwhk971rX8qGw6LkrGFv31IJeJSe/aUbG
# dUDPkbrABbVvPElgoj5eP3REqx5jdfkQw7tOdWkhn0jDUh2uQen9Atj3RkJyHuR0
# GUsJVMWFJdkIO/gFwzoOGlHNsmxvpANV86/1qgb1oZXdrURpzJp53MsDaBY/pxOc
# J0Cvg6uWs3kQWgKk5aBzvsX95BzdItHTpVMtVPW4q41XEvbFmUP1n6oL5rdNdrTM
# j/HXMRk1KCksax1Vxo3qv+13cCsZAaQNaIAvt5LvkshZkDZIP//0Hnq7NnWeYR3z
# 4oFiw9N2n3bb9baQWuWPswG0Dq9YT9kb+Cs4qIIwggd6MIIFYqADAgECAgphDpDS
# AAAAAAADMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMK
# V2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
# IENvcnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0
# ZSBBdXRob3JpdHkgMjAxMTAeFw0xMTA3MDgyMDU5MDlaFw0yNjA3MDgyMTA5MDla
# MH4xCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMT
# H01pY3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTEwggIiMA0GCSqGSIb3DQEB
# AQUAA4ICDwAwggIKAoICAQCr8PpyEBwurdhuqoIQTTS68rZYIZ9CGypr6VpQqrgG
# OBoESbp/wwwe3TdrxhLYC/A4wpkGsMg51QEUMULTiQ15ZId+lGAkbK+eSZzpaF7S
# 35tTsgosw6/ZqSuuegmv15ZZymAaBelmdugyUiYSL+erCFDPs0S3XdjELgN1q2jz
# y23zOlyhFvRGuuA4ZKxuZDV4pqBjDy3TQJP4494HDdVceaVJKecNvqATd76UPe/7
# 4ytaEB9NViiienLgEjq3SV7Y7e1DkYPZe7J7hhvZPrGMXeiJT4Qa8qEvWeSQOy2u
# M1jFtz7+MtOzAz2xsq+SOH7SnYAs9U5WkSE1JcM5bmR/U7qcD60ZI4TL9LoDho33
# X/DQUr+MlIe8wCF0JV8YKLbMJyg4JZg5SjbPfLGSrhwjp6lm7GEfauEoSZ1fiOIl
# XdMhSz5SxLVXPyQD8NF6Wy/VI+NwXQ9RRnez+ADhvKwCgl/bwBWzvRvUVUvnOaEP
# 6SNJvBi4RHxF5MHDcnrgcuck379GmcXvwhxX24ON7E1JMKerjt/sW5+v/N2wZuLB
# l4F77dbtS+dJKacTKKanfWeA5opieF+yL4TXV5xcv3coKPHtbcMojyyPQDdPweGF
# RInECUzF1KVDL3SV9274eCBYLBNdYJWaPk8zhNqwiBfenk70lrC8RqBsmNLg1oiM
# CwIDAQABo4IB7TCCAekwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFEhuZOVQ
# BdOCqhc3NyK1bajKdQKVMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1Ud
# DwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFHItOgIxkEO5FAVO
# 4eqnxzHRI4k0MFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwubWljcm9zb2Z0
# LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dDIwMTFfMjAxMV8wM18y
# Mi5jcmwwXgYIKwYBBQUHAQEEUjBQME4GCCsGAQUFBzAChkJodHRwOi8vd3d3Lm1p
# Y3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0NlckF1dDIwMTFfMjAxMV8wM18y
# Mi5jcnQwgZ8GA1UdIASBlzCBlDCBkQYJKwYBBAGCNy4DMIGDMD8GCCsGAQUFBwIB
# FjNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2RvY3MvcHJpbWFyeWNw
# cy5odG0wQAYIKwYBBQUHAgIwNB4yIB0ATABlAGcAYQBsAF8AcABvAGwAaQBjAHkA
# XwBzAHQAYQB0AGUAbQBlAG4AdAAuIB0wDQYJKoZIhvcNAQELBQADggIBAGfyhqWY
# 4FR5Gi7T2HRnIpsLlhHhY5KZQpZ90nkMkMFlXy4sPvjDctFtg/6+P+gKyju/R6mj
# 82nbY78iNaWXXWWEkH2LRlBV2AySfNIaSxzzPEKLUtCw/WvjPgcuKZvmPRul1LUd
# d5Q54ulkyUQ9eHoj8xN9ppB0g430yyYCRirCihC7pKkFDJvtaPpoLpWgKj8qa1hJ
# Yx8JaW5amJbkg/TAj/NGK978O9C9Ne9uJa7lryft0N3zDq+ZKJeYTQ49C/IIidYf
# wzIY4vDFLc5bnrRJOQrGCsLGra7lstnbFYhRRVg4MnEnGn+x9Cf43iw6IGmYslmJ
# aG5vp7d0w0AFBqYBKig+gj8TTWYLwLNN9eGPfxxvFX1Fp3blQCplo8NdUmKGwx1j
# NpeG39rz+PIWoZon4c2ll9DuXWNB41sHnIc+BncG0QaxdR8UvmFhtfDcxhsEvt9B
# xw4o7t5lL+yX9qFcltgA1qFGvVnzl6UJS0gQmYAf0AApxbGbpT9Fdx41xtKiop96
# eiL6SJUfq/tHI4D1nvi/a7dLl+LrdXga7Oo3mXkYS//WsyNodeav+vyL6wuA6mk7
# r/ww7QRMjt/fdW1jkT3RnVZOT7+AVyKheBEyIXrvQQqxP/uozKRdwaGIm1dxVk5I
# RcBCyZt2WwqASGv9eZ/BvW1taslScxMNelDNMYIZgjCCGX4CAQEwgZUwfjELMAkG
# A1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQx
# HjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEoMCYGA1UEAxMfTWljcm9z
# b2Z0IENvZGUgU2lnbmluZyBQQ0EgMjAxMQITMwAAAsyOtZamvdHJTgAAAAACzDAN
# BglghkgBZQMEAgEFAKCBrjAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgor
# BgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgb5ZSaf5p
# FYpE/2NSTJLukOOvszGDhPxZj3c7pFegz8cwQgYKKwYBBAGCNwIBDDE0MDKgFIAS
# AE0AaQBjAHIAbwBzAG8AZgB0oRqAGGh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbTAN
# BgkqhkiG9w0BAQEFAASCAQA6ParZ4M4jm24WpgZf8AFoCdC9e9icf4gCSvtNHiJM
# JUIFYV8eCVvYQ5gPAHO5PNscFC+dcKT6DlBzZgHhAICJvERreBBcVMDo4AedQD0g
# GI7B3wZDuX0ceOzKYH527ca4SFXL6OAm8a3cU3zn4t4rN2KXy7BTmI4a958Tx2Ar
# fak/RCGha9YlJW8wwMNUIu88Rii2DJf61K/9dNYRpwYLwL2LJQekitGwonhqhjgf
# rkTV7DXYd3BJnnY7kAINku/uQJGjocJethBV+yySJsvTSb9fLR3JOmZrySyZ0JOE
# Y+BGGSyDF733jrnq/33q7rpuOw2ikA2GgB3zocOi/vJ7oYIXDDCCFwgGCisGAQQB
# gjcDAwExghb4MIIW9AYJKoZIhvcNAQcCoIIW5TCCFuECAQMxDzANBglghkgBZQME
# AgEFADCCAVUGCyqGSIb3DQEJEAEEoIIBRASCAUAwggE8AgEBBgorBgEEAYRZCgMB
# MDEwDQYJYIZIAWUDBAIBBQAEILqWqgTCZZqOkELwVs0ktp8IgT8S9bWWNsY64KgX
# HUFvAgZjc5/BjOUYEzIwMjIxMTE3MTMzNzI2LjUwMVowBIACAfSggdSkgdEwgc4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsTIE1p
# Y3Jvc29mdCBPcGVyYXRpb25zIFB1ZXJ0byBSaWNvMSYwJAYDVQQLEx1UaGFsZXMg
# VFNTIEVTTjo2MEJDLUUzODMtMjYzNTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgU2VydmljZaCCEV8wggcQMIIE+KADAgECAhMzAAABpllFgzlNnutLAAEA
# AAGmMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEw
# MB4XDTIyMDMwMjE4NTEyMVoXDTIzMDUxMTE4NTEyMVowgc4xCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVy
# YXRpb25zIFB1ZXJ0byBSaWNvMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjo2MEJD
# LUUzODMtMjYzNTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vydmlj
# ZTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANmYv3tSI+fJ/NQJnjz7
# JvCnc+Xm0rKoe9YKD4MvMYCul7egdrT/zv5vFbQgjNQ74672fNweaztkR65V8y29
# u5PL2sf01p+uche0Zu4tSig+GsQ6ZQl9tjPRAY/3ITBHDeIYyvq8Wne9+7NoPLhx
# DSO6dtX7YCuQ4zcTP3SE6MvB4b5NighdtvoZVaYk1lXpjUTfdmKoX1ABq1sJbULS
# nSi0Qd4vvl3mZ9jxwv9dR/nlZP62lrZYZq7LPtHD6BlmclB5PT89DnSm1sjaZnFH
# rKzOsmq5GlmL5SFugCCZOoKz133FJeQaFMcXBZSCQjNABWBbHIRCE1ysHHG83Ddo
# nRmnC8EOlYeRwTWz/QCz6q0riOIbYyC/A2BgUEpu9/9EymrTsyMr2/zS8GdEybQ5
# W7f0WrcrmKB/Y62+g6TmfOS8NtU+L1jGoKNG6Q5RlfJwZu8J/Q9dl4OxyHKuy78+
# wm6HsF7uAizpsWh63UUaoK/OGQiBG3NJ+kef5eWpnva4ZJfhAnqYTAZD1uHgf8Vf
# Qjnl0BB2YXzK9WaTqde8d+8qCxVKr5hJYvbO+X3+2k5PCirUK/SboreX+xUhVaQE
# hVDYqlatyPttI7Z2IrkhMzwFvc+p0QeyMiNmo2cBZejx8icDOcUidwymDUYqGPE7
# MA8vtKW3feeSSYJsCEkuUO/vAgMBAAGjggE2MIIBMjAdBgNVHQ4EFgQUOlQhO/zG
# lqK99UkNL/Gu/AryN9gwHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIw
# XwYDVR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9w
# cy9jcmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3Js
# MGwGCCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3Nv
# ZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENB
# JTIwMjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADATBgNVHSUEDDAKBggrBgEFBQcD
# CDANBgkqhkiG9w0BAQsFAAOCAgEAgMDxWDTpGqLnFoPhm/iDfwHGF8xr2NbrJl8e
# gEg2ThTJsTf0wBE+ZQsnYfrRmXBbe6sCXLVN70qPuI+OEbN5MOai7Bue1/4j5VTk
# WquH5GZeVat2N+dD7lSUWp0dU8j+uBhBL5GFSmoDVVm+zW2GR2juPI1v254AJTb2
# l458anlkJjGvmYn2BtRS13h/wDR7hrQaI7BgdyHWAV5+HEj5UhrIrrvtwJiivSaU
# EA3qK6ZK/rZIQv/uORDkONw+2pHHIE1SXm/WIlhrVS2HIogfr3JjqvZion6LJSD7
# 41j8xVDLiClwAbspHoVFjxtxBcMjqPx6aWCJS8vjSoTnhkV4PO55mqsM7Q8XQRGQ
# hA7w4zNQOJu9kD4xFdYpPUmLN/daIcEElofBjGz+sEd1B4yqqIk3u2G4VygTXFmt
# hL8chSo7r+GIvTqWKhSA/sanS4N3jCgCCe3FTSJsp4g5nwavLvWAtzcOIvSRorGm
# AeN0m2wgzBK95T/qgrGGDXSos1JNDWRVBnP0qsw1Qoq5G0D8hxvQPs3X43KBv1GJ
# l0wo5rcC+9OMWxJlB63gtToQsA1CErYoYLMZtUzJL74jwZk/grpHEQhIhB3sneC8
# wzGKJuft7YO/HWCpuwdChIjynTnBh+yFGMdg3wRrIbOcw/iKmXZopMTQMOcmIeIw
# JAezA7AwggdxMIIFWaADAgECAhMzAAAAFcXna54Cm0mZAAAAAAAVMA0GCSqGSIb3
# DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
# A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTIw
# MAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkgMjAx
# MDAeFw0yMTA5MzAxODIyMjVaFw0zMDA5MzAxODMyMjVaMHwxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1l
# LVN0YW1wIFBDQSAyMDEwMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA
# 5OGmTOe0ciELeaLL1yR5vQ7VgtP97pwHB9KpbE51yMo1V/YBf2xK4OK9uT4XYDP/
# XE/HZveVU3Fa4n5KWv64NmeFRiMMtY0Tz3cywBAY6GB9alKDRLemjkZrBxTzxXb1
# hlDcwUTIcVxRMTegCjhuje3XD9gmU3w5YQJ6xKr9cmmvHaus9ja+NSZk2pg7uhp7
# M62AW36MEBydUv626GIl3GoPz130/o5Tz9bshVZN7928jaTjkY+yOSxRnOlwaQ3K
# Ni1wjjHINSi947SHJMPgyY9+tVSP3PoFVZhtaDuaRr3tpK56KTesy+uDRedGbsoy
# 1cCGMFxPLOJiss254o2I5JasAUq7vnGpF1tnYN74kpEeHT39IM9zfUGaRnXNxF80
# 3RKJ1v2lIH1+/NmeRd+2ci/bfV+AutuqfjbsNkz2K26oElHovwUDo9Fzpk03dJQc
# NIIP8BDyt0cY7afomXw/TNuvXsLz1dhzPUNOwTM5TI4CvEJoLhDqhFFG4tG9ahha
# YQFzymeiXtcodgLiMxhy16cg8ML6EgrXY28MyTZki1ugpoMhXV8wdJGUlNi5UPkL
# iWHzNgY1GIRH29wb0f2y1BzFa/ZcUlFdEtsluq9QBXpsxREdcu+N+VLEhReTwDwV
# 2xo3xwgVGD94q0W29R6HXtqPnhZyacaue7e3PmriLq0CAwEAAaOCAd0wggHZMBIG
# CSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFCqnUv5kxJq+gpE8RjUp
# zxD/LwTuMB0GA1UdDgQWBBSfpxVdAF5iXYP05dJlpxtTNRnpcjBcBgNVHSAEVTBT
# MFEGDCsGAQQBgjdMg30BATBBMD8GCCsGAQUFBwIBFjNodHRwOi8vd3d3Lm1pY3Jv
# c29mdC5jb20vcGtpb3BzL0RvY3MvUmVwb3NpdG9yeS5odG0wEwYDVR0lBAwwCgYI
# KwYBBQUHAwgwGQYJKwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGG
# MA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAU1fZWy4/oolxiaNE9lJBb186a
# GMQwVgYDVR0fBE8wTTBLoEmgR4ZFaHR0cDovL2NybC5taWNyb3NvZnQuY29tL3Br
# aS9jcmwvcHJvZHVjdHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3JsMFoGCCsG
# AQUFBwEBBE4wTDBKBggrBgEFBQcwAoY+aHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L3BraS9jZXJ0cy9NaWNSb29DZXJBdXRfMjAxMC0wNi0yMy5jcnQwDQYJKoZIhvcN
# AQELBQADggIBAJ1VffwqreEsH2cBMSRb4Z5yS/ypb+pcFLY+TkdkeLEGk5c9MTO1
# OdfCcTY/2mRsfNB1OW27DzHkwo/7bNGhlBgi7ulmZzpTTd2YurYeeNg2LpypglYA
# A7AFvonoaeC6Ce5732pvvinLbtg/SHUB2RjebYIM9W0jVOR4U3UkV7ndn/OOPcbz
# aN9l9qRWqveVtihVJ9AkvUCgvxm2EhIRXT0n4ECWOKz3+SmJw7wXsFSFQrP8DJ6L
# GYnn8AtqgcKBGUIZUnWKNsIdw2FzLixre24/LAl4FOmRsqlb30mjdAy87JGA0j3m
# Sj5mO0+7hvoyGtmW9I/2kQH2zsZ0/fZMcm8Qq3UwxTSwethQ/gpY3UA8x1RtnWN0
# SCyxTkctwRQEcb9k+SS+c23Kjgm9swFXSVRk2XPXfx5bRAGOWhmRaw2fpCjcZxko
# JLo4S5pu+yFUa2pFEUep8beuyOiJXk+d0tBMdrVXVAmxaQFEfnyhYWxz/gq77EFm
# PWn9y8FBSX5+k77L+DvktxW/tM4+pTFRhLy/AsGConsXHRWJjXD+57XQKBqJC482
# 2rpM+Zv/Cuk0+CQ1ZyvgDbjmjJnW4SLq8CdCPSWU5nR0W2rRnj7tfqAxM328y+l7
# vzhwRNGQ8cirOoo6CGJ/2XBjU02N7oJtpQUQwXEGahC0HVUzWLOhcGbyoYIC0jCC
# AjsCAQEwgfyhgdSkgdEwgc4xCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
# dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9y
# YXRpb24xKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVyYXRpb25zIFB1ZXJ0byBSaWNv
# MSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjo2MEJDLUUzODMtMjYzNTElMCMGA1UE
# AxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaIjCgEBMAcGBSsOAwIaAxUA
# anQzrZW9TB93Ve7Pa4UPao2ffK2ggYMwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEG
# A1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWlj
# cm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFt
# cCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIFAOcgGHYwIhgPMjAyMjExMTcwNjE4
# MzBaGA8yMDIyMTExODA2MTgzMFowdzA9BgorBgEEAYRZCgQBMS8wLTAKAgUA5yAY
# dgIBADAKAgEAAgIhswIB/zAHAgEAAgIRADAKAgUA5yFp9gIBADA2BgorBgEEAYRZ
# CgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIBAAIDB6EgoQowCAIBAAIDAYagMA0G
# CSqGSIb3DQEBBQUAA4GBAJtsIwdeZK9/YoDF/KTvAczIfTVo/pCA2Sd0ZoZ77pMD
# YyYZcrbpE5EH2pwDdGVITbpPJsljg8TZhCtBc7Zy2Q2RmtVGFsyHekuxAp58PYpd
# XeCzEfK4Qxv55I3UmVmFj4vW9d0nI/3ry+6/kQJTrjj9ZnYH4k7+o7FOP0najKOZ
# MYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMA
# AAGmWUWDOU2e60sAAQAAAaYwDQYJYIZIAWUDBAIBBQCgggFKMBoGCSqGSIb3DQEJ
# AzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0BCQQxIgQgAnUmJ0L1F0ILiUeKB1J5
# VVmwbb/My1XvQYdcBC2+6KIwgfoGCyqGSIb3DQEJEAIvMYHqMIHnMIHkMIG9BCCD
# CxmLwz90fWvhMKbJTAQaKt3DoXeiAhfp8TD9tgSrDTCBmDCBgKR+MHwxCzAJBgNV
# BAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4w
# HAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29m
# dCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAABpllFgzlNnutLAAEAAAGmMCIEINEw
# 0vu6JdQzA0pcgIznKN4lesgIl2N9rswhDzzfPVPlMA0GCSqGSIb3DQEBCwUABIIC
# ALfbxHYOBNNXetYlW78KxMTjaqArEp9xB24Xc4w0kGXT1jW0jkzbGKTe86Gt+HYp
# B5C3lVDnfgRO4LDUgbwOsQxhqugJJUSB6pry8yA5MX3n5lTOEUfdEs5GcUCEjcvY
# YITqaZDoruyYHA6/Lza8PIIhyuBKJFtd1O6o6AJ2TCH7XdVV6uJaDzY5b5sTFgxG
# wpxdF0O+hpT0oGj1xtts5YjrJv2N2EqfHOGiBh4jdyc0Q8kAwaZHB8R3kXaGTuis
# sww6BjPFnPD3e2Ys9D47VQFqB3kiLCZTfin6GPRqUFlf1fJmdimuYMV6BWFMUMz2
# HmC9mcKHpVGdNATSYsn4rba96ziJWr1xA8XsOMCijesVd8tr/9dO4Kso9dfIq5XK
# bJf4AcH1BAzVdAbjxA1waNAJUKaDL9bnAOED5uWF2Z5t0qiiunnluEAs6hG8KCaW
# 4xjpZkCHifULKnzelZmDvL96/Sm+gzM9TQrlP7Hi/gzuX6fGAMdjXUKorc931xWf
# Kxw7GcibeehhEfTgL9trr+fOFw5iAU5hWgLJ0b1siQVFeAQQ0B6sgDcbRcJWRCOQ
# QZ9WUt2SK/tVagiDpcj2atAIJgqlTH97Z+9rMv5okhz+ytNuBI8RkabCbn6vMxff
# 6NJIjLib6fIu6hWjRp9zVIy4KWcPjC6XQi4Zp5GYUMjl
# SIG # End signature block
