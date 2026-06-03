param(
  [int[]]$Ports = @(5173, 5174, 5175, 5180, 3000, 3001, 4173, 4174, 8000, 8080, 8090),
  [string]$HostAddress = "127.0.0.1",
  [switch]$DryRun,
  [switch]$NoBrowser
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir

function Test-PortAvailable {
  param([int]$Port)
  $listener = $null
  try {
    $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Parse($HostAddress), $Port)
    $listener.Start()
    return $true
  } catch {
    return $false
  } finally {
    if ($listener) {
      $listener.Stop()
    }
  }
}

function Get-AvailablePort {
  foreach ($port in $Ports) {
    if (Test-PortAvailable -Port $port) {
      return $port
    }
  }

  $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Parse($HostAddress), 0)
  try {
    $listener.Start()
    return (($listener.LocalEndpoint).Port)
  } finally {
    $listener.Stop()
  }
}

function Get-PythonCommand {
  $python = Get-Command python -ErrorAction SilentlyContinue
  if ($python) {
    return @($python.Source, "-m http.server")
  }

  $py = Get-Command py -ErrorAction SilentlyContinue
  if ($py) {
    return @($py.Source, "-3 -m http.server")
  }

  return $null
}

$port = Get-AvailablePort
$url = "http://${HostAddress}:$port/"
$pythonCommand = Get-PythonCommand

if (-not $pythonCommand) {
  throw "Python was not found. Install Python or run another static server from '$projectRoot'."
}

$serverExe = $pythonCommand[0]
$serverArgsPrefix = $pythonCommand[1]
$serverCommand = "`"$serverExe`" $serverArgsPrefix $port --bind $HostAddress --directory `"$projectRoot`""

if ($DryRun) {
  Write-Host "Project root: $projectRoot"
  Write-Host "Selected URL: $url"
  Write-Host "Server command: $serverCommand"
  exit 0
}

Write-Host "Starting Dice & Camps at $url"
Start-Process -FilePath "cmd.exe" -ArgumentList @("/k", $serverCommand) -WorkingDirectory $projectRoot | Out-Null

if (-not $NoBrowser) {
  Start-Sleep -Milliseconds 700
  Start-Process $url | Out-Null
}

Write-Host "Server window opened. Close that window to stop the local server."

