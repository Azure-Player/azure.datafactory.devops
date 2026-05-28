$repoUrl  = 'https://github.com/microsoft/azure-pipelines-tasks.git'
$tempDir  = Join-Path $env:TEMP "azure-pipelines-tasks-$(Get-Random)"
$targetDir = 'Common'

Write-Host "Cloning (sparse) $repoUrl ..."
git clone --depth 1 --filter=blob:none --sparse $repoUrl $tempDir
if ($LASTEXITCODE -ne 0) { throw "git clone failed" }

Push-Location $tempDir
git sparse-checkout set Tasks/Common
if ($LASTEXITCODE -ne 0) { Pop-Location; throw "git sparse-checkout failed" }
Pop-Location

$sourceDir = Join-Path $tempDir 'Tasks\Common'
Write-Host "Copying '$sourceDir' -> '$targetDir' ..."
Copy-Item -Path "$sourceDir\*" -Destination $targetDir -Recurse -Force

Write-Host "Cleaning up $tempDir ..."
Remove-Item -Path $tempDir -Recurse -Force

Write-Host "Done."
