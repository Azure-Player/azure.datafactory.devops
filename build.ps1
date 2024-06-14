[CmdletBinding()]
param
(
    [boolean] [Parameter(Mandatory = $true)]  $isProd,
    [int]     [Parameter(Mandatory = $false)] $build = 0
)
# $isProd = $false

function Update-TaskManifest {
    param (
        [string] $taskFolder,
        [System.Version] $version,
        [string] $NonProdTaskId,
        [bool]   $isProd
    )

    Write-Output "Updating version for task definition: $taskFolder"
    $taskFile = Join-Path -Path ".\Tasks\$taskFolder" -ChildPath "task.json"
    $body = $JsonDoc = Get-Content $taskFile -Raw
    $JsonDoc = $body | ConvertFrom-Json
    #$body = $body.Replace('"Major": '+$JsonDoc.version.Major, '"Major": '+$verarr[0])
    $body = $body.Replace('"Minor": '+$JsonDoc.version.Minor, '"Minor": '+$verarr[1])
    $body = $body.Replace('"Patch": '+$JsonDoc.version.Patch, '"Patch": '+$verarr[2])
    if (!$IsProd) {
        Write-Output "- Updating task id and friendly name for private preview..."
        $TaskId = $JsonDoc.id
        $TaskFriendlyName = $JsonDoc.friendlyName
        $NonProdTaskFriendlyName = "$TaskFriendlyName (Private Preview)"
        $body = $body.Replace("""id"": ""$TaskId"",", """id"": ""$NonProdTaskId"",")
        $body = $body.Replace("""friendlyName"": ""$TaskFriendlyName"",", """friendlyName"": ""$NonProdTaskFriendlyName"",")
    }
    $body | Out-File "$taskFile" -Encoding utf8
    Write-Output "File task ($taskFolder) updated."
}


$now = (Get-Date).ToUniversalTime()
$ts = New-TimeSpan -Hours $now.Hour -Minutes $now.Minute
if ($build -eq 0) { $build = $ts.TotalMinutes }

# Update extension's manifest
$vssFile = Join-Path -Path (Get-Location) -ChildPath 'vss-extension.json'
$body = Get-Content $vssFile -Raw
$JsonDoc = $body | ConvertFrom-Json
$ver = $JsonDoc.Version
$verarr = $ver.Split('.')
$version = [System.Version]::new($verarr[0], $verarr[1], $build)
Write-Output "Module version: $ver"

# Replace with regex
$v = '"version": "'+$JsonDoc.Version+'",'
$nv = '"version": "'+$ver+'",'
if (!$isProd) {
    $body = $body.Replace('"name": "Deploy Azure Data Factory by SQLPlayer"', '"name": "Deploy ADF (Preview)"')
    $body = $body.Replace('"public": true,', '"public": false,')
    $body = $body.Replace('"publisher": "SQLPlayer",', '"publisher": "Kamil-Nowinski",')
}
$body = $body.Replace($v, $nv)
#$JsonDoc.version = $ver
#$JsonDoc | ConvertTo-Json | Out-File "$vssFile" -Encoding utf8
$body | Out-File "$vssFile" -Encoding utf8
Write-Output "File vss updated."

# Update task definitions
Update-TaskManifest -taskFolder 'deployDataFactoryTaskV2' -version $version -NonProdTaskId 'b2032481-f9a9-476d-af8f-9156ee066e1b' -isProd $isProd
Update-TaskManifest -taskFolder 'buildDataFactoryTaskV2'  -version $version -NonProdTaskId '0fff6fc0-4a02-46b2-9466-2ee2a9b0580f' -isProd $isProd
Update-TaskManifest -taskFolder 'testLinkedServiceTaskV2' -version $version -NonProdTaskId '9cb687ea-a4f1-45d5-a568-98dc85fd3f1b' -isProd $isProd
Update-TaskManifest -taskFolder 'deployAdfFromArmTaskV2'  -version $version -NonProdTaskId 'f38a9662-edd3-4af5-b4c2-35f4d3e31dda' -isProd $isProd

$version = [System.Version]::new(1, 35, $build)
Update-TaskManifest -taskFolder 'deployDataFactoryTaskV1' -version $version -NonProdTaskId 'b2032481-f9a9-476d-af8f-9156ee066e1b' -isProd $isProd
Update-TaskManifest -taskFolder 'buildDataFactoryTaskV1'  -version $version -NonProdTaskId '0fff6fc0-4a02-46b2-9466-2ee2a9b0580f' -isProd $isProd
Update-TaskManifest -taskFolder 'testLinkedServiceTaskV1' -version $version -NonProdTaskId '9cb687ea-a4f1-45d5-a568-98dc85fd3f1b' -isProd $isProd
Update-TaskManifest -taskFolder 'deployAdfFromArmTaskV1'  -version $version -NonProdTaskId 'f38a9662-edd3-4af5-b4c2-35f4d3e31dda' -isProd $isProd

# Build extension
tfx extension create --manifest-globs vss-extension.json --output-path ./bin
