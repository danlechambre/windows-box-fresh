# ---------
# Debloat
# ---------

# Uninstall all of the crapware that Microsoft ship with Windows these days

Write-Host "Running debloat script..." -ForegroundColor Cyan

$appsToRemove = @(
  "Microsoft.MicrosoftSolitaireCollection",
  "Clipchamp.Clipchamp",
  "Microsoft.Copilot",
  "Microsoft.ZuneMusic",
  "Microsoft.ZuneVideo",
  "Microsoft.Todos",
  "Microsoft.WindowsCamera",
  "Microsoft.OutlookForWindows",
  "Microsoft.BingWeather",
  "Microsoft.BingNews",
  "Microsoft.MicrosoftOfficeHub",
  "Microsoft.PowerAutomateDesktop",
  "Microsoft.WindowsFeedbackHub",
  "MSTeams"
)

foreach ($app in $appsToRemove) {
  $pkg = Get-AppxPackage -AllUsers -Name $app
  if ($pkg) {
    Write-Host "Removing: $app" -ForegroundColor Blue
    Remove-AppxPackage -Package $pkg.PackageFullName
  } else {
    Write-Host "Couldn't find: $app" -ForegroundColor Yellow
  }
}

Write-Host "Completed debloat successfully!" -ForegroundColor Green