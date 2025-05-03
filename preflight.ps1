# Invoke-WebRequest -Uri "https://raw.githubusercontent.com/danlechambre/windows-box-fresh/main/preflight.ps1" -OutFile "$env:TEMP\preflight.ps1"
# powershell -ExecutionPolicy Bypass -File "$env:TEMP\preflight.ps1"

# Upgrade PowerShell
winget install --id Microsoft.PowerShell --source winget --accept-source-agreements

# Variables – customize these
$repoName = "danlechambre/windows-box-fresh"
$cloneDirectory = "$env:USERPROFILE\source\$($repoName.Split('/')[1])"

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
