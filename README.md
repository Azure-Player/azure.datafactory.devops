# Deploying Azure Data Factory instance

This extension to Azure DevOps has only one task and only one goal: deploy Azure Data Factory (v2) seamlessly at minimum efforts.
As opposed to ARM template publishing from 'adf_publish' branch, this task publishes ADF directly from JSON files, who represent all ADF artefacts.  
The task based on the PowerShell module [azure.datafactory.tools](https://github.com/SQLPlayer/azure.datafactory.tools) available through [PSGallery](https://www.powershellgallery.com/packages/azure.datafactory.tools/).  
Fully written in PowerShell, compatible with Windows PowerShell 5.1, PowerShell Core 6.0 and above.


# Azure DevOps Tasks (#adftools)

## How to add task
For classic pipelines, you will find the Task available under the Deploy tab, or search for **publish data factory**:
![Adding Task](images/add-task.png)

For [YAML pipelines](https://docs.microsoft.com/en-us/azure/devops/pipelines/get-started/pipelines-get-started), use task `PublishADFTask@1`.

# Publish Azure Data Factory
Use this to deploy a folder of ADF objects from your repo to target Azure Data Factory instance.  


## Key capabilities

* Creation of Azure Data Factory, if not exist (option)
* Deployment of all type of objects: pipelines, datasets, linked services, data flows, triggers, integration runtimes
* Copes with dependencies (multiple levels) between objects when deploying (no more worrying about object names)
* Build-in mechanism to replace the properties with the indicated values (CSV file)
* Update, add or remove any property of ADF artefact
* Selective deployment declared in-line or by pointed file
* Stop/start triggers (option)
* Dropping objects when not exist in the source (code) (option)
* Filtering (include or exclude) objects to be deployed by name and/or type and/or type
* Filtering supports wildcards
* Publish options allow you to control:
  * Whether stop and restarting triggers
  * Whether delete or not objects not in the source
  * Whether create or not a new instance of ADF if it not exist
* Tokenisation in config file allows replace any value by Environment Variable or Variable from DevOps Pipeline
* Global Parameters (new!)

For more details, please go to [documentation of azure.datafactory.tools](https://github.com/SQLPlayer/azure.datafactory.tools/blob/master/README.md).


## Parameters
|Parameter label|Parameter name (for YAML task)|Description|
|--|--|--|
| Azure Subscription | `azureSubscription` | Azure subscription to target for deployment |
| Resource Group Name | `ResourceGroupName` | Provide the name of the Resource Group |
| Target Azure Data Factory Name | `DataFactoryName` | Provide the name of the target Azure Data Factory|
| Azure Data Factory Path | `DataFactoryCodePath` | Path from the repo root to the ADF folder which should contains sub-folders like 'pipeline', 'dataset', etc.|
| Target Region | `Location` | Azure Region of target Data Factory. Required, but used only when creating a new instance of ADF|
| Environment Config Type | `StageType` | Specifies how you would provide set of parameters for Stage.  |
| Environment (stage) | `StageCode` | Allows pointing configuration with values for all properties who need to be replaced. <br/> If parameter is specified, a CSV file named './deployment/config-{stage}.csv' must exists in repo.|
| Environment (stage) Config File Path | `StageConfigFile` | Allows pointing configuration with values for all properties who need to be replaced. <br/>If specified, CSV config file name must ends with '.csv'|
| Delete objects not in source | `DeleteNotInSource` | Indicates whether the deployment process should removing objects not existing in the source (code)|
| Stop/Start triggers | `StopStartTriggers` | Indicates whether or not to stop the triggers before beginning deployment and start them afterwards|
| Create new ADF instance | `CreateNewInstance` | Indicates whether or not to create a new ADF if target instance doesn't exist yet.|
| Filtering Type | `FilteringType` | Type of filtering ADF objects: File Path or Inline Text Field |
| Include/Exclude Filtering Text | `FilterText` | Multi-line or comma-separated list of objects to be included or excluded in the deployment. <br/>For example, see below. |
| Include/Exclude Filtering File Path | `FilterTextFile` | Multi-line or comma-separated list of objects to be included/excluded in/from the deployment. <br/>For example, see below. | 
| Do not Stop/Start excluded triggers | `DoNotStopStartExcludedTriggers` | Specifies whether excluded triggers will be stopped before deployment. |
| Do not delete excluded objects | `DoNotDeleteExcludedObjects` | Specifies whether excluded objects can be removed. Applies when `DeleteNotInSource` is set to *True* only. |


## Environment (stage) 

Optional parameter. When defined, process will replace all properties defined in (csv) configuration file.
The parameter can be either full path to csv file (must ends with .csv) or just stage name.
When you provide parameter value 'UAT' the process will try open config file located in `.\deployment\config-UAT.csv`

The whole concept of CI & CD (Continuous Integration and Continuous Delivery) process is to deploy automatically and riskless onto target infrastructure, supporting multi-environments. Each environment (or stage) to be exact the same code except selected properties. Very often these properties are:  
- Data Factory name
- Azure Key Vault URL (endpoint)
- Selected properties of Linked Services 
- Some variables
- etc.

All these values are hold among JSON files in code repository and due to their specifics - they are not parametrised as it happens in ARM template.
That is the reason of the need of replacing selected object's parameters into one specified for particular environment. The changes must be done just before deployment.

In order to address that needs, the process are able to read flat **configuration file** with all required values **per environment**. Below is the example of such config file:
```
type,name,path,value
linkedService,LS_AzureKeyVault,typeProperties.baseUrl,"https://kv-blog-uat.vault.azure.net/"
linkedService,LS_BlobSqlPlayer,typeProperties.connectionString,"DefaultEndpointsProtocol=https;AccountName=blobstorageuat;EndpointSuffix=core.windows.net;"
pipeline,PL_CopyMovies,activities[0].outputs[0].parameters.BlobContainer,UAT
pipeline,PL_CopyMovies_with_param,parameters.DstBlobContainer.defaultValue,UAT
pipeline,PL_Wait_Dynamic,parameters.WaitInSec,"{'type': 'int32','defaultValue': 22}"
# This is comment - the line will be omitted
```
> You can replace any property with that method.

There are 4 columns in CSV file:
- `type` - Type of object. It's the same as folder where the object's file located
- `name` - Name of objects. It's the same as json file in the folder
- `path` - Path of the property's value to be replaced within specific json file
- `value` - Value to be set

### Column TYPE

Column `type` accepts one of the following values only:
- integrationRuntime
- pipeline
- dataset
- dataflow
- linkedService
- trigger
- factory *(for Global Parameters)*

### Column NAME

This column defines an object. Since the latest version, you can speficy the **name** using wildcards. That means rather than duplicating lines for the same configuration (path&value) for multiple files, you can define only one line in config.

### Column PATH

Unless otherwise stated, mechanism always **replace (update)** the value for property. Location for those Properties are specified by `Path` column in Config file.  
Additionally, you can **remove** selected property altogether or **create (add)** new one. To define desire action, put character `+` (plus) or `-` (minus) just before Property path:

* `+` (plus) - Add new property with defined value
* `-` (minus) - Remove existing property  

See example below:
```
type,name,path,value
# As usual - this line only update value for connectionString:
linkedService,BlobSampleData,typeProperties.connectionString,"DefaultEndpointsProtocol=https;AccountName=sqlplayer2019;EndpointSuffix=core.windows.net;"
# MINUS means the desired action is to REMOVE encryptedCredential:
linkedService,BlobSampleData,-typeProperties.encryptedCredential,
# PLUS means the desired action is to ADD new property with associated value:
linkedService,BlobSampleData,+typeProperties.accountKey,"$($Env:VARIABLE)"
factory,BigFactorySample2,"$.properties.globalParameters.'Env-Code'.value","PROD"
# Multiple following configurations for many files:
dataset,DS_SQL_*,properties.xyz,ABC
```


### Column VALUE

You can define 3 types of values in column `Value`: number, string, (nested) JSON object.  
If you need to use comma (,) in `Value` column - remember to enclose entire value within double-quotes ("), like in this example below:
```
pipeline,PL_Wait_Dynamic,parameters.WaitInSec,"{'type': 'int32','defaultValue': 22}"
```

#### Using Tokens as dynamic values
You can use token syntax to define expression which should be replaced by value after reading CSV config file process. Currently PowerShell expression for environment is supported, which is: `$Env:VARIABLE` or `$($Env:VARIABLE)`.  
Assuming you have *Environment Variable* name `USERDOMAIN` with value `CONTOSO`, this line from config file:
```
linkedService,AKV,typeProperties.baseUrl,"https://$Env:USERDOMAIN.vault.azure.net/"
```
will become that one after reading from disk:
```
linkedService,AKV,typeProperties.baseUrl,"https://CONTOSO.vault.azure.net/"
```

Having that in mind, you can leverage variables defined in Azure DevOps pipeline to replace tokens without extra task. This is possible because all pipeline's variables are available as environment variables within the agent.



## Selective deployment
The task allows you to deploy subset of ADF's objects.   
You can select objects specifying them by object's type, name or folder which belongs to, using include or exclude option.  
All 3 parts (Type, Name, Folder) can be wildcarded, so all such variants are possible:

You can specify them by exact name or wildcard. 
  Example:  
  ```
  +pipeline.PL_Copy*  
  +dataset.ds_srcCopy  
  dataset.*  
  -pipeline.PL_DoNotPublish*  
  -integrationruntime.*
  -*.*@testFolder
  ```
To simplify user experience – only one field is exposed in order to define include/exclude rules.
Therefore, an extra character should be provided before the name/pattern:
* `+` (plus) - for objects you want to include to a deployment
* `-` (minus) - for objects you want to exclude from a deployment  

If char (+/-) is not provided – an inclusion rule would be applied.


### Screenshot of Publish Task 
![Task](images/AzureDevOps-publish-ADF-task-screenshot.png)


# Build/Test Azure Data Factory code

Another very helpful task is `Build Azure Data Factory`. Use it to validate the code of your Azure Data Factory before you publish it onto target ADF service. 
The function validates files of ADF in a given location, returning warnings or errors.  
The following validation will be perform:
- Reads all files and validates its json format
- Checks whether all dependant objects exist
- Checks whether file name equals object name
- (more soon...)

Parameters:  
- `RootFolder` - Source folder where all ADF objects are kept. The folder should contain subfolders like pipeline, linkedservice, etc.



### Screenshot of Build Task 
![Task](images/AzureDevOps-build-ADF-task-screenshot.png)






# Related modules
This task includes the following modules:  
- [azure.datafactory.tools - ver.0.50.0](https://www.powershellgallery.com/packages/azure.datafactory.tools/0.50.0)
- [Az.DataFactory - ver.1.11.3](https://www.powershellgallery.com/packages/Az.DataFactory/1.11.3)
- [Az.Accounts - ver.2.2.3](https://www.powershellgallery.com/packages/Az.Accounts/2.2.3)
- [Az.Resources - ver.3.1.1](https://www.powershellgallery.com/packages/Az.Resources/3.1.1)

# History
- 02 Feb 2021 - v.1.03  Added new task: TestAdfLinkedServiceTask (preview)
- 20 Jan 2021 - v.1.02  Fixed: JSON file corrupted when contained object is located deeper than 15 nodes  
- 14 Jan 2021 - v.1.01  New task: Build/Test Azure Data Factory Code  
- 10 Jan 2021 - v.1.00  New publish flag: `DoNotDeleteExcludedObjects`  
                        New publish flag: `DoNotStopStartExcludedTriggers`
- 23 Dec 2020 - v.0.90  PUBLIC Release:  
                        Support wildcard when specifying object(s) name in config file  
                        Added object name to the msg before action  
                        Exit publish cmd when ADF name is already in use  
                        Allow selecting objects in given folder (#14)  
                        Fixed: Finding dependencies miss objects when the same object names occurs  
                        Fixed: DeleteNotInSource fails when attempting to remove active trigger or found many dependant objects
- 08 Dec 2020 - v.0.11  Fixed: JSON file could be corrupted when config update has happened on a very deep path
                        Fixed: Special characters deployed wrong
- 06 Dec 2020 - v.0.10  Fixed: File Path Filtering Type not working
- 19 Nov 2020 - v.0.9   Fixed check which hasn't allowed passing config file in json format
- 10 Sep 2020 - v.0.8   Fixed issue with deployment when no global parameters
- 09 Sep 2020 - v.0.7   Support of Global Parameters
- 09 Aug 2020 - v.0.6   Added Environment Variables mapping (Advanced) & Publish Method to be chosen
- 04 Aug 2020 - v.0.5   Fix bug #3: Add module Az.Resources + upgrade other Az.*
- 26 Jul 2020 - v.0.4   Upgrade all related modules (new features)
- 06 Jun 2020 - v.0.3   Upgrade module azure.datafactory.tools to ver.0.10 (a few bug fixes)
- 27 May 2020 - v.0.2   Enhanced few things. First Public Preview release.
- 15 May 2020 - v.0.1   The first Private Preview release. 
