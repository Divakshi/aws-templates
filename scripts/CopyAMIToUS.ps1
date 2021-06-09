#e.g CopyAMIToUS.ps1 -BaseImageName w12r2d-14-2
param (
    [Parameter(Mandatory=$true)]
    [string]
    $BaseImageName
)

$path = "$($env:System_DefaultWorkingDirectory)/_Build Image Release Artefacts/aws-$BaseImageName/$BaseImageName.txt"
if (Test-Path $path) {
  $amiID = Get-Content -Path $path 
  Write-Host $amiID
  $imageName = (Get-EC2Image -ImageId $amiID).Name
  $imageID=Copy-EC2Image -SourceRegion ap-southeast-2 -SourceImageId $amiID -Region us-east-1 -Name $imageName
Write-Host " Image Copy takes a few minutes"
#Start-Sleep -Seconds 550
Write-Host "##vso[task.setvariable variable=name;isOutput=true]$imageName"
Write-Host "##vso[task.setvariable variable=id;isOutput=true]$imageID"
}
