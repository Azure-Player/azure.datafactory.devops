
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
Updates entity in applications
.Description
Updates entity in applications
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

ADDIN <IMicrosoftGraphAddIn[]>: Defines custom behavior that a consuming service can use to call an app in specific contexts. For example, applications that can render file streams may set the addIns property for its 'FileHandler' functionality. This will let services like Office 365 call the application in the context of a document the user is working on.
  [Id <String>]: 
  [Property <IMicrosoftGraphKeyValue[]>]: 
    [Key <String>]: Key.
    [Value <String>]: Value.
  [Type <String>]: 

API <IMicrosoftGraphApiApplication>: apiApplication
  [(Any) <Object>]: This indicates any property can be added to this object.
  [AcceptMappedClaim <Boolean?>]: When true, allows an application to use claims mapping without specifying a custom signing key.
  [KnownClientApplication <String[]>]: Used for bundling consent if you have a solution that contains two parts: a client app and a custom web API app. If you set the appID of the client app to this value, the user only consents once to the client app. Azure AD knows that consenting to the client means implicitly consenting to the web API and automatically provisions service principals for both APIs at the same time. Both the client and the web API app must be registered in the same tenant.
  [Oauth2PermissionScope <IMicrosoftGraphPermissionScope[]>]: The definition of the delegated permissions exposed by the web API represented by this application registration. These delegated permissions may be requested by a client application, and may be granted by users or administrators during consent. Delegated permissions are sometimes referred to as OAuth 2.0 scopes.
    [AdminConsentDescription <String>]: A description of the delegated permissions, intended to be read by an administrator granting the permission on behalf of all users. This text appears in tenant-wide admin consent experiences.
    [AdminConsentDisplayName <String>]: The permission's title, intended to be read by an administrator granting the permission on behalf of all users.
    [Id <String>]: Unique delegated permission identifier inside the collection of delegated permissions defined for a resource application.
    [IsEnabled <Boolean?>]: When creating or updating a permission, this property must be set to true (which is the default). To delete a permission, this property must first be set to false.  At that point, in a subsequent call, the permission may be removed.
    [Origin <String>]: 
    [Type <String>]: Specifies whether this delegated permission should be considered safe for non-admin users to consent to on behalf of themselves, or whether an administrator should be required for consent to the permissions. This will be the default behavior, but each customer can choose to customize the behavior in their organization (by allowing, restricting or limiting user consent to this delegated permission.)
    [UserConsentDescription <String>]: A description of the delegated permissions, intended to be read by a user granting the permission on their own behalf. This text appears in consent experiences where the user is consenting only on behalf of themselves.
    [UserConsentDisplayName <String>]: A title for the permission, intended to be read by a user granting the permission on their own behalf. This text appears in consent experiences where the user is consenting only on behalf of themselves.
    [Value <String>]: Specifies the value to include in the scp (scope) claim in access tokens. Must not exceed 120 characters in length. Allowed characters are : ! # $ % & ' ( ) * + , - . / : ;  =  ? @ [ ] ^ + _  {  } ~, as well as characters in the ranges 0-9, A-Z and a-z. Any other character, including the space character, are not allowed. May not begin with ..
  [PreAuthorizedApplication <IMicrosoftGraphPreAuthorizedApplication[]>]: Lists the client applications that are pre-authorized with the specified delegated permissions to access this application's APIs. Users are not required to consent to any pre-authorized application (for the permissions specified). However, any additional permissions not listed in preAuthorizedApplications (requested through incremental consent for example) will require user consent.
    [AppId <String>]: The unique identifier for the application.
    [DelegatedPermissionId <String[]>]: The unique identifier for the oauth2PermissionScopes the application requires.
  [RequestedAccessTokenVersion <Int32?>]: Specifies the access token version expected by this resource. This changes the version and format of the JWT produced independent of the endpoint or client used to request the access token.  The endpoint used, v1.0 or v2.0, is chosen by the client and only impacts the version of id_tokens. Resources need to explicitly configure requestedAccessTokenVersion to indicate the supported access token format.  Possible values for requestedAccessTokenVersion are 1, 2, or null. If the value is null, this defaults to 1, which corresponds to the v1.0 endpoint.  If signInAudience on the application is configured as AzureADandPersonalMicrosoftAccount, the value for this property must be 2

APPROLE <IMicrosoftGraphAppRole[]>: The collection of roles assigned to the application. With app role assignments, these roles can be assigned to users, groups, or service principals associated with other applications. Not nullable.
  [AllowedMemberType <String[]>]: Specifies whether this app role can be assigned to users and groups (by setting to ['User']), to other application's (by setting to ['Application'], or both (by setting to ['User', 'Application']). App roles supporting assignment to other applications' service principals are also known as application permissions. The 'Application' value is only supported for app roles defined on application entities.
  [Description <String>]: The description for the app role. This is displayed when the app role is being assigned and, if the app role functions as an application permission, during  consent experiences.
  [DisplayName <String>]: Display name for the permission that appears in the app role assignment and consent experiences.
  [Id <String>]: Unique role identifier inside the appRoles collection. When creating a new app role, a new Guid identifier must be provided.
  [IsEnabled <Boolean?>]: When creating or updating an app role, this must be set to true (which is the default). To delete a role, this must first be set to false.  At that point, in a subsequent call, this role may be removed.
  [Origin <String>]: Specifies if the app role is defined on the application object or on the servicePrincipal entity. Must not be included in any POST or PATCH requests. Read-only.
  [Value <String>]: Specifies the value to include in the roles claim in ID tokens and access tokens authenticating an assigned user or service principal. Must not exceed 120 characters in length. Allowed characters are : ! # $ % & ' ( ) * + , - . / : ;  =  ? @ [ ] ^ + _  {  } ~, as well as characters in the ranges 0-9, A-Z and a-z. Any other character, including the space character, are not allowed. May not begin with ..

HOMEREALMDISCOVERYPOLICY <IMicrosoftGraphHomeRealmDiscoveryPolicy[]>: .
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

KEYCREDENTIALS <IMicrosoftGraphKeyCredential[]>: The collection of key credentials associated with the application. Not nullable. Supports $filter (eq, NOT, ge, le).
  [CustomKeyIdentifier <Byte[]>]: Custom key identifier
  [DisplayName <String>]: Friendly name for the key. Optional.
  [EndDateTime <DateTime?>]: The date and time at which the credential expires.The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
  [Key <Byte[]>]: Value for the key credential. Should be a base 64 encoded value.
  [KeyId <String>]: The unique identifier (GUID) for the key.
  [StartDateTime <DateTime?>]: The date and time at which the credential becomes valid.The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
  [Type <String>]: The type of key credential; for example, 'Symmetric'.
  [Usage <String>]: A string that describes the purpose for which the key can be used; for example, 'Verify'.

OPTIONALCLAIM <IMicrosoftGraphOptionalClaims>: optionalClaims
  [(Any) <Object>]: This indicates any property can be added to this object.
  [AccessToken <IMicrosoftGraphOptionalClaim[]>]: The optional claims returned in the JWT access token.
    [AdditionalProperty <String[]>]: Additional properties of the claim. If a property exists in this collection, it modifies the behavior of the optional claim specified in the name property.
    [Essential <Boolean?>]: If the value is true, the claim specified by the client is necessary to ensure a smooth authorization experience for the specific task requested by the end user. The default value is false.
    [Name <String>]: The name of the optional claim.
    [Source <String>]: The source (directory object) of the claim. There are predefined claims and user-defined claims from extension properties. If the source value is null, the claim is a predefined optional claim. If the source value is user, the value in the name property is the extension property from the user object.
  [IdToken <IMicrosoftGraphOptionalClaim[]>]: The optional claims returned in the JWT ID token.
  [Saml2Token <IMicrosoftGraphOptionalClaim[]>]: The optional claims returned in the SAML token.

PARENTALCONTROLSETTING <IMicrosoftGraphParentalControlSettings>: parentalControlSettings
  [(Any) <Object>]: This indicates any property can be added to this object.
  [CountriesBlockedForMinor <String[]>]: Specifies the two-letter ISO country codes. Access to the application will be blocked for minors from the countries specified in this list.
  [LegalAgeGroupRule <String>]: Specifies the legal age group rule that applies to users of the app. Can be set to one of the following values: ValueDescriptionAllowDefault. Enforces the legal minimum. This means parental consent is required for minors in the European Union and Korea.RequireConsentForPrivacyServicesEnforces the user to specify date of birth to comply with COPPA rules. RequireConsentForMinorsRequires parental consent for ages below 18, regardless of country minor rules.RequireConsentForKidsRequires parental consent for ages below 14, regardless of country minor rules.BlockMinorsBlocks minors from using the app.

PASSWORDCREDENTIALS <IMicrosoftGraphPasswordCredential[]>: The collection of password credentials associated with the application. Not nullable.
  [CustomKeyIdentifier <Byte[]>]: Do not use.
  [DisplayName <String>]: Friendly name for the password. Optional.
  [EndDateTime <DateTime?>]: The date and time at which the password expires represented using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Optional.
  [KeyId <String>]: The unique identifier for the password.
  [StartDateTime <DateTime?>]: The date and time at which the password becomes valid. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Optional.

PUBLICCLIENT <IMicrosoftGraphPublicClientApplication>: publicClientApplication
  [(Any) <Object>]: This indicates any property can be added to this object.
  [RedirectUri <String[]>]: Specifies the URLs where user tokens are sent for sign-in, or the redirect URIs where OAuth 2.0 authorization codes and access tokens are sent.

REQUIREDRESOURCEACCESS <IMicrosoftGraphRequiredResourceAccess[]>: Specifies the resources that the application needs to access. This property also specifies the set of OAuth permission scopes and application roles that it needs for each of those resources. This configuration of access to the required resources drives the consent experience. Not nullable. Supports $filter (eq, NOT, ge, le).
  [ResourceAccess <IMicrosoftGraphResourceAccess[]>]: The list of OAuth2.0 permission scopes and app roles that the application requires from the specified resource.
    [Id <String>]: The unique identifier for one of the oauth2PermissionScopes or appRole instances that the resource application exposes.
    [Type <String>]: Specifies whether the id property references an oauth2PermissionScopes or an appRole. Possible values are Scope or Role.
  [ResourceAppId <String>]: The unique identifier for the resource that the application requires access to.  This should be equal to the appId declared on the target resource application.

SPA <IMicrosoftGraphSpaApplication>: spaApplication
  [(Any) <Object>]: This indicates any property can be added to this object.
  [RedirectUri <String[]>]: Specifies the URLs where user tokens are sent for sign-in, or the redirect URIs where OAuth 2.0 authorization codes and access tokens are sent.

TOKENISSUANCEPOLICY <IMicrosoftGraphTokenIssuancePolicy[]>: .
  [AppliesTo <IMicrosoftGraphDirectoryObject[]>]: 
    [DeletedDateTime <DateTime?>]: 
  [Definition <String[]>]: A string collection containing a JSON string that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required.
  [IsOrganizationDefault <Boolean?>]: If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false.
  [Description <String>]: Description for this policy.
  [DisplayName <String>]: Display name for this policy.
  [DeletedDateTime <DateTime?>]: 

TOKENLIFETIMEPOLICY <IMicrosoftGraphTokenLifetimePolicy[]>: The tokenLifetimePolicies assigned to this application. Supports $expand.
  [AppliesTo <IMicrosoftGraphDirectoryObject[]>]: 
    [DeletedDateTime <DateTime?>]: 
  [Definition <String[]>]: A string collection containing a JSON string that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required.
  [IsOrganizationDefault <Boolean?>]: If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false.
  [Description <String>]: Description for this policy.
  [DisplayName <String>]: Display name for this policy.
  [DeletedDateTime <DateTime?>]: 

WEB <IMicrosoftGraphWebApplication>: webApplication
  [(Any) <Object>]: This indicates any property can be added to this object.
  [HomePageUrl <String>]: Home page or landing page of the application.
  [ImplicitGrantSetting <IMicrosoftGraphImplicitGrantSettings>]: implicitGrantSettings
    [(Any) <Object>]: This indicates any property can be added to this object.
    [EnableAccessTokenIssuance <Boolean?>]: Specifies whether this web application can request an access token using the OAuth 2.0 implicit flow.
    [EnableIdTokenIssuance <Boolean?>]: Specifies whether this web application can request an ID token using the OAuth 2.0 implicit flow.
  [LogoutUrl <String>]: Specifies the URL that will be used by Microsoft's authorization service to logout an user using front-channel, back-channel or SAML logout protocols.
  [RedirectUri <String[]>]: Specifies the URLs where user tokens are sent for sign-in, or the redirect URIs where OAuth 2.0 authorization codes and access tokens are sent.
.Link
https://learn.microsoft.com/powershell/module/az.resources/update-azadapplication
#>
function Update-AzADApplication {
  [OutputType([System.Boolean])]
  [CmdletBinding(DefaultParameterSetName = 'ApplicationObjectIdWithUpdateParamsParameterSet', PositionalBinding = $false, SupportsShouldProcess, ConfirmImpact = 'Medium')]
  [Alias('Set-AzADApplication')]
  param(
    [Parameter(ParameterSetName = 'ApplicationObjectIdWithUpdateParamsParameterSet', Mandatory)]
    [Alias('Id')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Path')]
    [System.String]
    # key: id of application
    ${ObjectId},

    [Parameter(ParameterSetName = 'ApplicationIdWithUpdateParamsParameterSet', Mandatory)]
    [Alias('AppId')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Path')]
    [System.Guid]
    # key: application id
    ${ApplicationId},

    [Parameter(ParameterSetName = 'InputObjectWithUpdateParamsParameterSet', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphApplication]
    # key: application object
    ${InputObject},

    [Parameter()]
    [Alias('WebHomePageUrl')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # home page url for web
    ${HomePage},

    [Parameter(HelpMessage = "The application reply Urls.")]
    [Alias('WebRedirectUri')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    [Alias('ReplyUrls')]
    ${ReplyUrl},

    [Parameter(HelpMessage = "The value specifying whether the application is a single tenant or a multi-tenant. Is equivalent to '-SignInAudience AzureADMultipleOrgs' when switch is on")]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.Boolean]
    ${AvailableToOtherTenants},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphAddIn[]]
    # Defines custom behavior that a consuming service can use to call an app in specific contexts.
    # For example, applications that can render file streams may set the addIns property for its 'FileHandler' functionality.
    # This will let services like Office 365 call the application in the context of a document the user is working on.
    # To construct, see NOTES section for ADDIN properties and create a hash table.
    ${AddIn},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphApiApplication]
    # apiApplication
    # To construct, see NOTES section for API properties and create a hash table.
    ${Api},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphAppRole[]]
    # The collection of roles assigned to the application.
    # With app role assignments, these roles can be assigned to users, groups, or service principals associated with other applications.
    # Not nullable.
    # To construct, see NOTES section for APPROLE properties and create a hash table.
    ${AppRole},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Unique identifier of the applicationTemplate.
    ${ApplicationTemplateId},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.DateTime]
    # .
    ${CreatedOnBehalfOfDeletedDateTime},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.DateTime]
    # .
    ${DeletedDateTime},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # An optional description of the application.
    # Returned by default.
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
    # The display name for the application.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith), $search, and $orderBy.
    ${DisplayName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Configures the groups claim issued in a user or OAuth 2.0 access token that the application expects.
    # To set this attribute, use one of the following string values: None, SecurityGroup (for security groups and Azure AD roles), All (this gets all security groups, distribution groups, and Azure AD directory roles that the signed-in user is a member of).
    ${GroupMembershipClaim},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphHomeRealmDiscoveryPolicy[]]
    # .
    # To construct, see NOTES section for HOMEREALMDISCOVERYPOLICY properties and create a hash table.
    ${HomeRealmDiscoveryPolicy},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    [Alias('IdentifierUris')]
    # The URIs that identify the application within its Azure AD tenant, or within a verified custom domain if the application is multi-tenant.
    # For more information, see Application Objects and Service Principal Objects.
    # The any operator is required for filter expressions on multi-valued properties.
    # Not nullable.
    # Supports $filter (eq, ne, ge, le, startsWith).
    ${IdentifierUri},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphInformationalUrl]
    # informationalUrl
    # To construct, see NOTES section for INFO properties and create a hash table.
    ${Info},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.Management.Automation.SwitchParameter]
    # Specifies whether this application supports device authentication without a user.
    # The default is false.
    ${IsDeviceOnlyAuthSupported},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.Management.Automation.SwitchParameter]
    # Specifies the fallback application type as public client, such as an installed application running on a mobile device.
    # The default value is false which means the fallback application type is confidential client such as a web app.
    # There are certain scenarios where Azure AD cannot determine the client application type.
    # For example, the ROPC flow where the application is configured without specifying a redirect URI.
    # In those cases Azure AD interprets the application type based on the value of this property.
    ${IsFallbackPublicClient},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Input File for Logo (The main logo for the application.
    # Not nullable.)
    ${LogoInputFile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Notes relevant for the management of the application.
    ${Note},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.Management.Automation.SwitchParameter]
    # .
    ${Oauth2RequirePostResponse},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphOptionalClaims]
    # optionalClaims
    # To construct, see NOTES section for OPTIONALCLAIM properties and create a hash table.
    ${OptionalClaim},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphParentalControlSettings]
    # parentalControlSettings
    # To construct, see NOTES section for PARENTALCONTROLSETTING properties and create a hash table.
    ${ParentalControlSetting},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    ${PublicClientRedirectUri},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphRequiredResourceAccess[]]
    # Specifies the resources that the application needs to access.
    # This property also specifies the set of OAuth permission scopes and application roles that it needs for each of those resources.
    # This configuration of access to the required resources drives the consent experience.
    # Not nullable.
    # Supports $filter (eq, NOT, ge, le).
    # To construct, see NOTES section for REQUIREDRESOURCEACCESS properties and create a hash table.
    ${RequiredResourceAccess},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Specifies the Microsoft accounts that are supported for the current application.
    # Supported values are: AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount, PersonalMicrosoftAccount.
    # See more in the table below.
    # Supports $filter (eq, ne, NOT).
    ${SignInAudience},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    ${SPARedirectUri},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # Custom strings that can be used to categorize and identify the application.
    # Not nullable.Supports $filter (eq, NOT, ge, le, startsWith).
    ${Tag},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Specifies the keyId of a public key from the keyCredentials collection.
    # When configured, Azure AD encrypts all the tokens it emits by using the key this property points to.
    # The application code that receives the encrypted token must use the matching private key to decrypt the token before it can be used for the signed-in user.
    ${TokenEncryptionKeyId},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphTokenIssuancePolicy[]]
    # .
    # To construct, see NOTES section for TOKENISSUANCEPOLICY properties and create a hash table.
    ${TokenIssuancePolicy},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphTokenLifetimePolicy[]]
    # The tokenLifetimePolicies assigned to this application.
    # Supports $expand.
    # To construct, see NOTES section for TOKENLIFETIMEPOLICY properties and create a hash table.
    ${TokenLifetimePolicy},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphWebApplication]
    # webApplication
    # To construct, see NOTES section for WEB properties and create a hash table.
    ${Web},

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
    switch ($PSCmdlet.ParameterSetName) {
      'ApplicationObjectIdWithUpdateParamsParameterSet' {
        $PSBoundParameters['Id'] = $PSBoundParameters['ObjectId']
        $null = $PSBoundParameters.Remove('ObjectId')
        break
      }
      'ApplicationIdWithUpdateParamsParameterSet' {
        try {
          $param = @{}
          $param['ApplicationId'] = $PSBoundParameters['ApplicationId']
          $PSBoundParameters['Id'] = (Get-AzADApplication @param).Id
        }
        catch {
          throw
        }
        $null = $PSBoundParameters.Remove('ApplicationId')
        break
      }
      'InputObjectWithUpdateParamsParameterSet' {
        $PSBoundParameters['Id'] = $PSBoundParameters['InputObject'].Id
        $null = $PSBoundParameters.Remove('InputObject')
        break
      }
      default {
        break
      }
    }

    if ($PSBoundParameters.ContainsKey('AvailableToOtherTenants')) {
      if ($PSBoundParameters['SignInAudience']) {
        if (($PSBoundParameters['SignInAudience'] -in 'AzureADMyOrg', 'PersonalMicrosoftAccount') -and $PSBoundParameters['AvailableToOtherTenants']) {
          Write-Error "sign in audience '$($PSBoundParameters['SignInAudience'])' cannot be available to other tenants"
          return
        } elseif (($PSBoundParameters['SignInAudience'] -in 'AzureADMultipleOrgs', 'AzureADandPersonalMicrosoftAccount') -and !$PSBoundParameters['AvailableToOtherTenants']) {
          Write-Error "sign in audience '$($PSBoundParameters['SignInAudience'])' is available to other tenants, please try to use 'AzureADMyOrg' or 'PersonalMicrosoftAccount'"
          return
        }  
      } else {
        if ($PSBoundParameters['AvailableToOtherTenants']) {
          $PSBoundParameters['SignInAudience'] = 'AzureADMultipleOrgs'
        } else {
          $PSBoundParameters['SignInAudience'] = 'AzureADMyOrg'
        }
      }
      $null = $PSBoundParameters.Remove('AvailableToOtherTenants')
    }
    # even if payload contains all three redirect options, only one will be added in the actual app, the order is
    # web -> spa -> public client
    if (!$PSBoundParameters['Web'] -And ($PSBoundParameters['HomePage'] -or $PSBoundParameters['ReplyUrl'])) {
      $props = @{}
      if ($PSBoundParameters['HomePage']) {
        $props['HomePageUrl'] = $PSBoundParameters['HomePage']
        $null = $PSBoundParameters.Remove('HomePage')
      }
      if ($PSBoundParameters['ReplyUrl']) {
        $props['RedirectUri'] = $PSBoundParameters['ReplyUrl']
        $null = $PSBoundParameters.Remove('ReplyUrl')
      }
      $PSBoundParameters['Web'] = New-Object -TypeName "Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphWebApplication" -Property $props
    }
    elseif ($PSBoundParameters['SPARedirectUri']) {
      $PSBoundParameters['SPA'] = New-Object -TypeName "Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphSPAApplication" -Property @{'RedirectUri' = $PSBoundParameters['SPARedirectUri'] }
      $null = $PSBoundParameters.Remove('SPARedirectUri')
    }
    elseif ($PSBoundParameters['PublicClientRedirectUri']) {
      $PSBoundParameters['PublicClient'] = New-Object -TypeName "Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphPublicClientApplication" -Property @{'RedirectUri' = $PSBoundParameters['PublicClientRedirectUri'] }
      $null = $PSBoundParameters.Remove('PublicClientRedirectUri')
    }
    
    Az.MSGraph.internal\Update-AzADApplication @PSBoundParameters
  }
}

# SIG # Begin signature block
# MIInkwYJKoZIhvcNAQcCoIInhDCCJ4ACAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBkdkV5DBsjJfA1
# kk4WGkhZiQxrJo6Ad16WgxyJ0fj3lqCCDXYwggX0MIID3KADAgECAhMzAAACy7d1
# OfsCcUI2AAAAAALLMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjIwNTEyMjA0NTU5WhcNMjMwNTExMjA0NTU5WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQC3sN0WcdGpGXPZIb5iNfFB0xZ8rnJvYnxD6Uf2BHXglpbTEfoe+mO//oLWkRxA
# wppditsSVOD0oglKbtnh9Wp2DARLcxbGaW4YanOWSB1LyLRpHnnQ5POlh2U5trg4
# 3gQjvlNZlQB3lL+zrPtbNvMA7E0Wkmo+Z6YFnsf7aek+KGzaGboAeFO4uKZjQXY5
# RmMzE70Bwaz7hvA05jDURdRKH0i/1yK96TDuP7JyRFLOvA3UXNWz00R9w7ppMDcN
# lXtrmbPigv3xE9FfpfmJRtiOZQKd73K72Wujmj6/Su3+DBTpOq7NgdntW2lJfX3X
# a6oe4F9Pk9xRhkwHsk7Ju9E/AgMBAAGjggFzMIIBbzAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUrg/nt/gj+BBLd1jZWYhok7v5/w4w
# RQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEW
# MBQGA1UEBRMNMjMwMDEyKzQ3MDUyODAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzci
# tW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEG
# CCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0
# MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAJL5t6pVjIRlQ8j4dAFJ
# ZnMke3rRHeQDOPFxswM47HRvgQa2E1jea2aYiMk1WmdqWnYw1bal4IzRlSVf4czf
# zx2vjOIOiaGllW2ByHkfKApngOzJmAQ8F15xSHPRvNMmvpC3PFLvKMf3y5SyPJxh
# 922TTq0q5epJv1SgZDWlUlHL/Ex1nX8kzBRhHvc6D6F5la+oAO4A3o/ZC05OOgm4
# EJxZP9MqUi5iid2dw4Jg/HvtDpCcLj1GLIhCDaebKegajCJlMhhxnDXrGFLJfX8j
# 7k7LUvrZDsQniJZ3D66K+3SZTLhvwK7dMGVFuUUJUfDifrlCTjKG9mxsPDllfyck
# 4zGnRZv8Jw9RgE1zAghnU14L0vVUNOzi/4bE7wIsiRyIcCcVoXRneBA3n/frLXvd
# jDsbb2lpGu78+s1zbO5N0bhHWq4j5WMutrspBxEhqG2PSBjC5Ypi+jhtfu3+x76N
# mBvsyKuxx9+Hm/ALnlzKxr4KyMR3/z4IRMzA1QyppNk65Ui+jB14g+w4vole33M1
# pVqVckrmSebUkmjnCshCiH12IFgHZF7gRwE4YZrJ7QjxZeoZqHaKsQLRMp653beB
# fHfeva9zJPhBSdVcCW7x9q0c2HVPLJHX9YCUU714I+qtLpDGrdbZxD9mikPqL/To
# /1lDZ0ch8FtePhME7houuoPcMIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkq
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
# /Xmfwb1tbWrJUnMTDXpQzTGCGXMwghlvAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAALLt3U5+wJxQjYAAAAAAsswDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIOn9CW6rI+o8BziG00q9MI4T
# hP8gW3mS9qV8WZIC5/OqMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEARilNPYoCR5tegITYrxYoM9UncHzR5u9lAGMuyE3/YtGV1a9YCxRYXgwD
# cwlvrlVXOyJjZn3f+4mMU92hgGw1lIkW5l7xip1RRuRHvZA28KKafQgtnPmD3xoU
# TL9/FfmpPIAzX+0nk2MODHQYPkoFShwErj6yD1ebtB6Hyk6PPcMQu3g08vCWwr3R
# dUmOWR/87Nwd1b6PDRw8adD0KbWP5LmhZx5OL51DudV37RHBDBRHadLBxQmVw8SI
# WISLPB+FQ9oeXzodLLFqp654OEzp9+6L3e3WHGclysRxhv+rquL5YBDygojr/3jD
# uPklzJfJr1wvT8pbmIkdkuHLClQZyqGCFv0wghb5BgorBgEEAYI3AwMBMYIW6TCC
# FuUGCSqGSIb3DQEHAqCCFtYwghbSAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFRBgsq
# hkiG9w0BCRABBKCCAUAEggE8MIIBOAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCCYtKuhymp+6sOA7KBVFnlxpfNQioRNe5IQgdznJ7klLgIGZDfpAxO1
# GBMyMDIzMDQyMTEzMzI0Ny40NDdaMASAAgH0oIHQpIHNMIHKMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1l
# cmljYSBPcGVyYXRpb25zMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjpFNUE2LUUy
# N0MtNTkyRTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaCC
# EVQwggcMMIIE9KADAgECAhMzAAABvvQgou6W1iDWAAEAAAG+MA0GCSqGSIb3DQEB
# CwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
# EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNV
# BAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMB4XDTIyMTEwNDE5MDEy
# MloXDTI0MDIwMjE5MDEyMlowgcoxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJTAjBgNVBAsTHE1pY3Jvc29mdCBBbWVyaWNhIE9wZXJhdGlvbnMx
# JjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNOOkU1QTYtRTI3Qy01OTJFMSUwIwYDVQQD
# ExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNlMIICIjANBgkqhkiG9w0BAQEF
# AAOCAg8AMIICCgKCAgEApV/y2z7Da7nMu0tykLY8olh7Z03EqFNz3iFlMp9gOfVm
# ZABmheCc87RuPdQ2P+OHUJiqCQAWNuNSoI/Q1ixEw9AA657ldD8Z3/EktpmxKHHa
# vOhwQSFPcpTGFVXIxKCwoO824giyHPG84dfhdi6WU7f7D+85LaPB0dOsPHKKMGlC
# 9p66Lv9yQzvAhZGFmFhlusCy/egrz6JX/OHOT9qCwughrL0IPf47ULe1pQSEEihy
# 438JwS+rZU4AVyvQczlMC26XsTuDPgEQKlzx9ru7EvNV99l/KCU9bbFf5SnkN1mo
# UgKUq09NWlKxzLGEvhke2QNMopn86Jh1fl/PVevN/xrZSpV23rM4lB7lh7XSsCPe
# FslTYojKN2ioOC6p3By7kEmvZCh6rAsPKsARJISdzKQCMq+mqDuiP6mr/LvuWKin
# P+2ZGmK/C1/skvlTjtIehu50yoXNDlh1CN9B3QLglQY+UCBEqJog/BxAn3pWdR01
# o/66XIacgXI/d0wG2/x0OtbjEGAkacfQlmw0bDc02dhQFki/1Q9Vbwh4kC7VgAiJ
# A8bC5zEIYWHNU7C+He69B4/2dZpRjgd5pEpHbF9OYiAf7s5MnYEnHN/5o/bGO0aj
# Ab7VI4f9av62sC6xvhKTB5R4lhxEMWF0z4v7BQ5CHyMNkL+oTnzJLqnLVdXnuM0C
# AwEAAaOCATYwggEyMB0GA1UdDgQWBBTrKiAWoYRBoPGtbwvbhhX6a2+iqjAfBgNV
# HSMEGDAWgBSfpxVdAF5iXYP05dJlpxtTNRnpcjBfBgNVHR8EWDBWMFSgUqBQhk5o
# dHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNyb3NvZnQlMjBU
# aW1lLVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcmwwbAYIKwYBBQUHAQEEYDBeMFwG
# CCsGAQUFBzAChlBodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRz
# L01pY3Jvc29mdCUyMFRpbWUtU3RhbXAlMjBQQ0ElMjAyMDEwKDEpLmNydDAMBgNV
# HRMBAf8EAjAAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMA0GCSqGSIb3DQEBCwUAA4IC
# AQDHlfu9c0ImhdBis1yj56bBvOSyGpC/rSSty+1F49Tf6fmFEeqxhwTTHVHOeIRN
# d8gcDLSz0d79mXCqq8ynq6gJgy2u4LyyAr2LmwzFVuuxoGVR8YuUnRtvsDH5J+un
# ye/nMkwHiC+G82h3uQ8fcGj+2H0nKPmUpUtfQruMUXvzLjV5NyRjDiCL5c/f5ecm
# z01dnpnCvE6kIz/FTpkvOeVJk22I2akFZhPz24D6OT6KkTtwBRpSEHDYqCQ4cZ+7
# SXx7jzzd7b+0p9vDboqCy7SwWgKpGQG+wVbKrTm4hKkZDzcdAEgYqehXz78G00mY
# ILiDTyUikwQpoZ7am9pA6BdTPY+o1v6CRzcneIOnJYanHWz0R+KER/ZRFtLCyBMv
# LzSHEn0sR0+0kLklncKjGdA1YA42zOb611UeIGytZ9VhNwn4ws5GJ6n6PJmMPO+y
# PEkOy2f8OBiuhaqlipiWhzGtt5UsC0geG0sW9qwa4QAW1sQWIrhSl24MOOVwNl/A
# m9/ZqvLRWr1x4nupeR8G7+DNyn4MTg28yFZRU1ktSvyBMUSvN2K99BO6p1gSx/wv
# SsR45dG33PDG5fKqHOgDxctjBU5bX49eJqjNL7S/UndLF7S0OWL9mdk/jPVHP2I6
# XtN0K4VjdRwvIgr3jNib3GZyGJnORp/ZMbY2Dv1mKcx7dTCCB3EwggVZoAMCAQIC
# EzMAAAAVxedrngKbSZkAAAAAABUwDQYJKoZIhvcNAQELBQAwgYgxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMTKU1pY3Jvc29mdCBS
# b290IENlcnRpZmljYXRlIEF1dGhvcml0eSAyMDEwMB4XDTIxMDkzMDE4MjIyNVoX
# DTMwMDkzMDE4MzIyNVowfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwggIi
# MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDk4aZM57RyIQt5osvXJHm9DtWC
# 0/3unAcH0qlsTnXIyjVX9gF/bErg4r25PhdgM/9cT8dm95VTcVrifkpa/rg2Z4VG
# Iwy1jRPPdzLAEBjoYH1qUoNEt6aORmsHFPPFdvWGUNzBRMhxXFExN6AKOG6N7dcP
# 2CZTfDlhAnrEqv1yaa8dq6z2Nr41JmTamDu6GnszrYBbfowQHJ1S/rboYiXcag/P
# XfT+jlPP1uyFVk3v3byNpOORj7I5LFGc6XBpDco2LXCOMcg1KL3jtIckw+DJj361
# VI/c+gVVmG1oO5pGve2krnopN6zL64NF50ZuyjLVwIYwXE8s4mKyzbnijYjklqwB
# Sru+cakXW2dg3viSkR4dPf0gz3N9QZpGdc3EXzTdEonW/aUgfX782Z5F37ZyL9t9
# X4C626p+Nuw2TPYrbqgSUei/BQOj0XOmTTd0lBw0gg/wEPK3Rxjtp+iZfD9M269e
# wvPV2HM9Q07BMzlMjgK8QmguEOqEUUbi0b1qGFphAXPKZ6Je1yh2AuIzGHLXpyDw
# wvoSCtdjbwzJNmSLW6CmgyFdXzB0kZSU2LlQ+QuJYfM2BjUYhEfb3BvR/bLUHMVr
# 9lxSUV0S2yW6r1AFemzFER1y7435UsSFF5PAPBXbGjfHCBUYP3irRbb1Hode2o+e
# FnJpxq57t7c+auIurQIDAQABo4IB3TCCAdkwEgYJKwYBBAGCNxUBBAUCAwEAATAj
# BgkrBgEEAYI3FQIEFgQUKqdS/mTEmr6CkTxGNSnPEP8vBO4wHQYDVR0OBBYEFJ+n
# FV0AXmJdg/Tl0mWnG1M1GelyMFwGA1UdIARVMFMwUQYMKwYBBAGCN0yDfQEBMEEw
# PwYIKwYBBQUHAgEWM2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvRG9j
# cy9SZXBvc2l0b3J5Lmh0bTATBgNVHSUEDDAKBggrBgEFBQcDCDAZBgkrBgEEAYI3
# FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAf
# BgNVHSMEGDAWgBTV9lbLj+iiXGJo0T2UkFvXzpoYxDBWBgNVHR8ETzBNMEugSaBH
# hkVodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNS
# b29DZXJBdXRfMjAxMC0wNi0yMy5jcmwwWgYIKwYBBQUHAQEETjBMMEoGCCsGAQUF
# BzAChj5odHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0Nl
# ckF1dF8yMDEwLTA2LTIzLmNydDANBgkqhkiG9w0BAQsFAAOCAgEAnVV9/Cqt4Swf
# ZwExJFvhnnJL/Klv6lwUtj5OR2R4sQaTlz0xM7U518JxNj/aZGx80HU5bbsPMeTC
# j/ts0aGUGCLu6WZnOlNN3Zi6th542DYunKmCVgADsAW+iehp4LoJ7nvfam++Kctu
# 2D9IdQHZGN5tggz1bSNU5HhTdSRXud2f8449xvNo32X2pFaq95W2KFUn0CS9QKC/
# GbYSEhFdPSfgQJY4rPf5KYnDvBewVIVCs/wMnosZiefwC2qBwoEZQhlSdYo2wh3D
# YXMuLGt7bj8sCXgU6ZGyqVvfSaN0DLzskYDSPeZKPmY7T7uG+jIa2Zb0j/aRAfbO
# xnT99kxybxCrdTDFNLB62FD+CljdQDzHVG2dY3RILLFORy3BFARxv2T5JL5zbcqO
# Cb2zAVdJVGTZc9d/HltEAY5aGZFrDZ+kKNxnGSgkujhLmm77IVRrakURR6nxt67I
# 6IleT53S0Ex2tVdUCbFpAUR+fKFhbHP+CrvsQWY9af3LwUFJfn6Tvsv4O+S3Fb+0
# zj6lMVGEvL8CwYKiexcdFYmNcP7ntdAoGokLjzbaukz5m/8K6TT4JDVnK+ANuOaM
# mdbhIurwJ0I9JZTmdHRbatGePu1+oDEzfbzL6Xu/OHBE0ZDxyKs6ijoIYn/ZcGNT
# TY3ugm2lBRDBcQZqELQdVTNYs6FwZvKhggLLMIICNAIBATCB+KGB0KSBzTCByjEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjElMCMGA1UECxMcTWlj
# cm9zb2Z0IEFtZXJpY2EgT3BlcmF0aW9uczEmMCQGA1UECxMdVGhhbGVzIFRTUyBF
# U046RTVBNi1FMjdDLTU5MkUxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFNlcnZpY2WiIwoBATAHBgUrDgMCGgMVAGitWlL3vPu8ENOAe+i2+4wfTMB7oIGD
# MIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNV
# BAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQG
# A1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwDQYJKoZIhvcNAQEF
# BQACBQDn7PNRMCIYDzIwMjMwNDIxMTkzNDQxWhgPMjAyMzA0MjIxOTM0NDFaMHQw
# OgYKKwYBBAGEWQoEATEsMCowCgIFAOfs81ECAQAwBwIBAAICH5UwBwIBAAICEjMw
# CgIFAOfuRNECAQAwNgYKKwYBBAGEWQoEAjEoMCYwDAYKKwYBBAGEWQoDAqAKMAgC
# AQACAwehIKEKMAgCAQACAwGGoDANBgkqhkiG9w0BAQUFAAOBgQCwRiimE1HoWAiv
# uyLryhf0NvpdD28OSntjSO1dqiySKCRCPQH0r31kZx8EPMOLJjhQxcTmt7sCGhBL
# +F86hiUsIWMeOYuqjUKehupl0W6Xj+W4N4zlI9toGejmzI2vMg9Jn7vvczfBpPmP
# KDLOpmlshjQRITmAvDwUoVUSCxQIJjGCBA0wggQJAgEBMIGTMHwxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBU
# aW1lLVN0YW1wIFBDQSAyMDEwAhMzAAABvvQgou6W1iDWAAEAAAG+MA0GCWCGSAFl
# AwQCAQUAoIIBSjAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwLwYJKoZIhvcN
# AQkEMSIEIMZbxfyonTJMvcUG8Vbv60mG5pXvc7hhFSs/Z7a68hDJMIH6BgsqhkiG
# 9w0BCRACLzGB6jCB5zCB5DCBvQQglO6Kr632/Oy9ZbXPrhEPidNAg/Fef7K3SZg+
# DxjhDC8wgZgwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3Rv
# bjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0
# aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAITMwAA
# Ab70IKLultYg1gABAAABvjAiBCAIXIjN3TUxfoH8+zhS3oMKIocPvKxdal3c7vzT
# kA9yJDANBgkqhkiG9w0BAQsFAASCAgBKbhwo3HfX28DQdWIKGjAI/dRnyPmKY2AI
# VpdTqN4VGxQ+heJvXuwOTcrpAbgbDMSDaZmKomLSRBcTlkag1PM14d8reRRUg3tP
# QjpfXZtR27n3OOS1y72vdHgvvRG+6wYlG1HQGazbDpvcS4tVlm3/7TVL/o7VF9e+
# PNd8Ny2wvmY0mQrnSeQGJSESEKdauxjeNiW+2OAt/TWaUuglKbwWre9O2/VS6eAI
# TWa8TcCRT4z8QgeZQ48UByCDcue/kQVaFvLaeCRAgVy1cJoSjm9GI6N26cksJQsD
# k1o1wmCfnzcZ5r7vg0RgyE3Rae91jsyYGeuCLa74H27QCHx52JyOrXRAPILyTY3a
# odElOPgySBfZGzMjl2WRwphb6Wt+/WradVx7VFV5/XDLayNHsYeo1mB97WyXBzXg
# lKOXW2jc+Or72501uHQObK6F51G/iKrvJlXKvyPIgtIi+glGCLeBySunsHvdl1RZ
# pqu1o9DkxPnj3aQiOhenKaUVJrEEHfHjma695PVIAR0IQDuOPmxP8pPGIemFsmH3
# dLslnnwdFZsWgRM6AOvf8JgXLJQcFZzeFwtJ5EqzcBvCsBDj3q0JGgIglQuNvOjh
# dYEEx58yzG+bL+KhbY7PAk7bJYrSrhgMDDr4tbHGRb7rbhlfgoFFoyHvYS0ixZv3
# AFeDGgamdw==
# SIG # End signature block
