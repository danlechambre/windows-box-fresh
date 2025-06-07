# Helpers

# Create the Shell COM object at the top-level scope (can be reused)
if (-not $global:ShellApp) {
    $global:ShellApp = New-Object -ComObject Shell.Application
}

# Function to pin a folder to Quick Access
function Pin-ToQuickAccess {
    param (
        [string]$folderPath
    )

    $folder = $global:ShellApp.Namespace($folderPath)
    if ($folder -ne $null) {
        $item = $folder.Self
        $item.InvokeVerb("pintohome")
    } else {
        Write-Warning "Could not find folder: $folderPath"
    }
}
