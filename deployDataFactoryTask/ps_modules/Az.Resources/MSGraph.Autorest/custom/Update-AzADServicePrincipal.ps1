
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
Updates entity in service principal
.Description
Updates entity in service principal
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

ADDIN <IMicrosoftGraphAddIn[]>: Defines custom behavior that a consuming service can use to call an app in specific contexts. For example, applications that can render file streams may set the addIns property for its 'FileHandler' functionality. This will let services like Microsoft 365 call the application in the context of a document the user is working on.
  [Id <String>]: 
  [Property <IMicrosoftGraphKeyValue[]>]: 
    [Key <String>]: Key.
    [Value <String>]: Value.
  [Type <String>]: 

APPROLE <IMicrosoftGraphAppRole[]>: The roles exposed by the application which this service principal represents. For more information see the appRoles property definition on the application entity. Not nullable.
  [AllowedMemberType <String[]>]: Specifies whether this app role can be assigned to users and groups (by setting to ['User']), to other application's (by setting to ['Application'], or both (by setting to ['User', 'Application']). App roles supporting assignment to other applications' service principals are also known as application permissions. The 'Application' value is only supported for app roles defined on application entities.
  [Description <String>]: The description for the app role. This is displayed when the app role is being assigned and, if the app role functions as an application permission, during  consent experiences.
  [DisplayName <String>]: Display name for the permission that appears in the app role assignment and consent experiences.
  [Id <String>]: Unique role identifier inside the appRoles collection. When creating a new app role, a new Guid identifier must be provided.
  [IsEnabled <Boolean?>]: When creating or updating an app role, this must be set to true (which is the default). To delete a role, this must first be set to false.  At that point, in a subsequent call, this role may be removed.
  [Origin <String>]: Specifies if the app role is defined on the application object or on the servicePrincipal entity. Must not be included in any POST or PATCH requests. Read-only.
  [Value <String>]: Specifies the value to include in the roles claim in ID tokens and access tokens authenticating an assigned user or service principal. Must not exceed 120 characters in length. Allowed characters are : ! # $ % & ' ( ) * + , - . / : ;  =  ? @ [ ] ^ + _  {  } ~, as well as characters in the ranges 0-9, A-Z and a-z. Any other character, including the space character, are not allowed. May not begin with ..

APPROLEASSIGNEDTO <IMicrosoftGraphAppRoleAssignment[]>: App role assignments for this app or service, granted to users, groups, and other service principals.Supports $expand.
  [DeletedDateTime <DateTime?>]: 
  [AppRoleId <String>]: The identifier (id) for the app role which is assigned to the principal. This app role must be exposed in the appRoles property on the resource application's service principal (resourceId). If the resource application has not declared any app roles, a default app role ID of 00000000-0000-0000-0000-000000000000 can be specified to signal that the principal is assigned to the resource app without any specific app roles. Required on create.
  [PrincipalId <String>]: The unique identifier (id) for the user, group or service principal being granted the app role. Required on create.
  [ResourceDisplayName <String>]: The display name of the resource app's service principal to which the assignment is made.
  [ResourceId <String>]: The unique identifier (id) for the resource service principal for which the assignment is made. Required on create. Supports $filter (eq only).

APPROLEASSIGNMENT <IMicrosoftGraphAppRoleAssignment[]>: App role assignment for another app or service, granted to this service principal. Supports $expand.
  [DeletedDateTime <DateTime?>]: 
  [AppRoleId <String>]: The identifier (id) for the app role which is assigned to the principal. This app role must be exposed in the appRoles property on the resource application's service principal (resourceId). If the resource application has not declared any app roles, a default app role ID of 00000000-0000-0000-0000-000000000000 can be specified to signal that the principal is assigned to the resource app without any specific app roles. Required on create.
  [PrincipalId <String>]: The unique identifier (id) for the user, group or service principal being granted the app role. Required on create.
  [ResourceDisplayName <String>]: The display name of the resource app's service principal to which the assignment is made.
  [ResourceId <String>]: The unique identifier (id) for the resource service principal for which the assignment is made. Required on create. Supports $filter (eq only).

CLAIMSMAPPINGPOLICY <IMicrosoftGraphClaimsMappingPolicy[]>: The claimsMappingPolicies assigned to this service principal. Supports $expand.
  [AppliesTo <IMicrosoftGraphDirectoryObject[]>]: 
    [DeletedDateTime <DateTime?>]: 
  [Definition <String[]>]: A string collection containing a JSON string that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required.
  [IsOrganizationDefault <Boolean?>]: If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false.
  [Description <String>]: Description for this policy.
  [DisplayName <String>]: Display name for this policy.
  [DeletedDateTime <DateTime?>]: 

DELEGATEDPERMISSIONCLASSIFICATION <IMicrosoftGraphDelegatedPermissionClassification[]>: The permission classifications for delegated permissions exposed by the app that this service principal represents. Supports $expand.
  [Classification <String>]: permissionClassificationType
  [PermissionId <String>]: The unique identifier (id) for the delegated permission listed in the publishedPermissionScopes collection of the servicePrincipal. Required on create. Does not support $filter.
  [PermissionName <String>]: The claim value (value) for the delegated permission listed in the publishedPermissionScopes collection of the servicePrincipal. Does not support $filter.

ENDPOINT <IMicrosoftGraphEndpoint[]>: Endpoints available for discovery. Services like Sharepoint populate this property with a tenant specific SharePoint endpoints that other applications can discover and use in their experiences.
  [DeletedDateTime <DateTime?>]: 
  [Capability <String>]: Describes the capability that is associated with this resource. (e.g. Messages, Conversations, etc.)  Not nullable. Read-only.
  [ProviderId <String>]: Application id of the publishing underlying service. Not nullable. Read-only.
  [ProviderName <String>]: Name of the publishing underlying service. Read-only.
  [ProviderResourceId <String>]: For Microsoft 365 groups, this is set to a well-known name for the resource (e.g. Yammer.FeedURL etc.). Not nullable. Read-only.
  [Uri <String>]: URL of the published resource. Not nullable. Read-only.

HOMEREALMDISCOVERYPOLICY <IMicrosoftGraphHomeRealmDiscoveryPolicy[]>: The homeRealmDiscoveryPolicies assigned to this service principal. Supports $expand.
  [AppliesTo <IMicrosoftGraphDirectoryObject[]>]: 
    [DeletedDateTime <DateTime?>]: 
  [Definition <String[]>]: A string collection containing a JSON string that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required.
  [IsOrganizationDefault <Boolean?>]: If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false.
  [Description <String>]: Description for this policy.
  [DisplayName <String>]: Display name for this policy.
  [DeletedDateTime <DateTime?>]: 

INFO <IMicrosoftGraphInformationalUrl>: informationalUrl
  [(Any) <Object>]: This indicates any property can be added to this object.
  [LogoUrl <String>]: CDN URL to the application's logo, Read-only.
  [MarketingUrl <String>]: Link to the application's marketing page. For example, https://www.contoso.com/app/marketing
  [PrivacyStatementUrl <String>]: Link to the application's privacy statement. For example, https://www.contoso.com/app/privacy
  [SupportUrl <String>]: Link to the application's support page. For example, https://www.contoso.com/app/support
  [TermsOfServiceUrl <String>]: Link to the application's terms of service statement. For example, https://www.contoso.com/app/termsofservice

KEYCREDENTIALS <IMicrosoftGraphKeyCredential[]>: The collection of key credentials associated with the service principal. Not nullable. Supports $filter (eq, NOT, ge, le).
  [CustomKeyIdentifier <Byte[]>]: Custom key identifier
  [DisplayName <String>]: Friendly name for the key. Optional.
  [EndDateTime <DateTime?>]: The date and time at which the credential expires.The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
  [Key <Byte[]>]: Value for the key credential. Should be a base 64 encoded value.
  [KeyId <String>]: The unique identifier (GUID) for the key.
  [StartDateTime <DateTime?>]: The date and time at which the credential becomes valid.The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
  [Type <String>]: The type of key credential; for example, 'Symmetric'.
  [Usage <String>]: A string that describes the purpose for which the key can be used; for example, 'Verify'.

OAUTH2PERMISSIONSCOPE <IMicrosoftGraphPermissionScope[]>: The delegated permissions exposed by the application. For more information see the oauth2PermissionScopes property on the application entity's api property. Not nullable.
  [AdminConsentDescription <String>]: A description of the delegated permissions, intended to be read by an administrator granting the permission on behalf of all users. This text appears in tenant-wide admin consent experiences.
  [AdminConsentDisplayName <String>]: The permission's title, intended to be read by an administrator granting the permission on behalf of all users.
  [Id <String>]: Unique delegated permission identifier inside the collection of delegated permissions defined for a resource application.
  [IsEnabled <Boolean?>]: When creating or updating a permission, this property must be set to true (which is the default). To delete a permission, this property must first be set to false.  At that point, in a subsequent call, the permission may be removed.
  [Origin <String>]: 
  [Type <String>]: Specifies whether this delegated permission should be considered safe for non-admin users to consent to on behalf of themselves, or whether an administrator should be required for consent to the permissions. This will be the default behavior, but each customer can choose to customize the behavior in their organization (by allowing, restricting or limiting user consent to this delegated permission.)
  [UserConsentDescription <String>]: A description of the delegated permissions, intended to be read by a user granting the permission on their own behalf. This text appears in consent experiences where the user is consenting only on behalf of themselves.
  [UserConsentDisplayName <String>]: A title for the permission, intended to be read by a user granting the permission on their own behalf. This text appears in consent experiences where the user is consenting only on behalf of themselves.
  [Value <String>]: Specifies the value to include in the scp (scope) claim in access tokens. Must not exceed 120 characters in length. Allowed characters are : ! # $ % & ' ( ) * + , - . / : ;  =  ? @ [ ] ^ + _  {  } ~, as well as characters in the ranges 0-9, A-Z and a-z. Any other character, including the space character, are not allowed. May not begin with ..

PASSWORDCREDENTIALS <IMicrosoftGraphPasswordCredential[]>: The collection of password credentials associated with the service principal. Not nullable.
  [CustomKeyIdentifier <Byte[]>]: Do not use.
  [DisplayName <String>]: Friendly name for the password. Optional.
  [EndDateTime <DateTime?>]: The date and time at which the password expires represented using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Optional.
  [KeyId <String>]: The unique identifier for the password.
  [StartDateTime <DateTime?>]: The date and time at which the password becomes valid. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Optional.

SAMLSINGLESIGNONSETTING <IMicrosoftGraphSamlSingleSignOnSettings>: samlSingleSignOnSettings
  [(Any) <Object>]: This indicates any property can be added to this object.
  [RelayState <String>]: The relative URI the service provider would redirect to after completion of the single sign-on flow.

TOKENISSUANCEPOLICY <IMicrosoftGraphTokenIssuancePolicy[]>: The tokenIssuancePolicies assigned to this service principal. Supports $expand.
  [AppliesTo <IMicrosoftGraphDirectoryObject[]>]: 
    [DeletedDateTime <DateTime?>]: 
  [Definition <String[]>]: A string collection containing a JSON string that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required.
  [IsOrganizationDefault <Boolean?>]: If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false.
  [Description <String>]: Description for this policy.
  [DisplayName <String>]: Display name for this policy.
  [DeletedDateTime <DateTime?>]: 

TOKENLIFETIMEPOLICY <IMicrosoftGraphTokenLifetimePolicy[]>: The tokenLifetimePolicies assigned to this service principal. Supports $expand.
  [AppliesTo <IMicrosoftGraphDirectoryObject[]>]: 
    [DeletedDateTime <DateTime?>]: 
  [Definition <String[]>]: A string collection containing a JSON string that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required.
  [IsOrganizationDefault <Boolean?>]: If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false.
  [Description <String>]: Description for this policy.
  [DisplayName <String>]: Display name for this policy.
  [DeletedDateTime <DateTime?>]: 

TRANSITIVEMEMBEROF <IMicrosoftGraphDirectoryObject[]>: .
  [DeletedDateTime <DateTime?>]: 
.Link
https://docs.microsoft.com/powershell/module/az.resources/update-azadserviceprincipal
#>
function Update-AzADServicePrincipal {
  [OutputType([System.Boolean])]
  [CmdletBinding(DefaultParameterSetName = 'SpObjectIdWithDisplayNameParameterSet', PositionalBinding = $false, SupportsShouldProcess, ConfirmImpact = 'Medium')]
  [Alias('Set-AzADServicePrincipal')]
  param(
    [Parameter(ParameterSetName = 'SpObjectIdWithDisplayNameParameterSet', Mandatory)]
    [Alias('ServicePrincipalId', 'Id', 'ServicePrincipalObjectId')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Path')]
    [System.String]
    # key: id of servicePrincipal
    ${ObjectId},

    [Parameter(ParameterSetName = 'SpApplicationIdWithDisplayNameParameterSet', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Alias('AppId')]
    [System.Guid]
    # The unique identifier for the associated application (its appId property).
    ${ApplicationId},

    [Parameter(ParameterSetName = 'InputObjectWithDisplayNameParameterSet', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphServicePrincipal]
    # service principal object
    ${InputObject},

    [Parameter(ParameterSetName = 'SPNWithDisplayNameParameterSet', Mandatory)]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    [Alias('SPN')]
    # Contains the list of identifiersUris, copied over from the associated application.
    # Additional values can be added to hybrid applications.
    # These values can be used to identify the permissions exposed by this app within Azure AD.
    # For example,Client apps can specify a resource URI which is based on the values of this property to acquire an access token, which is the URI returned in the 'aud' claim.The any operator is required for filter expressions on multi-valued properties.
    # Not nullable.
    # Supports $filter (eq, NOT, ge, le, startsWith).
    ${ServicePrincipalName},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphKeyCredential[]]
    # The collection of key credentials associated with the application.
    # Not nullable.
    # Supports $filter (eq, NOT, ge, le).
    # To construct, see NOTES section for KEYCREDENTIALS properties and create a hash table.
    ${KeyCredential},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphPasswordCredential[]]
    # The collection of password credentials associated with the application.
    # Not nullable.
    # To construct, see NOTES section for PASSWORDCREDENTIALS properties and create a hash table.
    ${PasswordCredential},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # The URIs that identify the application within its Azure AD tenant, or within a verified custom domain if the application is multi-tenant.
    # For more information, see Application Objects and Service Principal Objects.
    # The any operator is required for filter expressions on multi-valued properties.
    # Not nullable.
    # Supports $filter (eq, ne, ge, le, startsWith).
    ${IdentifierUri},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Home page or landing page of the application.
    ${Homepage},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.Management.Automation.SwitchParameter]
    # true if the service principal account is enabled; otherwise, false.
    # Supports $filter (eq, ne, NOT, in).
    ${AccountEnabled},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphAddIn[]]
    # Defines custom behavior that a consuming service can use to call an app in specific contexts.
    # For example, applications that can render file streams may set the addIns property for its 'FileHandler' functionality.
    # This will let services like Microsoft 365 call the application in the context of a document the user is working on.
    # To construct, see NOTES section for ADDIN properties and create a hash table.
    ${AddIn},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # Used to retrieve service principals by subscription, identify resource group and full resource ids for managed identities.
    # Supports $filter (eq, NOT, ge, le, startsWith).
    ${AlternativeName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The description exposed by the associated application.
    ${AppDescription},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Contains the tenant id where the application is registered.
    # This is applicable only to service principals backed by applications.Supports $filter (eq, ne, NOT, ge, le).
    ${AppOwnerOrganizationId},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphAppRole[]]
    # The roles exposed by the application which this service principal represents.
    # For more information see the appRoles property definition on the application entity.
    # Not nullable.
    # To construct, see NOTES section for APPROLE properties and create a hash table.
    ${AppRole},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphAppRoleAssignment[]]
    # App role assignments for this app or service, granted to users, groups, and other service principals.Supports $expand.
    # To construct, see NOTES section for APPROLEASSIGNEDTO properties and create a hash table.
    ${AppRoleAssignedTo},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphAppRoleAssignment[]]
    # App role assignment for another app or service, granted to this service principal.
    # Supports $expand.
    # To construct, see NOTES section for APPROLEASSIGNMENT properties and create a hash table.
    ${AppRoleAssignment},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.Management.Automation.SwitchParameter]
    # Specifies whether users or other service principals need to be granted an app role assignment for this service principal before users can sign in or apps can get tokens.
    # The default value is false.
    # Not nullable.
    # Supports $filter (eq, ne, NOT).
    ${AppRoleAssignmentRequired},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphClaimsMappingPolicy[]]
    # The claimsMappingPolicies assigned to this service principal.
    # Supports $expand.
    # To construct, see NOTES section for CLAIMSMAPPINGPOLICY properties and create a hash table.
    ${ClaimsMappingPolicy},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphDelegatedPermissionClassification[]]
    # The permission classifications for delegated permissions exposed by the app that this service principal represents.
    # Supports $expand.
    # To construct, see NOTES section for DELEGATEDPERMISSIONCLASSIFICATION properties and create a hash table.
    ${DelegatedPermissionClassification},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.DateTime]
    # .
    ${DeletedDateTime},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Free text field to provide an internal end-user facing description of the service principal.
    # End-user portals such MyApps will display the application description in this field.
    # The maximum allowed size is 1024 characters.
    # Supports $filter (eq, ne, NOT, ge, le, startsWith) and $search.
    ${Description},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Specifies whether Microsoft has disabled the registered application.
    # Possible values are: null (default value), NotDisabled, and DisabledDueToViolationOfServicesAgreement (reasons may include suspicious, abusive, or malicious activity, or a violation of the Microsoft Services Agreement).
    # Supports $filter (eq, ne, NOT).
    ${DisabledByMicrosoftStatus},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The display name for the service principal.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith), $search, and $orderBy.
    ${DisplayName},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphEndpoint[]]
    # Endpoints available for discovery.
    # Services like Sharepoint populate this property with a tenant specific SharePoint endpoints that other applications can discover and use in their experiences.
    # To construct, see NOTES section for ENDPOINT properties and create a hash table.
    ${Endpoint},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphHomeRealmDiscoveryPolicy[]]
    # The homeRealmDiscoveryPolicies assigned to this service principal.
    # Supports $expand.
    # To construct, see NOTES section for HOMEREALMDISCOVERYPOLICY properties and create a hash table.
    ${HomeRealmDiscoveryPolicy},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphInformationalUrl]
    # informationalUrl
    # To construct, see NOTES section for INFO properties and create a hash table.
    ${Info},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Specifies the URL where the service provider redirects the user to Azure AD to authenticate.
    # Azure AD uses the URL to launch the application from Microsoft 365 or the Azure AD My Apps.
    # When blank, Azure AD performs IdP-initiated sign-on for applications configured with SAML-based single sign-on.
    # The user launches the application from Microsoft 365, the Azure AD My Apps, or the Azure AD SSO URL.
    ${LoginUrl},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Specifies the URL that will be used by Microsoft's authorization service to logout an user using OpenId Connect front-channel, back-channel or SAML logout protocols.
    ${LogoutUrl},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Free text field to capture information about the service principal, typically used for operational purposes.
    # Maximum allowed size is 1024 characters.
    ${Note},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # Specifies the list of email addresses where Azure AD sends a notification when the active certificate is near the expiration date.
    # This is only for the certificates used to sign the SAML token issued for Azure AD Gallery applications.
    ${NotificationEmailAddress},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphPermissionScope[]]
    # The delegated permissions exposed by the application.
    # For more information see the oauth2PermissionScopes property on the application entity's api property.
    # Not nullable.
    # To construct, see NOTES section for OAUTH2PERMISSIONSCOPE properties and create a hash table.
    ${Oauth2PermissionScope},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Specifies the single sign-on mode configured for this application.
    # Azure AD uses the preferred single sign-on mode to launch the application from Microsoft 365 or the Azure AD My Apps.
    # The supported values are password, saml, notSupported, and oidc.
    ${PreferredSingleSignOnMode},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Reserved for internal use only.
    # Do not write or otherwise rely on this property.
    # May be removed in future versions.
    ${PreferredTokenSigningKeyThumbprint},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # The URLs that user tokens are sent to for sign in with the associated application, or the redirect URIs that OAuth 2.0 authorization codes and access tokens are sent to for the associated application.
    # Not nullable.
    ${ReplyUrl},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphSamlSingleSignOnSettings]
    # samlSingleSignOnSettings
    # To construct, see NOTES section for SAMLSINGLESIGNONSETTING properties and create a hash table.
    ${SamlSingleSignOnSetting},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Identifies if the service principal represents an application or a managed identity.
    # This is set by Azure AD internally.
    # For a service principal that represents an application this is set as Application.
    # For a service principal that represent a managed identity this is set as ManagedIdentity.
    ${ServicePrincipalType},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # Custom strings that can be used to categorize and identify the service principal.
    # Not nullable.
    # Supports $filter (eq, NOT, ge, le, startsWith).
    ${Tag},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Specifies the keyId of a public key from the keyCredentials collection.
    # When configured, Azure AD issues tokens for this application encrypted using the key specified by this property.
    # The application code that receives the encrypted token must use the matching private key to decrypt the token before it can be used for the signed-in user.
    ${TokenEncryptionKeyId},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphTokenIssuancePolicy[]]
    # The tokenIssuancePolicies assigned to this service principal.
    # Supports $expand.
    # To construct, see NOTES section for TOKENISSUANCEPOLICY properties and create a hash table.
    ${TokenIssuancePolicy},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphTokenLifetimePolicy[]]
    # The tokenLifetimePolicies assigned to this service principal.
    # Supports $expand.
    # To construct, see NOTES section for TOKENLIFETIMEPOLICY properties and create a hash table.
    ${TokenLifetimePolicy},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphDirectoryObject[]]
    # .
    # To construct, see NOTES section for TRANSITIVEMEMBEROF properties and create a hash table.
    ${TransitiveMemberOf},

    [Parameter()]
    [Alias("AzContext", "AzureRmContext", "AzureCredential")]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Returns true when the command succeeds
    ${PassThru},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
  )

  process {
    $param = @{}
    if ($PSBoundParameters['PassThru']) {
      $shouldPassThru = $PSBoundParameters['PassThru']
      $null = $PSBoundParameters.Remove('PassThru')
    }

    if ($PSBoundParameters['KeyCredential']) {
      $kc = $PSBoundParameters['KeyCredential']
      $null = $PSBoundParameters.Remove('KeyCredential')
    }
    if ($PSBoundParameters['PasswordCredential']) {
      $pc = $PSBoundParameters['PasswordCredential']
      $null = $PSBoundParameters.Remove('PasswordCredential')
    }
    if ($PSBoundParameters['IdentifierUri']) {
      $param['IdentifierUri'] = $PSBoundParameters['IdentifierUri']
      $null = $PSBoundParameters.Remove('IdentifierUri')
    }
    if ($PSBoundParameters['Displayname']) {
      $param['Displayname'] = $PSBoundParameters['Displayname']
      $null = $PSBoundParameters.Remove('Displayname')
    }
    if ($PSBoundParameters['Homepage']) {
      $param['Homepage'] = $PSBoundParameters['Homepage']
      $null = $PSBoundParameters.Remove('Homepage')
    }

    switch ($PSCmdlet.ParameterSetName) {
      'SpObjectIdWithDisplayNameParameterSet' {
        $sp = (Get-AzADServicePrincipal -ObjectId $PSBoundParameters['ObjectId'])
        $param['ApplicationId'] = $sp.AppId
        $PSBoundParameters['Id'] = $PSBoundParameters['ObjectId']
        $null = $PSBoundParameters.Remove('ObjectId')
        break
      } 
      'SpApplicationIdWithDisplayNameParameterSet' {
        $param['ApplicationId'] = $PSBoundParameters['ApplicationId']
        $sp = Get-AzADServicePrincipal -ApplicationId $PSBoundParameters['ApplicationId']
        $PSBoundParameters['Id'] = $sp.Id
        $null = $PSBoundParameters.Remove('ApplicationId')
        break
      }
      'SPNWithDisplayNameParameterSet' {
        [System.Array]$list = Get-AzADServicePrincipal -ServicePrincipalName $PSBoundParameters['ServicePrincipalName']
        if(1 -lt $list.Count) {
          Write-Error "More than one service principal found with service principal Name '$($PSBoundParameters['ServicePrincipalName'])'. Please use the Get-AzADServicePrincipal cmdlet to get the object id of the desired service principal."
          return
        } elseif (1 -eq $list.Count) {
          $PSBoundParameters['Id'] = $list[0].Id
          $param['ApplicationId'] = $list[0].AppId
        } else {
          Write-Error "Service principal with service principal name '$($PSBoundParameters['ServicePrincipalName'])' does not exist."
          return
      }
        $null = $PSBoundParameters.Remove('ServicePrincipalName')
        break
      }
      'InputObjectWithDisplayNameParameterSet' {
        $PSBoundParameters['Id'] = $PSBoundParameters['InputObject'].Id
        $param['ApplicationId'] = $PSBoundParameters['InputObject'].AppId
        $null = $PSBoundParameters.Remove('InputObject')
        break
      }
    }

    if ($PSBoundParameters['Debug']) {
      $param['Debug'] = $PSBoundParameters['Debug']
    }
    Update-AzADApplication @param
    $appid = $param['ApplicationId']
    $param=@{'ApplicationId'=$appid}

    if ($pc) {
      $param['PasswordCredentials'] = $pc
    }
    if ($kc) {
      $param['KeyCredentials'] = $kc
    }
    if ($pc -or $kc) {
      $null = New-AzADAppCredential @param
    }

    $sp=Az.MSGraph.internal\Update-AzADServicePrincipal @PSBoundParameters

    if ($shouldPassThru) {
      $PSCmdlet.WriteObject($true)
    }
  }
}
# SIG # Begin signature block
# MIInrQYJKoZIhvcNAQcCoIInnjCCJ5oCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCjgU603jTs77Mt
# Th9k3AVHCQ0V9zSLhc2KE+UalkGQZqCCDYEwggX/MIID56ADAgECAhMzAAACzI61
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
# BgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgDFXPYmKS
# ukn9fiYyC7FwOgR/hAz+KJ8+Vt6I6iVizbYwQgYKKwYBBAGCNwIBDDE0MDKgFIAS
# AE0AaQBjAHIAbwBzAG8AZgB0oRqAGGh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbTAN
# BgkqhkiG9w0BAQEFAASCAQBmKhlnk+gEURMKECs57ZvhKOLvTUyLfC4aFk/LEMF2
# aVhZ/N5qxhXxIgIp+nNZXpjuJv/+1s/9z4kwnCPAENmmZVgt3woj81N+OTRsHzkO
# H1/WzDtQ5Lej/pD/8m6CGDeskuNo+8Nqv0M/7IVjLiiM8vWkk2FLk29+oW1aiuxP
# ER32i4YkUxKT4CRCRF9TpKOfWWW/2t8ByaVywCmd6h0HrcytE+KxKWjRI49QbbNX
# leeX9XxW3kA7+BwU8Nfx56ErNTqEeTyKaWZ3GEcRA8YvgokcYJegGGfYh/hHNvVb
# w6gLIieSYV+zIWAhfDu9UFafAs95VxUhJN9NMA79y7M5oYIXDDCCFwgGCisGAQQB
# gjcDAwExghb4MIIW9AYJKoZIhvcNAQcCoIIW5TCCFuECAQMxDzANBglghkgBZQME
# AgEFADCCAVUGCyqGSIb3DQEJEAEEoIIBRASCAUAwggE8AgEBBgorBgEEAYRZCgMB
# MDEwDQYJYIZIAWUDBAIBBQAEIHT4h2WlRc9CpytKFxQ5u7wKz4dZttv2uKwi/0DV
# zuMcAgZjc+nrORoYEzIwMjIxMTE3MTMzNzI5LjY4MlowBIACAfSggdSkgdEwgc4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsTIE1p
# Y3Jvc29mdCBPcGVyYXRpb25zIFB1ZXJ0byBSaWNvMSYwJAYDVQQLEx1UaGFsZXMg
# VFNTIEVTTjozMkJELUUzRDUtM0IxRDElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgU2VydmljZaCCEV8wggcQMIIE+KADAgECAhMzAAABrfzfTVjjXTLpAAEA
# AAGtMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEw
# MB4XDTIyMDMwMjE4NTEzNloXDTIzMDUxMTE4NTEzNlowgc4xCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVy
# YXRpb25zIFB1ZXJ0byBSaWNvMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjozMkJE
# LUUzRDUtM0IxRDElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vydmlj
# ZTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOieUyqlTSrVLhvY7TO8
# vgC+T5N/y/MXeR3oNwE0rLI1Eg/gM5g9NhP+KqqJc/7uPL4TsoALb+RVf6roYNll
# yQrYmquUjwsq262MD5L9l9rU1plz2tMPehP8addVlNIjYIBh0NC4CyME6txVppQr
# 7eFd/bW0X9tnZy1aDW+zoaJB2FY8haokq5cRONEW4uoVsTTXsICkbYOAYffIIGak
# MFXVvB30NcsuiDn6uDk83XXTs0tnSr8FxzPoD8SgPPIcWaWPEjCQLr5I0BxfdUli
# wNPHIPEglqosrClRjXG7rcZWbWeODgATi0i6DUsv1Wn0LOW4svK4/Wuc/v9dlmuI
# ramv9whbgCykUuYZy8MxTzsQqU2Rxcm8h89CXA5jf1k7k3ZiaLUJ003MjtTtNXzl
# gb+k1A5eL17G3C4Ejw5AoViM+UBGQvxuTxpFeaGoQFqeOGGtEK0qk0wdUX9p/4Au
# 9Xsle5D5fvypBdscXBslUBcT6+CYq0kQ9smsTyhV4DK9wb9Zn7ObEOfT0AQyppI6
# jwzBjHhAGFyrKYjIbglMaEixjRv7XdNic2VuYKyS71A0hs6dbbDx/V7hDbdv2srt
# Z2VTO0y2E+4QqMRKtABv4AggjYKz5TYGuQ4VbbPY8fBO9Xqva3Gnx1ZDOQ3nGVFK
# HwarGDcNdB3qesvtJbIGJgJjAgMBAAGjggE2MIIBMjAdBgNVHQ4EFgQUfVB0HQS8
# qiFabmqEqOV9LrLGwVkwHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIw
# XwYDVR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9w
# cy9jcmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3Js
# MGwGCCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3Nv
# ZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENB
# JTIwMjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADATBgNVHSUEDDAKBggrBgEFBQcD
# CDANBgkqhkiG9w0BAQsFAAOCAgEAi9AdRbsx/gOSdBXndwRejQuutQqce3k3bgs1
# slPjZSx6FDXp1IZzjOyT1Jo/3eUWDBFJdi+Heu1NoyDdGn9vL6rxly1L68K4MnfL
# Bm+ybyjN+xa1eNa4+4cOoOuxE2Kt8jtmZbIhx2jvY7F9qY/lanR5PSbUKyClhNQh
# xsnNUp/JSQ+o7nAuQJ+wsCwPCrXYE7C+TvKDja6e6WU0K4RiBXFGU1z6Mt3K9wlM
# D/QGU4+/IGZDmE+/Z/k0JfJjZyxCAlcmhe3rgdhDzAsGxJYq4PblGZTBdr8wkQwp
# P2jggyMMawMM5DggwvXaDbrqCQ8gksNhCZzTqfS2dbgLF0m7HfwlUMrcnzi/bdTS
# RWzIXg5QsH1t5XaaIH+TZ1uZBtwXJ8EOXr6S+2A6q8RQVY10KnBH6YpGE9OhXPfu
# Iu882muFEdh4EXbPdARUR1IMSIxg88khSBC/YBwQhCpjTksq5J3Z+jyHWZ4MnXX5
# R42mAR584iRYc7agYvuotDEqcD0U9lIjgW31PqfqZQ1tuYZTiGcKE9QcYGvZFKnV
# dkqK8V0M9e+kF5CqDOrMMYRV2+I/FhyQsJHxK/G53D0O5bvdIh2gDnEHRAFihdZj
# 29Z7W0paGPotGX0oB5r9wqNjM3rbvuEe6FJ323MPY1x9/N1g126T/SokqADJBTKq
# yBYN4zMwggdxMIIFWaADAgECAhMzAAAAFcXna54Cm0mZAAAAAAAVMA0GCSqGSIb3
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
# MSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjozMkJELUUzRDUtM0IxRDElMCMGA1UE
# AxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaIjCgEBMAcGBSsOAwIaAxUA
# QJLRrUVR4ZbBDgWPjuNqVctUzpCggYMwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEG
# A1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWlj
# cm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFt
# cCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIFAOcgYqIwIhgPMjAyMjExMTcxMTM0
# NThaGA8yMDIyMTExODExMzQ1OFowdzA9BgorBgEEAYRZCgQBMS8wLTAKAgUA5yBi
# ogIBADAKAgEAAgIRuQIB/zAHAgEAAgIRwzAKAgUA5yG0IgIBADA2BgorBgEEAYRZ
# CgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIBAAIDB6EgoQowCAIBAAIDAYagMA0G
# CSqGSIb3DQEBBQUAA4GBAGnRey0GNRlPeqF61qnpM8xUTTZrSC0cupSbu0/go/G0
# KETMe/W2vFCdjmWdChRhkqbM6ddBqbQ4eBnDqxpA9XCwtaWCpmHX55TlY+CMFngE
# wvbhUKm6rgIUY4mILy9X6wnLk/1kbBx4OS1433SObWCQtOzfmL+DLxtyQ3MOOsHy
# MYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMA
# AAGt/N9NWONdMukAAQAAAa0wDQYJYIZIAWUDBAIBBQCgggFKMBoGCSqGSIb3DQEJ
# AzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0BCQQxIgQgMU4wdb9fG+0OPU3F3mbH
# NICVxMNajFKGcIc/BG+zGtcwgfoGCyqGSIb3DQEJEAIvMYHqMIHnMIHkMIG9BCCf
# 6nw9CR5e1+Ottcn1w992Kmn8YMTY/DWPIHeMbMtQgjCBmDCBgKR+MHwxCzAJBgNV
# BAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4w
# HAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29m
# dCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAABrfzfTVjjXTLpAAEAAAGtMCIEIPFH
# 3enEMkTAa41y0DhlgrjPYE8r8iHI9Zw6A+0SACm5MA0GCSqGSIb3DQEBCwUABIIC
# AHe/1gPArqH4qrrfXBxAl6okesyjq1EaTx0V8mjw6wrZWh1/2kEi4+N2Q2TdlpyO
# sMqvTIiGEK+fa3wiFdRDAaNhJjk9zIdnaSVyhZxbceoHSGVQPCJgtd5uuel6UC1e
# FTBc1kAcsAcfJ2WrKJitN9HtDJX9fXD1LciZIHTWEWTE0gApI1RA+vgUfwgQuE+I
# SA6zjNrZFwnAQR7GZIyB72uLeLyUbPIKUzv5HqGHl3yr0rOTrh8UVChoIFdLDs6d
# QUXYQDdHtDAYU0l9DQU/ccRZ4O1YPkaaDe4eR/Vsi1Fkvawek+J2F4oIRR5+GcEP
# x2HOrebOhP2EqbFtdkxpxFF7MxSnx1mtC+ES6O6upVGAL+ebjJxzU0jhBPhai7gO
# 3SlLgYaeWNNWhdbuy1s+KQWla/85gpajDMq4oTItcULaZwKVIJ3M7wy98O6eir17
# NPjYrcY2k/oJ7PB4I1waf3YRjjWu4/gJ/HpLNqVcTe+rHK3vYr0y4qCxfgZwuNS3
# V1IPnHot2BMEf5HkRiUfKe5Y0H9/CSp8DdaGb7I6iAm1X1UwVYk9t/oLcZjVoOfS
# SeLUqLrUA0+qS3hUExwbR8hIG1bKRijVCdYdKT4C9cfW5ny+T1AkaKuAEiJj4Ok7
# aTN1gNc2LsSKBJagqBVa/H1MNk9RadtsyEw99uGypQMi
# SIG # End signature block
