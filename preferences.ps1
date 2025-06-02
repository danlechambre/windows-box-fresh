# ---------
# Preferences
# ---------

# Set up all of our preferences

# Windows Preferences
# Make scroll work like Mac OS
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\HID\*\*\Device Parameters" -Name "FlipFlopWheel" -Value 1

# Configure Git
git config --global user.email "dan@danlechambre.com"
git config --global user.name "danlechambre"

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

# # Restart the computer and bask in glory or weep with sorrow
Restart-Computer