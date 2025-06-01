# -----------
# Common Apps
# -----------

# Install the set of apps that I'm likely to want on *most* installations of Windows

Write-Host "Running common-apps script..." -ForegroundColor Cyan

$appsToInstall = @(
  @{ name = "Visual Studio Code"; id = "Microsoft.VisualStudioCode" },
  @{ name = "Google Chrome"; id = "Google.Chrome" }
)

# Install each app
foreach ($app in $apps) {
  Write-Host "`nInstalling $($app.name)..."
  winget install --id $app.id --silent --accept-package-agreements --accept-source-agreements
}