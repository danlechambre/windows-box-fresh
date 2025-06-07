# Import helpers
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$helpersPath = Join-Path -Path $scriptDir -ChildPath "helpers.ps1"

# Check if the helpers script exists and dot-source it
if (Test-Path $helpersPath) {
    . $helpersPath
} else {
    Write-Error "Could not find helpers.ps1 at $helpersPath"
    exit 1
}

# -----------
# Preferences
# -----------

# Set up all of our preferences

# -------
# Windows
# -------

# Make scroll work like Mac OS
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\HID\*\*\Device Parameters" -Name "FlipFlopWheel" -Value 1

# Pin User and Downloads folders to Quick Access
$userProfile = [Environment]::GetFolderPath("UserProfile")
$downloads   = Join-Path $userProfile "Downloads"

Pin-ToQuickAccess -folderPath $userProfile
Pin-ToQuickAccess -folderPath $downloads

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0

# ----
# Apps
# ----

# Chrome
# Define registry path and values
$chromeRegPath = "HKLM:\Software\Policies\Google\Chrome"

# Create the key if it doesn't exist
If (-not (Test-Path $chromeRegPath)) {
    New-Item -Path $chromeRegPath -Force
}

# Set the policy to disable password saving prompt
New-ItemProperty -Path $chromeRegPath -Name "PasswordManagerEnabled" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path $chromeRegPath -Name "DefaultBrowserSettingEnabled" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path $chromeRegPath -Name "BrowserSignin" -Value 0 -PropertyType DWord -Force

# Configure Git
git config --global user.email "dan@danlechambre.com"
git config --global user.name "danlechambre"