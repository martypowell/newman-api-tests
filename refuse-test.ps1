Write-Host "Processing New Report for Refuse Pickup Service"

function Show-BalloonTip {            
[cmdletbinding()]            
param(            
 [parameter(Mandatory=$true)]            
 [string]$Title,            
 [ValidateSet("Info","Warning","Error")]             
 [string]$MessageType = "Info",            
 [parameter(Mandatory=$true)]            
 [string]$Message,            
 [string]$Duration=10000            
)            

[system.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null            
$balloon = New-Object System.Windows.Forms.NotifyIcon            
$path = Get-Process -id $pid | Select-Object -ExpandProperty Path            
$icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)            
$balloon.Icon = $icon            
$balloon.BalloonTipIcon = $MessageType            
$balloon.BalloonTipText = $Message            
$balloon.BalloonTipTitle = $Title            
$balloon.Visible = $true            
$balloon.ShowBalloonTip($Duration)            

}

$jsonObj = Get-Content .\newman\refuse-api-results.json -Raw | ConvertFrom-Json

$stats = $jsonObj.run.stats
$hasAtLeastOneFailure = $false;

foreach ($stat in $stats) { 
    $numberOfFailures = $stat.assertions.failed
    $property = ($stat | Get-Member -MemberType *Property).Name

     If ($hasAtLeastOneFailure -eq $false -And $numberOfFailures -gt 0) {
        $hasAtLeastOneFailure = $true
     }
}

If ($hasAtLeastOneFailure -eq $true) {
    Show-BalloonTip -Title "Error occurred" -MessageType Error -Message "There is a problem with Refuse Pickup"
}
Else {
    Write-Host "Everything is great"
}