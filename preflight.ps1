# ---------
# Preflight
# ---------

# We don't have git installed on a fresh Windows 11 install so we need to:
# - get this script via a web request
# - save it a temp location
# - tell Windows we know what we're doing
# - execute it

# Don't forget Windows thinks it knows best - it won't let you execute a remote script without...
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Then we should able to do everything with this one liner
# Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/danlechambre/windows-box-fresh/main/preflight.ps1' -OutFile "$env:TEMP\preflight.ps1"; Unblock-File "$env:TEMP\preflight.ps1"; & "$env:TEMP\preflight.ps1"

# ---------

# Upgrade PowerShell and accept the store terms
winget install --id Microsoft.PowerShell --source winget --accept-source-agreements

$repoName = "danlechambre/windows-box-fresh"
$cloneDirectory = "$env:USERPROFILE\source\$($repoName.Split('/')[1])"
# Create the directory if it doesn't exist
New-Item -ItemType Directory -Force -Path (Split-Path $cloneDirectory) | Out-Null

# Function to check if Git is installed
function Test-GitInstalled {
    return (Get-Command git -ErrorAction SilentlyContinue) -ne $null
}

# Install Git if needed
if (-not (Test-GitInstalled)) {
    Write-Host "Git not found. Attempting to install via winget..."
    winget install --id Git.Git -e --source winget

    if (-not (Test-GitInstalled)) {
        Write-Error "Git installation failed or winget is not available."
        exit 1
    }

    Write-Host "Git installed successfully."
} else {
    Write-Host "Git is already installed."
}

# Clone the repository
if (-not (Test-Path $cloneDirectory)) {
    Write-Host "Cloning repository https://github.com/$repoName..."
    git clone "https://github.com/$repoName.git" $cloneDirectory
} else {
    Write-Host "Directory $cloneDirectory already exists. Skipping clone."
}
