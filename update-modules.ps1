# [azure.datafactory.tools - ver.0.97.0](https://www.powershellgallery.com/packages/azure.datafactory.tools/0.97.0)
# [Az.DataFactory - ver.1.16.6](https://www.powershellgallery.com/packages/Az.DataFactory/1.16.6)
# [Az.Accounts - ver.2.5.3](https://www.powershellgallery.com/packages/Az.Accounts/2.5.3)
# [Az.Resources - ver.4.3.1](https://www.powershellgallery.com/packages/Az.Resources/4.3.1)

$target = 'd:\modules'
Remove-Item -Path "$target\*" -Force

function Download-Module {
    param ([String] $m, [String]$target, $reqVer)

    update-module $m -Force -RequiredVersion $reqVer
    $list = get-module $m -ListAvailable
    $mod = $list[0]
    $folder = Split-Path $mod.Path -Parent
    mkdir "$target`\$m"
    Copy-Item -Path "$folder\*" -Destination "$target`\$m" -Recurse
    $mod
}

function Update-ModuleInPlace {
    param ([String] $m)

    $targetPath = (.\Get-RootPath.ps1)
    $src = Join-Path $target $m
    $dst = "$targetPath\Common2"
    Write-Host "Module: $src"
    Write-Host "- copy to: $dst ..."
    New-Item -Path $dst -Force -ItemType Directory | Out-Null
    Copy-Item -Path $src -Destination $dst -Recurse -Force
}


# Downloading modules
$m = 'azure.datafactory.tools'; Download-Module -m $m -target $target
$m = 'Az.DataFactory';          Download-Module -m $m -target $target -reqVer '1.16.13'
$m = 'Az.Accounts';             Download-Module -m $m -target $target #-reqVer '2.12.1'
$m = 'Az.Resources';            Download-Module -m $m -target $target #-reqVer '6.5.3'

# Updating modules in 'azure.datafactory.devops'
$m = 'azure.datafactory.tools'; 
#$tasks = @('buildDataFactoryTask*', 'deployAdfFromArmTask*', 'deployDataFactoryTask', 'testLinkedServiceTask*')
Update-ModuleInPlace $m

$m = 'Az.DataFactory';
#$tasks = @('deployDataFactoryTask')
Update-ModuleInPlace $m

$m = 'Az.Accounts';
#$tasks = @('deployDataFactoryTask', 'testLinkedServiceTask')
Update-ModuleInPlace $m

$m = 'Az.Resources';
#$tasks = @('deployDataFactoryTask', 'testLinkedServiceTask')
Update-ModuleInPlace $m
