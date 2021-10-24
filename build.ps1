[CmdletBinding()]
param
(
    [boolean] [Parameter(Mandatory = $true)]  $isProd,
    [int]     [Parameter(Mandatory = $false)] $build = 0
)
# $isProd = $false

$now = (Get-Date).ToUniversalTime()
$ts = New-TimeSpan -Hours $now.Hour -Minutes $now.Minute
$versionPatch = $ts.TotalMinutes
if ($build -gt 0) { $versionPatch = $build }

# Update extension's manifest
$vssFile = Join-Path -Path (Get-Location) -ChildPath 'vss-extension.json'
$body = Get-Content $vssFile -Raw
$JsonDoc = $body | ConvertFrom-Json
$ver = $JsonDoc.Version
$verarr = $ver.Split('.')
$ver = "{0}.{1}.{2}" -f $verarr[0], $verarr[1], [int]$verarr[2] + $versionPatch
$verarr[2] = $versionPatch
Write-Output "Module version: $ver"

#replace with regex
$v = '"version": "'+$JsonDoc.Version+'",'
$nv = '"version": "'+$ver+'",'
if (!$isProd) {
    $body = $body.Replace('"name": "Deploy Azure Data Factory by SQLPlayer"', '"name": "Deploy ADF (Beta)"')
    $body = $body.Replace('"public": true,', '"public": false,')
    $body = $body.Replace('"publisher": "SQLPlayer",', '"publisher": "Kamil-Nowinski",')
}
$body = $body.Replace($v, $nv)
#$JsonDoc.version = $ver
#$JsonDoc | ConvertTo-Json | Out-File "$vssFile" -Encoding utf8
$body  | Out-File "$vssFile" -Encoding utf8
Write-Output "File vss updated."

# Update task's manifest
$taskFile = Join-Path -Path (Get-Location) -ChildPath 'deployDataFactoryTask\task.json'
#Copy-Item -Path $taskFile -Destination "$taskFile - copy"
Write-Output "Updating version for task definition in file: $taskFile"
$body = $JsonDoc = Get-Content $taskFile -Raw
$JsonDoc = $body | ConvertFrom-Json
#$JsonDoc.version.Major = $verarr[0]
#$JsonDoc.version.Minor = $verarr[1]
#$JsonDoc.version.Patch = $versionPatch  #$verarr[2]
$body = $body.Replace('"Major": '+$JsonDoc.version.Major, '"Major": '+$verarr[0])
$body = $body.Replace('"Minor": '+$JsonDoc.version.Minor, '"Minor": '+$verarr[1])
$body = $body.Replace('"Patch": '+$JsonDoc.version.Patch, '"Patch": '+$versionPatch)
if (!$isProd) {
    #$JsonDoc.id = "b2032481-f9a9-476d-af8f-9156ee066e1b"
    #$JsonDoc.friendlyName = "Publish ADF (BETA)"
    $body = $body.Replace('"id": "1af843b5-35a0-411f-9a18-9eb7a59fb8b8",', '"id": "b2032481-f9a9-476d-af8f-9156ee066e1b",')
    $body = $body.Replace('"friendlyName": "Publish Azure Data Factory",', '"friendlyName": "Publish ADF (BETA)",')
}
#$JsonDoc | ConvertTo-Json | Out-File "$taskFile" -Encoding utf8
$body | Out-File "$taskFile" -Encoding utf8
Write-Output "File task #1 updated."


# Update task's manifest
$taskFile = Join-Path -Path (Get-Location) -ChildPath 'buildDataFactoryTask\task.json'
Write-Output "Updating version for task definition in file: $taskFile"
$body = $JsonDoc = Get-Content $taskFile -Raw
$JsonDoc = $body | ConvertFrom-Json
$body = $body.Replace('"Major": '+$JsonDoc.version.Major, '"Major": '+$verarr[0])
$body = $body.Replace('"Minor": '+$JsonDoc.version.Minor, '"Minor": '+$verarr[1])
$body = $body.Replace('"Patch": '+$JsonDoc.version.Patch, '"Patch": '+$versionPatch)
if (!$isProd) {
    $body = $body.Replace('"id": "8a00f62d-c46d-4019-9e11-c05d88821db8",', '"id": "0fff6fc0-4a02-46b2-9466-2ee2a9b0580f",')
    $body = $body.Replace('"friendlyName": "Build Azure Data Factory code",', '"friendlyName": "Build ADF code (BETA)",')
}
$body | Out-File "$taskFile" -Encoding utf8
Write-Output "File task #2 updated."


# Update task's manifest
$taskFile = Join-Path -Path (Get-Location) -ChildPath 'testLinkedServiceTask\task.json'
Write-Output "Updating version for task definition in file: $taskFile"
$body = $JsonDoc = Get-Content $taskFile -Raw
$JsonDoc = $body | ConvertFrom-Json
$body = $body.Replace('"Major": '+$JsonDoc.version.Major, '"Major": '+$verarr[0])
$body = $body.Replace('"Minor": '+$JsonDoc.version.Minor, '"Minor": '+$verarr[1])
$body = $body.Replace('"Patch": '+$JsonDoc.version.Patch, '"Patch": '+$versionPatch)
if (!$isProd) {
    $body = $body.Replace('"id": "5bf98930-3058-4afe-b031-48d312459df4",', '"id": "9cb687ea-a4f1-45d5-a568-98dc85fd3f1b",')
    $body = $body.Replace('"friendlyName": "Test connection of ADF Linked Service",', '"friendlyName": "Test connection of ADF Linked Service (BETA)",')
}
$body | Out-File "$taskFile" -Encoding utf8
Write-Output "File task #3 updated."



tfx extension create --manifest-globs vss-extension.json --output-path ./bin



