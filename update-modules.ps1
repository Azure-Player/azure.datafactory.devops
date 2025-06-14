# [azure.datafactory.tools - ver.0.97.0](https://www.powershellgallery.com/packages/azure.datafactory.tools/0.97.0)
# [Az.DataFactory - ver.1.16.6](https://www.powershellgallery.com/packages/Az.DataFactory/1.16.6)
# [Az.Accounts - ver.2.5.3](https://www.powershellgallery.com/packages/Az.Accounts/2.5.3)
# [Az.Resources - ver.4.3.1](https://www.powershellgallery.com/packages/Az.Resources/4.3.1)

$ErrorActionPreference = 'Stop'
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
    param ([String] $m, [String[]]$tasks)

    $targetPath = (.\Get-RootPath.ps1)
    $src = Join-Path $target $m

    foreach ($t in $tasks) {
        if (!$t.EndsWith('V1') -and !$t.EndsWith('V2') -and !$t.EndsWith('V1*') -and !$t.EndsWith('V2*')) { Write-Error "Task must ends with V1/2[*]"}
        $short = $t.EndsWith('*')
        $tv = $t.Replace('*', '')
        $t = $tv.Substring(0, $tv.Length - 2)
        $dst = "$targetPath\$t\$tv\ps_modules"
        Write-Host "Module: $src"
        Write-Host "- copy to: $dst ..."
        Copy-Item -Path $src -Destination $dst -Recurse -Force
        if ($short) {
            $file = "$dst\$m\$m.psm1"
            Write-Host "- modifying file: $file ..."
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
    }
}

Uninstall-Module -Name 'Az.DataFactory'
Uninstall-Module -Name 'azure.datafactory.tools'

# Downloading modules
$m = 'azure.datafactory.tools'; Download-Module -m $m -target $target
$m = 'Az.DataFactory';          Download-Module -m $m -target $target #-reqVer '1.19.2'
# $m = 'Az.Accounts';             Download-Module -m $m -target $target #-reqVer '2.12.1'
# $m = 'Az.Resources';            Download-Module -m $m -target $target #-reqVer '6.5.3'

# Updating modules in 'azure.datafactory.devops'
$m = 'azure.datafactory.tools'; 
$tasks = @('buildDataFactoryTaskV1*', 'deployAdfFromArmTaskV1*', 'deployDataFactoryTaskV2', 'testLinkedServiceTaskV2*')
Update-ModuleInPlace $m $tasks

$m = 'Az.DataFactory';
$tasks = @('deployDataFactoryTaskV2')
Update-ModuleInPlace $m $tasks

# $m = 'Az.Accounts';
# $tasks = @('deployDataFactoryTaskV1', 'testLinkedServiceTaskV1')
# Update-ModuleInPlace $m $tasks

# $m = 'Az.Resources';
# $tasks = @('deployDataFactoryTaskV1', 'testLinkedServiceTaskV1')
# Update-ModuleInPlace $m $tasks
