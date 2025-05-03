# Run this as Administrator

Write-Host "🧹 Running debloat script..." -ForegroundColor Cyan

$appsToRemove = @(
    "Microsoft.MicrosoftSolitaireCollection",     # Solitaire
    # "Microsoft.Xbox.TCUI",                        # Xbox TCUI
    # "Microsoft.XboxGamingOverlay",                # Xbox Game Bar
    # "Microsoft.XboxGameOverlay",                  # Xbox Game Overlay
    "Microsoft.XboxIdentityProvider",             # Xbox Identity
    "Microsoft.ZuneMusic",                        # Groove Music
    "Microsoft.ZuneVideo",                        # Movies & TV
    "Microsoft.People",                           # People App
    "Microsoft.BingNews",                         # News
    "Microsoft.GetHelp",                          # Get Help
    "Microsoft.Getstarted",                       # Tips
    "Microsoft.MicrosoftOfficeHub",               # Office Hub
    "Microsoft.OneConnect",                       # Your Phone
    "Microsoft.Todos",                            # Microsoft To Do
    "Microsoft.WindowsFeedbackHub",               # Feedback Hub
    "Microsoft.549981C3F5F10",                    # Cortana
    "Microsoft.Microsoft3DViewer",                # 3D Viewer
    "Microsoft.Paint3D",                          # Paint 3D
    "Microsoft.SkypeApp",                         # Skype
    # "Microsoft.XboxApp",                          # Xbox Console Companion
    "Microsoft.XboxSpeechToTextOverlay"           # Xbox speech overlay
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