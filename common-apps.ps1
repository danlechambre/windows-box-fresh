# -----------
# Common Apps
# -----------

# Install the set of apps that I'm likely to want on *most* installations of Windows

Write-Host "Running common-apps script..." -ForegroundColor Cyan

$appsToInstall = @(
  @{ name = "Visual Studio Code"; id = "Microsoft.VisualStudioCode" },
  @{ name = "Google Chrome"; id = "Google.Chrome" },
  @{ name = "Steam"; id = "Valve.Steam" },
  @{ name = "Dolphin"; id = "DolphinEmulator.Dolphin" },
  @{ name = "RetroArch"; id = "Libretro.RetroArch" }
)

# Install each app
foreach ($app in $appsToInstall) {
  Write-Host "`nInstalling $($app.name)..."
  winget install -e --id $app.id --silent --accept-package-agreements --accept-source-agreements
}