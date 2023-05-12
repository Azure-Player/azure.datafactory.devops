
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
Adds new entity to servicePrincipals
.Description
Adds new entity to servicePrincipals
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

BODY <IMicrosoftGraphServicePrincipal>: Represents an Azure Active Directory object. The directoryObject type is the base type for many other directory entity types.
  [(Any) <Object>]: This indicates any property can be added to this object.
  [DeletedDateTime <DateTime?>]: 
  [AccountEnabled <Boolean?>]: true if the service principal account is enabled; otherwise, false. Supports $filter (eq, ne, NOT, in).
  [AddIn <IMicrosoftGraphAddIn[]>]: Defines custom behavior that a consuming service can use to call an app in specific contexts. For example, applications that can render file streams may set the addIns property for its 'FileHandler' functionality. This will let services like Microsoft 365 call the application in the context of a document the user is working on.
    [Id <String>]: 
    [Property <IMicrosoftGraphKeyValue[]>]: 
      [Key <String>]: Key.
      [Value <String>]: Value.
    [Type <String>]: 
  [AlternativeName <String[]>]: Used to retrieve service principals by subscription, identify resource group and full resource ids for managed identities. Supports $filter (eq, NOT, ge, le, startsWith).
  [AppDescription <String>]: The description exposed by the associated application.
  [AppDisplayName <String>]: The display name exposed by the associated application.
  [AppId <String>]: The unique identifier for the associated application (its appId property).
  [AppOwnerOrganizationId <String>]: Contains the tenant id where the application is registered. This is applicable only to service principals backed by applications.Supports $filter (eq, ne, NOT, ge, le).
  [AppRole <IMicrosoftGraphAppRole[]>]: The roles exposed by the application which this service principal represents. For more information see the appRoles property definition on the application entity. Not nullable.
    [AllowedMemberType <String[]>]: Specifies whether this app role can be assigned to users and groups (by setting to ['User']), to other application's (by setting to ['Application'], or both (by setting to ['User', 'Application']). App roles supporting assignment to other applications' service principals are also known as application permissions. The 'Application' value is only supported for app roles defined on application entities.
    [Description <String>]: The description for the app role. This is displayed when the app role is being assigned and, if the app role functions as an application permission, during  consent experiences.
    [DisplayName <String>]: Display name for the permission that appears in the app role assignment and consent experiences.
    [Id <String>]: Unique role identifier inside the appRoles collection. When creating a new app role, a new Guid identifier must be provided.
    [IsEnabled <Boolean?>]: When creating or updating an app role, this must be set to true (which is the default). To delete a role, this must first be set to false.  At that point, in a subsequent call, this role may be removed.
    [Origin <String>]: Specifies if the app role is defined on the application object or on the servicePrincipal entity. Must not be included in any POST or PATCH requests. Read-only.
    [Value <String>]: Specifies the value to include in the roles claim in ID tokens and access tokens authenticating an assigned user or service principal. Must not exceed 120 characters in length. Allowed characters are : ! # $ % & ' ( ) * + , - . / : ;  =  ? @ [ ] ^ + _  {  } ~, as well as characters in the ranges 0-9, A-Z and a-z. Any other character, including the space character, are not allowed. May not begin with ..
  [AppRoleAssignedTo <IMicrosoftGraphAppRoleAssignment[]>]: App role assignments for this app or service, granted to users, groups, and other service principals.Supports $expand.
    [DeletedDateTime <DateTime?>]: 
    [AppRoleId <String>]: The identifier (id) for the app role which is assigned to the principal. This app role must be exposed in the appRoles property on the resource application's service principal (resourceId). If the resource application has not declared any app roles, a default app role ID of 00000000-0000-0000-0000-000000000000 can be specified to signal that the principal is assigned to the resource app without any specific app roles. Required on create.
    [PrincipalId <String>]: The unique identifier (id) for the user, group or service principal being granted the app role. Required on create.
    [ResourceDisplayName <String>]: The display name of the resource app's service principal to which the assignment is made.
    [ResourceId <String>]: The unique identifier (id) for the resource service principal for which the assignment is made. Required on create. Supports $filter (eq only).
  [AppRoleAssignment <IMicrosoftGraphAppRoleAssignment[]>]: App role assignment for another app or service, granted to this service principal. Supports $expand.
  [AppRoleAssignmentRequired <Boolean?>]: Specifies whether users or other service principals need to be granted an app role assignment for this service principal before users can sign in or apps can get tokens. The default value is false. Not nullable. Supports $filter (eq, ne, NOT).
  [ClaimsMappingPolicy <IMicrosoftGraphClaimsMappingPolicy[]>]: The claimsMappingPolicies assigned to this service principal. Supports $expand.
    [AppliesTo <IMicrosoftGraphDirectoryObject[]>]: 
      [DeletedDateTime <DateTime?>]: 
    [Definition <String[]>]: A string collection containing a JSON string that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required.
    [IsOrganizationDefault <Boolean?>]: If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false.
    [Description <String>]: Description for this policy.
    [DisplayName <String>]: Display name for this policy.
    [DeletedDateTime <DateTime?>]: 
  [DelegatedPermissionClassification <IMicrosoftGraphDelegatedPermissionClassification[]>]: The permission classifications for delegated permissions exposed by the app that this service principal represents. Supports $expand.
    [Classification <String>]: permissionClassificationType
    [PermissionId <String>]: The unique identifier (id) for the delegated permission listed in the publishedPermissionScopes collection of the servicePrincipal. Required on create. Does not support $filter.
    [PermissionName <String>]: The claim value (value) for the delegated permission listed in the publishedPermissionScopes collection of the servicePrincipal. Does not support $filter.
  [Description <String>]: Free text field to provide an internal end-user facing description of the service principal. End-user portals such MyApps will display the application description in this field. The maximum allowed size is 1024 characters. Supports $filter (eq, ne, NOT, ge, le, startsWith) and $search.
  [DisabledByMicrosoftStatus <String>]: Specifies whether Microsoft has disabled the registered application. Possible values are: null (default value), NotDisabled, and DisabledDueToViolationOfServicesAgreement (reasons may include suspicious, abusive, or malicious activity, or a violation of the Microsoft Services Agreement).  Supports $filter (eq, ne, NOT).
  [DisplayName <String>]: The display name for the service principal. Supports $filter (eq, ne, NOT, ge, le, in, startsWith), $search, and $orderBy.
  [Endpoint <IMicrosoftGraphEndpoint[]>]: Endpoints available for discovery. Services like Sharepoint populate this property with a tenant specific SharePoint endpoints that other applications can discover and use in their experiences.
    [DeletedDateTime <DateTime?>]: 
    [Capability <String>]: Describes the capability that is associated with this resource. (e.g. Messages, Conversations, etc.)  Not nullable. Read-only.
    [ProviderId <String>]: Application id of the publishing underlying service. Not nullable. Read-only.
    [ProviderName <String>]: Name of the publishing underlying service. Read-only.
    [ProviderResourceId <String>]: For Microsoft 365 groups, this is set to a well-known name for the resource (e.g. Yammer.FeedURL etc.). Not nullable. Read-only.
    [Uri <String>]: URL of the published resource. Not nullable. Read-only.
  [HomeRealmDiscoveryPolicy <IMicrosoftGraphHomeRealmDiscoveryPolicy[]>]: The homeRealmDiscoveryPolicies assigned to this service principal. Supports $expand.
    [AppliesTo <IMicrosoftGraphDirectoryObject[]>]: 
    [Definition <String[]>]: A string collection containing a JSON string that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required.
    [IsOrganizationDefault <Boolean?>]: If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false.
    [Description <String>]: Description for this policy.
    [DisplayName <String>]: Display name for this policy.
    [DeletedDateTime <DateTime?>]: 
  [Homepage <String>]: Home page or landing page of the application.
  [Info <IMicrosoftGraphInformationalUrl>]: informationalUrl
    [(Any) <Object>]: This indicates any property can be added to this object.
    [LogoUrl <String>]: CDN URL to the application's logo, Read-only.
    [MarketingUrl <String>]: Link to the application's marketing page. For example, https://www.contoso.com/app/marketing
    [PrivacyStatementUrl <String>]: Link to the application's privacy statement. For example, https://www.contoso.com/app/privacy
    [SupportUrl <String>]: Link to the application's support page. For example, https://www.contoso.com/app/support
    [TermsOfServiceUrl <String>]: Link to the application's terms of service statement. For example, https://www.contoso.com/app/termsofservice
  [KeyCredentials <IMicrosoftGraphKeyCredential[]>]: The collection of key credentials associated with the service principal. Not nullable. Supports $filter (eq, NOT, ge, le).
    [CustomKeyIdentifier <Byte[]>]: Custom key identifier
    [DisplayName <String>]: Friendly name for the key. Optional.
    [EndDateTime <DateTime?>]: The date and time at which the credential expires.The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
    [Key <Byte[]>]: Value for the key credential. Should be a base 64 encoded value.
    [KeyId <String>]: The unique identifier (GUID) for the key.
    [StartDateTime <DateTime?>]: The date and time at which the credential becomes valid.The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
    [Type <String>]: The type of key credential; for example, 'Symmetric'.
    [Usage <String>]: A string that describes the purpose for which the key can be used; for example, 'Verify'.
  [LoginUrl <String>]: Specifies the URL where the service provider redirects the user to Azure AD to authenticate. Azure AD uses the URL to launch the application from Microsoft 365 or the Azure AD My Apps. When blank, Azure AD performs IdP-initiated sign-on for applications configured with SAML-based single sign-on. The user launches the application from Microsoft 365, the Azure AD My Apps, or the Azure AD SSO URL.
  [LogoutUrl <String>]: Specifies the URL that will be used by Microsoft's authorization service to logout an user using OpenId Connect front-channel, back-channel or SAML logout protocols.
  [Note <String>]: Free text field to capture information about the service principal, typically used for operational purposes. Maximum allowed size is 1024 characters.
  [NotificationEmailAddress <String[]>]: Specifies the list of email addresses where Azure AD sends a notification when the active certificate is near the expiration date. This is only for the certificates used to sign the SAML token issued for Azure AD Gallery applications.
  [Oauth2PermissionScope <IMicrosoftGraphPermissionScope[]>]: The delegated permissions exposed by the application. For more information see the oauth2PermissionScopes property on the application entity's api property. Not nullable.
    [AdminConsentDescription <String>]: A description of the delegated permissions, intended to be read by an administrator granting the permission on behalf of all users. This text appears in tenant-wide admin consent experiences.
    [AdminConsentDisplayName <String>]: The permission's title, intended to be read by an administrator granting the permission on behalf of all users.
    [Id <String>]: Unique delegated permission identifier inside the collection of delegated permissions defined for a resource application.
    [IsEnabled <Boolean?>]: When creating or updating a permission, this property must be set to true (which is the default). To delete a permission, this property must first be set to false.  At that point, in a subsequent call, the permission may be removed.
    [Origin <String>]: 
    [Type <String>]: Specifies whether this delegated permission should be considered safe for non-admin users to consent to on behalf of themselves, or whether an administrator should be required for consent to the permissions. This will be the default behavior, but each customer can choose to customize the behavior in their organization (by allowing, restricting or limiting user consent to this delegated permission.)
    [UserConsentDescription <String>]: A description of the delegated permissions, intended to be read by a user granting the permission on their own behalf. This text appears in consent experiences where the user is consenting only on behalf of themselves.
    [UserConsentDisplayName <String>]: A title for the permission, intended to be read by a user granting the permission on their own behalf. This text appears in consent experiences where the user is consenting only on behalf of themselves.
    [Value <String>]: Specifies the value to include in the scp (scope) claim in access tokens. Must not exceed 120 characters in length. Allowed characters are : ! # $ % & ' ( ) * + , - . / : ;  =  ? @ [ ] ^ + _  {  } ~, as well as characters in the ranges 0-9, A-Z and a-z. Any other character, including the space character, are not allowed. May not begin with ..
  [PasswordCredentials <IMicrosoftGraphPasswordCredential[]>]: The collection of password credentials associated with the service principal. Not nullable.
    [CustomKeyIdentifier <Byte[]>]: Do not use.
    [DisplayName <String>]: Friendly name for the password. Optional.
    [EndDateTime <DateTime?>]: The date and time at which the password expires represented using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Optional.
    [KeyId <String>]: The unique identifier for the password.
    [StartDateTime <DateTime?>]: The date and time at which the password becomes valid. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Optional.
  [PreferredSingleSignOnMode <String>]: Specifies the single sign-on mode configured for this application. Azure AD uses the preferred single sign-on mode to launch the application from Microsoft 365 or the Azure AD My Apps. The supported values are password, saml, notSupported, and oidc.
  [PreferredTokenSigningKeyThumbprint <String>]: Reserved for internal use only. Do not write or otherwise rely on this property. May be removed in future versions.
  [ReplyUrl <String[]>]: The URLs that user tokens are sent to for sign in with the associated application, or the redirect URIs that OAuth 2.0 authorization codes and access tokens are sent to for the associated application. Not nullable.
  [SamlSingleSignOnSetting <IMicrosoftGraphSamlSingleSignOnSettings>]: samlSingleSignOnSettings
    [(Any) <Object>]: This indicates any property can be added to this object.
    [RelayState <String>]: The relative URI the service provider would redirect to after completion of the single sign-on flow.
  [ServicePrincipalName <String[]>]: Contains the list of identifiersUris, copied over from the associated application. Additional values can be added to hybrid applications. These values can be used to identify the permissions exposed by this app within Azure AD. For example,Client apps can specify a resource URI which is based on the values of this property to acquire an access token, which is the URI returned in the 'aud' claim.The any operator is required for filter expressions on multi-valued properties. Not nullable.  Supports $filter (eq, NOT, ge, le, startsWith).
  [ServicePrincipalType <String>]: Identifies if the service principal represents an application or a managed identity. This is set by Azure AD internally. For a service principal that represents an application this is set as Application. For a service principal that represent a managed identity this is set as ManagedIdentity.
  [Tag <String[]>]: Custom strings that can be used to categorize and identify the service principal. Not nullable. Supports $filter (eq, NOT, ge, le, startsWith).
  [TokenEncryptionKeyId <String>]: Specifies the keyId of a public key from the keyCredentials collection. When configured, Azure AD issues tokens for this application encrypted using the key specified by this property. The application code that receives the encrypted token must use the matching private key to decrypt the token before it can be used for the signed-in user.
  [TokenIssuancePolicy <IMicrosoftGraphTokenIssuancePolicy[]>]: The tokenIssuancePolicies assigned to this service principal. Supports $expand.
    [AppliesTo <IMicrosoftGraphDirectoryObject[]>]: 
    [Definition <String[]>]: A string collection containing a JSON string that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required.
    [IsOrganizationDefault <Boolean?>]: If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false.
    [Description <String>]: Description for this policy.
    [DisplayName <String>]: Display name for this policy.
    [DeletedDateTime <DateTime?>]: 
  [TokenLifetimePolicy <IMicrosoftGraphTokenLifetimePolicy[]>]: The tokenLifetimePolicies assigned to this service principal. Supports $expand.
    [AppliesTo <IMicrosoftGraphDirectoryObject[]>]: 
    [Definition <String[]>]: A string collection containing a JSON string that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required.
    [IsOrganizationDefault <Boolean?>]: If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false.
    [Description <String>]: Description for this policy.
    [DisplayName <String>]: Display name for this policy.
    [DeletedDateTime <DateTime?>]: 
  [TransitiveMemberOf <IMicrosoftGraphDirectoryObject[]>]: 

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
https://learn.microsoft.com/powershell/module/az.resources/new-azadserviceprincipal
#>
function New-AzADServicePrincipal {
  [OutputType([Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphServicePrincipal])]
  [CmdletBinding(DefaultParameterSetName = 'SimpleParameterSet', PositionalBinding = $false, SupportsShouldProcess, ConfirmImpact = 'Medium')]
  param(
    [Parameter(ParameterSetName = 'DisplayNameWithPasswordCredentialParameterSet', Mandatory)]
    [Parameter(ParameterSetName = 'DisplayNameWithKeyCredentialParameterSet', Mandatory)]
    [Parameter(ParameterSetName = 'DisplayNameWithKeyPlainParameterSet', Mandatory)]
    [Parameter(ParameterSetName = 'SimpleParameterSet')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The display name for the service principal.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith), $search, and $orderBy.
    ${DisplayName},

    [Parameter(ParameterSetName = 'ApplicationObjectParameterSet', Mandatory, ValueFromPipeline, HelpMessage = "The application object, could be used as pipeline input.")]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphApplication]
    ${ApplicationObject},

    [Parameter(ParameterSetName = 'ApplicationIdParameterSet')]
    [Alias('AppId')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.Guid]
    # The unique identifier for the associated application (its appId property).
    ${ApplicationId},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The role that the service principal has over the scope.
    ${Role},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The scope that the service principal has permissions for.
    ${Scope},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Home page or landing page of the application.
    ${Homepage},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # The URLs that user tokens are sent to for sign in with the associated application, or the redirect URIs that OAuth 2.0 authorization codes and access tokens are sent to for the associated application.
    # Not nullable.
    ${ReplyUrl},

    [Parameter(ParameterSetName = 'DisplayNameWithKeyPlainParameterSet', Mandatory, HelpMessage = "The value of the 'asymmetric' credential type. It represents the base 64 encoded certificate.")]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    ${CertValue},

    [Parameter(ParameterSetName = 'DisplayNameWithKeyPlainParameterSet', HelpMessage = "The effective start date of the credential usage. The default start date value is today. For an 'asymmetric' type credential, this must be set to on or after the date that the X509 certificate is valid from.")]
    [Parameter(ParameterSetName = 'SimpleParameterSet')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.DateTime]
    ${StartDate},

    [Parameter(ParameterSetName = 'DisplayNameWithKeyPlainParameterSet', HelpMessage = "The effective end date of the credential usage. The default end date value is one year from today. For an 'asymmetric' type credential, this must be set to on or before the date that the X509 certificate is valid.")]
    [Parameter(ParameterSetName = 'SimpleParameterSet', HelpMessage = "The effective end date of the credential usage. The default end date value is one year from today. For an 'asymmetric' type credential, this must be set to on or before the date that the X509 certificate is valid.")]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.DateTime]
    ${EndDate},

    [Parameter(ParameterSetName = 'DisplayNameWithKeyCredentialParameterSet', Mandatory, HelpMessage = "key credentials associated with the service principal.")]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphKeyCredential[]]
    [Alias("KeyCredentials")]
    # The collection of key credentials associated with the service principal.
    # Not nullable.
    # Supports $filter (eq, NOT, ge, le).
    # To construct, see NOTES section for KEYCREDENTIALS properties and create a hash table.
    ${KeyCredential},

    [Parameter(ParameterSetName = 'DisplayNameWithPasswordCredentialParameterSet', Mandatory, HelpMessage = "Password credentials associated with the service principal.")]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphPasswordCredential[]]
    [Alias("PasswordCredentials")]
    # The collection of password credentials associated with the service principal.
    # Not nullable.
    # To construct, see NOTES section for PASSWORDCREDENTIALS properties and create a hash table.
    ${PasswordCredential},

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
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphSamlSingleSignOnSettings]
    # samlSingleSignOnSettings
    # To construct, see NOTES section for SAMLSINGLESIGNONSETTING properties and create a hash table.
    ${SamlSingleSignOnSetting},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # Contains the list of identifiersUris, copied over from the associated application.
    # Additional values can be added to hybrid applications.
    # These values can be used to identify the permissions exposed by this app within Azure AD.
    # For example,Client apps can specify a resource URI which is based on the values of this property to acquire an access token, which is the URI returned in the 'aud' claim.The any operator is required for filter expressions on multi-valued properties.
    # Not nullable.
    # Supports $filter (eq, NOT, ge, le, startsWith).
    ${ServicePrincipalName},

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
    [Alias('AzureRMContext', 'AzureCredential')]
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
    if ($PSBoundParameters['Role']) {
      $spRole = $PSBoundParameters['Role']
      $null = $PSBoundParameters.Remove('Role')
    }
    if ($PSBoundParameters['Scope']) {
      $spScope = $PSBoundParameters['Scope']
      $null = $PSBoundParameters.Remove('Scope')
    }
    
    $param = @{}
    if ($PSBoundParameters['Debug']) {
      $param['Debug'] = $PSBoundParameters['Debug']
    }

    if ($PSBoundParameters['ApplicationObject']) {
      $PSBoundParameters['AppId'] = $PSBoundParameters['ApplicationObject'].AppId
      $null = $PSBoundParameters.Remove('ApplicationObject')
    } elseif ($PSBoundParameters['ApplicationId']) {
      $PSBoundParameters['AppId'] = $PSBoundParameters['ApplicationId']
      $null = $PSBoundParameters.Remove('ApplicationId')
    } else {
      if (!$PSBoundParameters['DisplayName']) {
        $param['DisplayName'] = "azure-powershell-" + (Get-Date).ToString("MM-dd-yyyy-HH-mm-ss")
      } else {
        $param['DisplayName'] = $PSBoundParameters['DisplayName']
        $null = $PSBoundParameters.Remove('DisplayName')
      }

      if ($PSBoundParameters['PasswordCredential']) {
        $param['PasswordCredentials'] = $PSBoundParameters['PasswordCredential']
        $null = $PSBoundParameters.Remove('PasswordCredential')
      } elseif ($PSBoundParameters['KeyCredential']) {
        $param['KeyCredentials'] = $PSBoundParameters['KeyCredential']
        $null = $PSBoundParameters.Remove('KeyCredential')
      } else {
        if (!$PSBoundParameters['StartDate']) {
          $param['StartDate'] = [System.DateTime]::UtcNow
        } else {
          $param['StartDate'] = $PSBoundParameters['StartDate']
          $null = $PSBoundParameters.Remove('StartDate')
        }
        if (!$PSBoundParameters['EndDate']) {
          $param['EndDate'] = $param['StartDate'].AddYears(1)
        } else {
          $param['EndDate'] = $PSBoundParameters['EndDate']
          $null = $PSBoundParameters.Remove('EndDate')
        }
        if ($PSBoundParameters['CertValue']) {
          $param['CertValue'] = $PSBoundParameters['CertValue']
          $null = $PSBoundParameters.Remove('CertValue') 
        }
      }

      $app = New-AzADApplication @param
      $PSBoundParameters['AppId'] = $app.AppId
    }

    $sp = Az.MSGraph.internal\New-AzADServicePrincipal @PSBoundParameters
    if ($app) {
      $sp.PasswordCredentials = $app.PasswordCredentials
    }

    $PSCmdlet.WriteObject($sp)

    if ($spRole) {
      $param = @{'ObjectId' = $sp.Id; 'RoleDefinitionName' = $spRole}
      if ($PSBoundParameters['Debug']) {
        $param['Debug'] = $PSBoundParameters['Debug']
      }
      if ($spScope) {
        $param['Scope'] = $spScope
      }
      $param['ObjectType'] = "ServicePrincipal"
      $ra = New-AzRoleAssignment @param
      Write-Verbose "Role assignment with role $($ra.RoleDefinitionName) and scope $($ra.Scope) successfully created for the created service principal."
    }
  }
}
# SIG # Begin signature block
# MIInzgYJKoZIhvcNAQcCoIInvzCCJ7sCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCkwVQNXqJBJtKQ
# NDkFGMmsQnbLnbIzi+vuOS0S9sYzZKCCDYUwggYDMIID66ADAgECAhMzAAACzfNk
# v/jUTF1RAAAAAALNMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjIwNTEyMjA0NjAyWhcNMjMwNTExMjA0NjAyWjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDrIzsY62MmKrzergm7Ucnu+DuSHdgzRZVCIGi9CalFrhwtiK+3FIDzlOYbs/zz
# HwuLC3hir55wVgHoaC4liQwQ60wVyR17EZPa4BQ28C5ARlxqftdp3H8RrXWbVyvQ
# aUnBQVZM73XDyGV1oUPZGHGWtgdqtBUd60VjnFPICSf8pnFiit6hvSxH5IVWI0iO
# nfqdXYoPWUtVUMmVqW1yBX0NtbQlSHIU6hlPvo9/uqKvkjFUFA2LbC9AWQbJmH+1
# uM0l4nDSKfCqccvdI5l3zjEk9yUSUmh1IQhDFn+5SL2JmnCF0jZEZ4f5HE7ykDP+
# oiA3Q+fhKCseg+0aEHi+DRPZAgMBAAGjggGCMIIBfjAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQU0WymH4CP7s1+yQktEwbcLQuR9Zww
# VAYDVR0RBE0wS6RJMEcxLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVsYW5kIE9wZXJh
# dGlvbnMgTGltaXRlZDEWMBQGA1UEBRMNMjMwMDEyKzQ3MDUzMDAfBgNVHSMEGDAW
# gBRIbmTlUAXTgqoXNzcitW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8v
# d3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIw
# MTEtMDctMDguY3JsMGEGCCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDEx
# XzIwMTEtMDctMDguY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIB
# AE7LSuuNObCBWYuttxJAgilXJ92GpyV/fTiyXHZ/9LbzXs/MfKnPwRydlmA2ak0r
# GWLDFh89zAWHFI8t9JLwpd/VRoVE3+WyzTIskdbBnHbf1yjo/+0tpHlnroFJdcDS
# MIsH+T7z3ClY+6WnjSTetpg1Y/pLOLXZpZjYeXQiFwo9G5lzUcSd8YVQNPQAGICl
# 2JRSaCNlzAdIFCF5PNKoXbJtEqDcPZ8oDrM9KdO7TqUE5VqeBe6DggY1sZYnQD+/
# LWlz5D0wCriNgGQ/TWWexMwwnEqlIwfkIcNFxo0QND/6Ya9DTAUykk2SKGSPt0kL
# tHxNEn2GJvcNtfohVY/b0tuyF05eXE3cdtYZbeGoU1xQixPZAlTdtLmeFNly82uB
# VbybAZ4Ut18F//UrugVQ9UUdK1uYmc+2SdRQQCccKwXGOuYgZ1ULW2u5PyfWxzo4
# BR++53OB/tZXQpz4OkgBZeqs9YaYLFfKRlQHVtmQghFHzB5v/WFonxDVlvPxy2go
# a0u9Z+ZlIpvooZRvm6OtXxdAjMBcWBAsnBRr/Oj5s356EDdf2l/sLwLFYE61t+ME
# iNYdy0pXL6gN3DxTVf2qjJxXFkFfjjTisndudHsguEMk8mEtnvwo9fOSKT6oRHhM
# 9sZ4HTg/TTMjUljmN3mBYWAWI5ExdC1inuog0xrKmOWVMIIHejCCBWKgAwIBAgIK
# YQ6Q0gAAAAAAAzANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlm
# aWNhdGUgQXV0aG9yaXR5IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEw
# OTA5WjB+MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYD
# VQQDEx9NaWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+la
# UKq4BjgaBEm6f8MMHt03a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc
# 6Whe0t+bU7IKLMOv2akrrnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4D
# dato88tt8zpcoRb0RrrgOGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+
# lD3v++MrWhAfTVYoonpy4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nk
# kDstrjNYxbc+/jLTswM9sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6
# A4aN91/w0FK/jJSHvMAhdCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmd
# X4jiJV3TIUs+UsS1Vz8kA/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL
# 5zmhD+kjSbwYuER8ReTBw3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zd
# sGbiwZeBe+3W7UvnSSmnEyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3
# T8HhhUSJxAlMxdSlQy90lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS
# 4NaIjAsCAwEAAaOCAe0wggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRI
# bmTlUAXTgqoXNzcitW2oynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAL
# BgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBD
# uRQFTuHqp8cx0SOJNDBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jv
# c29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3JsMF4GCCsGAQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3J0MIGfBgNVHSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEF
# BQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1h
# cnljcHMuaHRtMEAGCCsGAQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkA
# YwB5AF8AcwB0AGEAdABlAG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn
# 8oalmOBUeRou09h0ZyKbC5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7
# v0epo/Np22O/IjWll11lhJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0b
# pdS1HXeUOeLpZMlEPXh6I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/
# KmtYSWMfCWluWpiW5IP0wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvy
# CInWH8MyGOLwxS3OW560STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBp
# mLJZiWhub6e3dMNABQamASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJi
# hsMdYzaXht/a8/jyFqGaJ+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYb
# BL7fQccOKO7eZS/sl/ahXJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbS
# oqKfenoi+kiVH6v7RyOA9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sL
# gOppO6/8MO0ETI7f33VtY5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtX
# cVZOSEXAQsmbdlsKgEhr/Xmfwb1tbWrJUnMTDXpQzTGCGZ8wghmbAgEBMIGVMH4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01p
# Y3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTECEzMAAALN82S/+NRMXVEAAAAA
# As0wDQYJYIZIAWUDBAIBBQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIEcl
# /RF1WLghj7kAtfTr2SoVu3SnX4VlLFcSTm+xxK3+MEIGCisGAQQBgjcCAQwxNDAy
# oBSAEgBNAGkAYwByAG8AcwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20wDQYJKoZIhvcNAQEBBQAEggEA5rbJ13GzwmbaiKDmMPmleZ0bdiV5baUJ9DyT
# IqjKTcWSUmieRKuyCXzIyItK3KGFtcTZbUrgXvtv6Prk1UW7Z8EM9cJy3h0vMTdS
# lWXt+uJFjD2n7GiCIe8WfsNc07jkVm9jEgpmZhSB3GtCLCJOeDIfAksT3nbOSflv
# lAelo6kE2bzz1E9FuMKdk89ZCMofMbQznsYJrKS3q8Pu7blAW9PPAYsM+dA6ORXz
# CNna5JuZLIzSiOsaAmoRDsjKtdii20Rikwgzn+vusDHmzaqtKtY5tNrTi83s/ebn
# TaYtK3BHmuy3D44/CiJd1vwnJNRmeSDG2rxY0wIMv0repEzOg6GCFykwghclBgor
# BgEEAYI3AwMBMYIXFTCCFxEGCSqGSIb3DQEHAqCCFwIwghb+AgEDMQ8wDQYJYIZI
# AWUDBAIBBQAwggFZBgsqhkiG9w0BCRABBKCCAUgEggFEMIIBQAIBAQYKKwYBBAGE
# WQoDATAxMA0GCWCGSAFlAwQCAQUABCDS4QPyoPaCo4/wGwwOlJiP7TQzGJeOmdqq
# 3XdKurt1VAIGY/dYye9PGBMyMDIzMDMwNjA2NTMwMi4wNzNaMASAAgH0oIHYpIHV
# MIHSMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQL
# EyRNaWNyb3NvZnQgSXJlbGFuZCBPcGVyYXRpb25zIExpbWl0ZWQxJjAkBgNVBAsT
# HVRoYWxlcyBUU1MgRVNOOkQwODItNEJGRC1FRUJBMSUwIwYDVQQDExxNaWNyb3Nv
# ZnQgVGltZS1TdGFtcCBTZXJ2aWNloIIReDCCBycwggUPoAMCAQICEzMAAAG6Hz8Z
# 98F1vXwAAQAAAbowDQYJKoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAg
# UENBIDIwMTAwHhcNMjIwOTIwMjAyMjE5WhcNMjMxMjE0MjAyMjE5WjCB0jELMAkG
# A1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQx
# HjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9z
# b2Z0IElyZWxhbmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMg
# VFNTIEVTTjpEMDgyLTRCRkQtRUVCQTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgU2VydmljZTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIhO
# FYMzkjWAE9UVnXF9hRGv0xBRxc+I5Hu3hxVFXyK3u38xusEb0pLkwjgGtDsaLLbr
# lMxqX3tFb/3BgEPEC3L0wX76gD8zHt+wiBV5mq5BWop29qRrgMJKKCPcpQnSjs9B
# /4XMFFvrpdPicZDv43FLgz9fHqMq0LJDw5JAHGDS30TCY9OF43P4d44Z9lE7CaVS
# 2pJMF3L453MXB5yYK/KDbilhERP1jxn2yl+tGCRguIAsMG0oeOhXaw8uSGOhS6AC
# SHb+ebi0038MFHyoTNhKf+SYo4OpSY3xP4+swBBTKDoYP1wH+CfxG6h9fymBJQPQ
# Zaqfl0riiDLjmDunQtH1GD64Air5k9Jdwhq5wLmSWXjyFVL+IDfOpdixJ6f5o+Mh
# E6H4t31w+prygHmd2UHQ657UGx6FNuzwC+SpAHmV76MZYac4uAhTgaP47P2eeS1o
# ckvyhl9ya+9JzPfMkug3xevzFADWiLRMr066EMV7q3JSRAsnCS9GQ08C4FKPbSh8
# OPM33Lng0ffxANnHAAX/DE7cHcx7l9jaV3Acmkj7oqir4Eh2u5YxwiaTE37XaMum
# X2ES3PJ5NBaXq7YdLJwySD+U9pk/tl4dQ1t/Eeo7uDTliOyQkD8I74xpVB0T31/6
# 7KHfkBkFVvy6wye21V+9IC8uSD++RgD3RwtN2kE/AgMBAAGjggFJMIIBRTAdBgNV
# HQ4EFgQUimLm8QMeJa25j9MWeabI2HSvZOUwHwYDVR0jBBgwFoAUn6cVXQBeYl2D
# 9OXSZacbUzUZ6XIwXwYDVR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3Nv
# ZnQuY29tL3BraW9wcy9jcmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUy
# MDIwMTAoMSkuY3JsMGwGCCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1l
# LVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADAWBgNVHSUB
# Af8EDDAKBggrBgEFBQcDCDAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQAD
# ggIBAF/I8U6hbZhvDcn96nZ6tkbSEjXPvKZ6wroaXcgstEhpgaeEwleLuPXHLzEW
# tuJuYz4eshmhXqFr49lbAcX5SN5/cEsP0xdFayb7U5P94JZd3HjFvpWRNoNBhF3S
# DM0A38sI2H+hjhB/VfX1XcZiei1ROPAyCHcBgHLyQrEu6mnb3HhbIdr8h0Ta7WFy
# lGhLSFW6wmzKusP6aOlmnGSac5NMfla6lRvTYHd28rbbCgfSm1RhTgoZj+W8DTKt
# iEMwubHJ3mIPKmo8xtJIWXPnXq6XKgldrL5cynLMX/0WX65OuWbHV5GTELdfWvGV
# 3DaZrHPUQ/UP31Keqb2xjVCb30LVwgbjIvYS77N1dARkN8F/9pJ1gO4IvZWMwyMl
# KKFGojO1f1wbjSWcA/57tsc+t2blrMWgSNHgzDr01jbPSupRjy3Ht9ZZs4xN02ei
# X3eG297NrtC6l4c/gzn20eqoqWx/uHWxmTgB0F5osBuTHOe77DyEA0uhArGlgKP9
# 1jghgt/OVHoH65g0QqCtgZ+36mnCEg6IOhFoFrCc0fJFGVmb1+17gEe+HRMM7jBk
# 4O06J+IooFrI3e3PJjPrQano/MyE3h+zAuBWGMDRcUlNKCDU7dGnWvH3XWwLrCCI
# cz+3GwRUMsLsDdPW2OVv7v1eEJiMSIZ2P+M7L20Q8aznU4OAMIIHcTCCBVmgAwIB
# AgITMwAAABXF52ueAptJmQAAAAAAFTANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UE
# BhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAc
# BgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0
# IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIwMTAwHhcNMjEwOTMwMTgyMjI1
# WhcNMzAwOTMwMTgzMjI1WjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDCC
# AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOThpkzntHIhC3miy9ckeb0O
# 1YLT/e6cBwfSqWxOdcjKNVf2AX9sSuDivbk+F2Az/1xPx2b3lVNxWuJ+Slr+uDZn
# hUYjDLWNE893MsAQGOhgfWpSg0S3po5GawcU88V29YZQ3MFEyHFcUTE3oAo4bo3t
# 1w/YJlN8OWECesSq/XJprx2rrPY2vjUmZNqYO7oaezOtgFt+jBAcnVL+tuhiJdxq
# D89d9P6OU8/W7IVWTe/dvI2k45GPsjksUZzpcGkNyjYtcI4xyDUoveO0hyTD4MmP
# frVUj9z6BVWYbWg7mka97aSueik3rMvrg0XnRm7KMtXAhjBcTyziYrLNueKNiOSW
# rAFKu75xqRdbZ2De+JKRHh09/SDPc31BmkZ1zcRfNN0Sidb9pSB9fvzZnkXftnIv
# 231fgLrbqn427DZM9ituqBJR6L8FA6PRc6ZNN3SUHDSCD/AQ8rdHGO2n6Jl8P0zb
# r17C89XYcz1DTsEzOUyOArxCaC4Q6oRRRuLRvWoYWmEBc8pnol7XKHYC4jMYcten
# IPDC+hIK12NvDMk2ZItboKaDIV1fMHSRlJTYuVD5C4lh8zYGNRiER9vcG9H9stQc
# xWv2XFJRXRLbJbqvUAV6bMURHXLvjflSxIUXk8A8FdsaN8cIFRg/eKtFtvUeh17a
# j54WcmnGrnu3tz5q4i6tAgMBAAGjggHdMIIB2TASBgkrBgEEAYI3FQEEBQIDAQAB
# MCMGCSsGAQQBgjcVAgQWBBQqp1L+ZMSavoKRPEY1Kc8Q/y8E7jAdBgNVHQ4EFgQU
# n6cVXQBeYl2D9OXSZacbUzUZ6XIwXAYDVR0gBFUwUzBRBgwrBgEEAYI3TIN9AQEw
# QTA/BggrBgEFBQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9E
# b2NzL1JlcG9zaXRvcnkuaHRtMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBkGCSsGAQQB
# gjcUAgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/
# MB8GA1UdIwQYMBaAFNX2VsuP6KJcYmjRPZSQW9fOmhjEMFYGA1UdHwRPME0wS6BJ
# oEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01p
# Y1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYB
# BQUHMAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9v
# Q2VyQXV0XzIwMTAtMDYtMjMuY3J0MA0GCSqGSIb3DQEBCwUAA4ICAQCdVX38Kq3h
# LB9nATEkW+Geckv8qW/qXBS2Pk5HZHixBpOXPTEztTnXwnE2P9pkbHzQdTltuw8x
# 5MKP+2zRoZQYIu7pZmc6U03dmLq2HnjYNi6cqYJWAAOwBb6J6Gngugnue99qb74p
# y27YP0h1AdkY3m2CDPVtI1TkeFN1JFe53Z/zjj3G82jfZfakVqr3lbYoVSfQJL1A
# oL8ZthISEV09J+BAljis9/kpicO8F7BUhUKz/AyeixmJ5/ALaoHCgRlCGVJ1ijbC
# HcNhcy4sa3tuPywJeBTpkbKpW99Jo3QMvOyRgNI95ko+ZjtPu4b6MhrZlvSP9pEB
# 9s7GdP32THJvEKt1MMU0sHrYUP4KWN1APMdUbZ1jdEgssU5HLcEUBHG/ZPkkvnNt
# yo4JvbMBV0lUZNlz138eW0QBjloZkWsNn6Qo3GcZKCS6OEuabvshVGtqRRFHqfG3
# rsjoiV5PndLQTHa1V1QJsWkBRH58oWFsc/4Ku+xBZj1p/cvBQUl+fpO+y/g75LcV
# v7TOPqUxUYS8vwLBgqJ7Fx0ViY1w/ue10CgaiQuPNtq6TPmb/wrpNPgkNWcr4A24
# 5oyZ1uEi6vAnQj0llOZ0dFtq0Z4+7X6gMTN9vMvpe784cETRkPHIqzqKOghif9lw
# Y1NNje6CbaUFEMFxBmoQtB1VM1izoXBm8qGCAtQwggI9AgEBMIIBAKGB2KSB1TCB
# 0jELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1Jl
# ZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMk
# TWljcm9zb2Z0IElyZWxhbmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1U
# aGFsZXMgVFNTIEVTTjpEMDgyLTRCRkQtRUVCQTElMCMGA1UEAxMcTWljcm9zb2Z0
# IFRpbWUtU3RhbXAgU2VydmljZaIjCgEBMAcGBSsOAwIaAxUAdqNHe113gCJ87aZI
# Ga5QBUqIwvKggYMwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAN
# BgkqhkiG9w0BAQUFAAIFAOevrqIwIhgPMjAyMzAzMDYwODEzMjJaGA8yMDIzMDMw
# NzA4MTMyMlowdDA6BgorBgEEAYRZCgQBMSwwKjAKAgUA56+uogIBADAHAgEAAgIO
# SzAHAgEAAgIRIDAKAgUA57EAIgIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEE
# AYRZCgMCoAowCAIBAAIDB6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GB
# AK1gcVA471xksLTDiZMLvaKjm/xXX7nwj2xWCTgtmgE8HgyFvJU9uJLeATCNKQvh
# GiB/9GQvzGv07xPR18dwlu3ZY1Sl3QVEApeGr9e5RLoexwUj/9TauCkM27WCfhbF
# lXHgXJi/WOTw9GjDDC72vsi0MgKU+/9eh6e3lhwgs28VMYIEDTCCBAkCAQEwgZMw
# fDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1Jl
# ZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMd
# TWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMAAAG6Hz8Z98F1vXwAAQAA
# AbowDQYJYIZIAWUDBAIBBQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRAB
# BDAvBgkqhkiG9w0BCQQxIgQgRfDohWzNKSCE2Z6EJg4P563KDVMCCjsaRmteTnme
# eYYwgfoGCyqGSIb3DQEJEAIvMYHqMIHnMIHkMIG9BCApVb08M25w+tYGWsmlGtp1
# gy1nPcqWfqgMF3nlWYVzBTCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQI
# EwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3Nv
# ZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBD
# QSAyMDEwAhMzAAABuh8/GffBdb18AAEAAAG6MCIEIPibFiTzOiiacCdmF9ddb1UV
# 5A1yGeQufT8irspHcQAbMA0GCSqGSIb3DQEBCwUABIICAAA80qtr1nsvslKCVK4L
# 3b/S6WjvZyDCyUxDdydF0j4W7OIR3uVYYwoa7VC7U9AwL/MQe4kraqFHorMd0nEV
# FoxokzxWIn9P1UMr1RfdwPoAyQpwlCJrH2FrY+FU6Pjl0lJn6rFCUNGNKZpfqIWN
# l5ukqDMwwyn1HhBQQU+oRi8xgWb2VVFhEj6KNhs2AEcETwWQirXC9qMNfyhn76vP
# t3jGhf2FT56/nXSMguE3u26UN7sbdAxsETL/MJIWOZjuo7MvwpB7O+NcG9V7UjnD
# PnjHFd4D3BJl8tptq6QLoBa5g7pFDtKZ7cziy7o5F37OHus/vfksgcHOa2J3fE9r
# ixmYbo5Sbu1rbsRhcbxGW81Kd5+WNFUF8zTgBi7aEtybL2FCxsEzdcqMpW/fQRAp
# h3dyTEkG2EQIwQtEZdMyULV2jeDUw20QhPo96ToiMA4KTEBlN6Zf5vfw7ZjHPEKS
# 1RSMxRU3LY9WRhqhK56cE7jYk5z10IEbQoBkGGUTik8iIolxj8ijzU/IJwTh4JXK
# bSU9GOJLnKwqfw4DvxLAjUkv9jP17Y3Dr+prQwVBHdVsrKd+CBHNwYkyI0iSqhE+
# IB08QJhMpGSUsQjX9oH1jx1vXvFH8UCW/EvC+ZOh7b4RbY3xQZN4YMRXNbFxfT/Y
# 5luULG7Jbi67iWdX2LlHIEuE
# SIG # End signature block
