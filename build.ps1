param(
    [boolean]$Clean = $true
)

# Use PowerShell Core
Set-Location $PSScriptRoot

Function DownloadModules($TaskFolder, $ModuleName) {
    $TaskModuleFolder = Join-Path $TaskFolder "\ps_modules"
    $ModuleFolder = Join-Path $TaskModuleFolder $ModuleName
    if (Test-Path -Path $ModuleFolder) {
        Remove-Item $ModuleFolder -Force -Recurse
    }
    New-Item -ItemType Directory $TaskModuleFolder -Force | Out-Null
    Save-Module -Name $ModuleName -Path $TaskModuleFolder -Force -Confirm:$false -AllowPrerelease

    Get-ChildItem $TaskModuleFolder\$ModuleName\*\* | ForEach-Object {
        Move-Item -Path $_.FullName -Destination "$TaskModuleFolder\$ModuleName\"
    }
}

$Folders = Get-ChildItem -Filter "deploy*" -Directory
foreach ($TaskFolder in $Folders.name) {
    if ((!(Test-Path -Path (Join-Path $TaskFolder "\ps_modules\VstsTaskSDK"))) -or ($Clean)) {
        DownloadModules $TaskFolder "VstsTaskSDK"
    }

    if ((!(Test-Path -Path (Join-Path $TaskFolder "\ps_modules\azure.datafactory.tools"))) -or ($Clean)) {
        DownloadModules $TaskFolder "azure.datafactory.tools"
    }
}

Remove-Item ./bin/*.* -Force -ErrorAction SilentlyContinue
&tfx extension create --manifest-globs vss-extension.json --output-path ./bin

# $TaskFolder = $Folders.name
# $ModuleName = "azure.datafactory.tools"
