[CmdletBinding()]
param
(
    [boolean] [Parameter(Mandatory = $true)]  $isProd,
    [int]     [Parameter(Mandatory = $false)] $build = 0
)
#$isProd = $true

function Copy-CommonModule {
    param ([String[]] $commonModules, [String] $taskName)

    Write-Output "`n*** $taskName ***"
    $taskFolder = Join-Path -Path (Get-Location) -ChildPath "$taskName"
    New-Item -Path "$taskFolder/ps_modules" -ItemType Directory -Force | Out-Null
    $commonModules | ForEach-Object {
        Write-Output "- Copy module: $_"
        $m = $_
        $short = $m.EndsWith('*')
        $m = $m.Replace('*', '')
        Copy-Item -Path ("$commonFolder\$m") -Destination "$taskFolder/ps_modules" -Recurse -Force
        if ($short) {
            Set-SimplifyModule -moduleManifestFile "$taskFolder/ps_modules/$m/$m.psm1"
        }
    }
}

function Set-SimplifyModule {
    param ([String] $moduleManifestFile)

    $file = $moduleManifestFile
    Write-Host "  - modifying file: $file ..."
    $lines = Get-Content -Path $file -Encoding utf8
    $sb = [System.Text.StringBuilder]::new()
    $commentActive = $false
    foreach ($line in $lines) {
        if ($line.StartsWith('$moduleName = ')) { $commentActive = $true }
        if ($commentActive) { $line = "# $line" }
        $sb.AppendLine($line) | Out-Null
    }
    $sb.ToString() | Set-Content -Path $file
}


$now = (Get-Date).ToUniversalTime()
$ts = New-TimeSpan -Hours $now.Hour -Minutes $now.Minute
$versionPatch = $ts.TotalMinutes
if ($build -gt 0) { $versionPatch = $build }
$CommonFolder = Join-Path -Path (Get-Location) -ChildPath 'Common'

# Update extension's manifest
$vssFile = Join-Path -Path (Get-Location) -ChildPath 'vss-extension.json'
$body = Get-Content $vssFile -Raw
$JsonDoc = $body | ConvertFrom-Json
$ver = $JsonDoc.Version
$verarr = $ver.Split('.')
$ver = "{0}.{1}.{2}" -f $verarr[0], $verarr[1], $versionPatch
$verarr[2] = $versionPatch
Write-Output "Module version: $ver"

# Replace with regex
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

#
# deployDataFactoryTask: Update task's manifest
#
$taskName = 'deployDataFactoryTask'
$commonModules = @('azure.datafactory.tools', 'TlsHelper_', 'VstsAzureHelpers_', 'VstsAzureRestHelpers_', 'VstsTaskSdk', 'Az.Accounts', 'Az.Resources', 'Az.DataFactory')
Copy-CommonModule -commonModules $commonModules -taskName $taskName
Write-Output "Updating version for task definition in file: $taskFile"
$taskFolder = Join-Path -Path (Get-Location) -ChildPath "$taskName"
$taskFile = Join-Path -Path $taskFolder -ChildPath "task.json"
$body = $JsonDoc = Get-Content $taskFile -Raw
$JsonDoc = $body | ConvertFrom-Json
$body = $body.Replace('"Major": '+$JsonDoc.version.Major, '"Major": '+$verarr[0])
$body = $body.Replace('"Minor": '+$JsonDoc.version.Minor, '"Minor": '+$verarr[1])
$body = $body.Replace('"Patch": '+$JsonDoc.version.Patch, '"Patch": '+$versionPatch)
if (!$isProd) {
    $body = $body.Replace('"id": "1af843b5-35a0-411f-9a18-9eb7a59fb8b8",', '"id": "b2032481-f9a9-476d-af8f-9156ee066e1b",')
    $body = $body.Replace('"friendlyName": "Publish Azure Data Factory",', '"friendlyName": "Publish ADF (BETA)",')
}
$body | Out-File "$taskFile" -Encoding utf8
Write-Output "File task #1 updated."


#
# buildDataFactoryTask: Update task's manifest
#
$taskName = 'buildDataFactoryTask'
$commonModules = @('azure.datafactory.tools*', 'VstsTaskSdk')
Copy-CommonModule -commonModules $commonModules -taskName $taskName
Write-Output "Updating version for task definition in file: $taskFile"
$taskFolder = Join-Path -Path (Get-Location) -ChildPath "$taskName"
$taskFile = Join-Path -Path $taskFolder -ChildPath "task.json"
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


#
# testLinkedServiceTask: Update task's manifest
#
$taskName = 'testLinkedServiceTask'
$commonModules = @('azure.datafactory.tools', 'TlsHelper_', 'VstsAzureHelpers_', 'VstsTaskSdk', 'Az.Accounts', 'Az.Resources')
Copy-CommonModule -commonModules $commonModules -taskName $taskName
Write-Output "Updating version for task definition in file: $taskFile"
$taskFolder = Join-Path -Path (Get-Location) -ChildPath "$taskName"
$taskFile = Join-Path -Path $taskFolder -ChildPath "task.json"
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


#
# deployAdfFromArmTask: Update task's manifest
#
$taskName = 'deployAdfFromArmTask'
$commonModules = @('azure.datafactory.tools*', 'TlsHelper_', 'VstsAzureHelpers_', 'VstsTaskSdk')
Copy-CommonModule -commonModules $commonModules -taskName $taskName
Write-Output "Updating version for task definition in file: $taskFile"
$taskFolder = Join-Path -Path (Get-Location) -ChildPath "$taskName"
$taskFile = Join-Path -Path $taskFolder -ChildPath "task.json"
$body = $JsonDoc = Get-Content $taskFile -Raw
$JsonDoc = $body | ConvertFrom-Json
#$body = $body.Replace('"Major": '+$JsonDoc.version.Major, '"Major": '+$verarr[0])
$body = $body.Replace('"Minor": '+$JsonDoc.version.Minor, '"Minor": '+$verarr[1])
$body = $body.Replace('"Patch": '+$JsonDoc.version.Patch, '"Patch": '+$versionPatch)
if (!$isProd) {
    $body = $body.Replace('"id": "ecb868a7-3c51-4925-a4b5-c63321b51700",', '"id": "f38a9662-edd3-4af5-b4c2-35f4d3e31dda",')
    $body = $body.Replace('"friendlyName": "Azure Data Factory Deployment (ARM)",', '"friendlyName": "Azure Data Factory Deployment (ARM) (BETA)",')
}
$body | Out-File "$taskFile" -Encoding utf8
Write-Output "File task #4 updated."


#
# BUILD! Yeah!!!
#
tfx extension create --manifest-globs vss-extension.json --output-path ./bin

