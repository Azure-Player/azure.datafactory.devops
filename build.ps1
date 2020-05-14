
$JsonDoc = Get-Content ".\vss-extension.json" -Raw | ConvertFrom-Json
$ver = $JsonDoc.Version
$verarr = $ver.Split('.')
Write-Output "Module version: $ver"

$taskFile = Join-Path -Path (Get-Location) -ChildPath 'deployDataFactoryTask\task.json'
#Copy-Item -Path $taskFile -Destination "$taskFile - copy"
Write-Output "Updating version for task definition in file: $taskFile"
$JsonDoc = Get-Content $taskFile -Raw | ConvertFrom-Json
$JsonDoc.version.Major = $verarr[0]
$JsonDoc.version.Minor = $verarr[1]
$JsonDoc.version.Patch = $verarr[2]
$JsonDoc | ConvertTo-Json | Out-File "$taskFile" -Encoding utf8
Write-Output "File updated."



# tfx extension create --manifest-globs vss-extension.json --output-path ./bin


