param(
  [string]$Url = "https://onovich.github.io/DiceAndCamps/",
  [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ($DryRun) {
  Write-Host "Online URL: $Url"
  exit 0
}

Start-Process $Url | Out-Null

