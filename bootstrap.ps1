# ---------
# Bootstrap
# ---------

# This script just orchestrates running the others

# Get the current script folder path
$invocationPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# Scripts to run
$scripts = @(
  "debloat.ps1",
  "common-apps.ps1",
  "config.ps1",
  "preferences.ps1"
)

foreach ($script in $scripts) {
  $scriptPath = Join-Path -Path $invocationPath -ChildPath $script

  if (Test-Path $scriptPath) {
    Write-Host "Running $script ..."
    try {
      & $scriptPath
      Write-Host "$script completed successfully!"
    } catch {
      Write-Error "Error running $script"
      break
    }
  } else {
    Write-Error "Script not found: $scriptPath"
    break
  }
}

Write-Host "Bootstrapping complete! Enjoy Windoze bruh!"