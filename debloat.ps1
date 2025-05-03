# Run this as Administrator

Write-Host "🧹 Running debloat script..." -ForegroundColor Cyan

$appsToRemove = @(
    "Microsoft.MicrosoftSolitaireCollection",     # Solitaire
    "Clipchamp.Clipchamp",
    "Microsoft.Copilot",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
)

foreach ($app in $appsToRemove) {
    Write-Host "📦 Uninstalling $app ($index of $total)" -ForegroundColor Yellow

    $pkg = Get-AppxPackage -AllUsers -Name $app
    if ($pkg) {
        Write-Output "Removing: $app"
        Remove-AppxPackage -Package $pkg.PackageFullName
    } else {
        Write-Output "Not installed: $app"
    }
}

Write-Host "✅ Completed debloat successfully!" -ForegroundColor Cyan