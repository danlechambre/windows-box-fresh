# ---------
# Bootstrap
# ---------

# This script just orchestrates running the others

# Ensure the PSWindowsUpdate module is installed
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module -Name PSWindowsUpdate -Force
}

# Import the module
Import-Module PSWindowsUpdate

# Check for and install Windows updates
$updates = Get-WindowsUpdate -AcceptAll -IgnoreReboot

if ($updates.Count -gt 0) {
    Write-Host "Updates found. Installing..."
    Install-WindowsUpdate -AcceptAll -AutoReboot -IgnoreUserInput
} else {
    Write-Host "No updates available. Skipping installation and reboot."
}

# Get the current script folder path
$invocationPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# Scripts to run
$scripts = @(
  "debloat.ps1",
  "common-apps.ps1",
  "preferences.ps1"
)

foreach ($script in $scripts) {
  $scriptPath = Join-Path -Path $invocationPath -ChildPath $script

  if (Test-Path $scriptPath) {
    Write-Host "Running $script ..." -ForegroundColor Yellow
    try {
      & $scriptPath
      Write-Host "$script completed successfully!" -ForegroundColor Yellow
    } catch {
      Write-Error "Error running $script" -ForegroundColor Red
      break
    }
  } else {
    Write-Error "Script not found: $scriptPath" -ForegroundColor Red
    break
  }
}

Write-Host "*******************************************" -ForegroundColor Green
Write-Host "Bootstrapping complete! Enjoy Windoze bruh!" -ForegroundColor Green
Write-Host "*******************************************" -ForegroundColor Green

Write-Host "Kicking off some Windows updates if we have any" -ForegroundColor Yellow