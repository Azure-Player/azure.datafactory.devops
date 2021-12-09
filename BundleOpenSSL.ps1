
cd $PSScriptRoot/build-scripts
npm install
cd $PSScriptRoot/deployDataFactoryTask/ps_modules/VstsAzureHelpers_
npm run build
cd $PSScriptRoot/testLinkedServiceTask/ps_modules/VstsAzureHelpers_
npm run build
Get-ChildItem -Path $PSScriptRoot/* -include 'OpenSSL License.txt'  -Recurse | 
    Remove-Item -Force