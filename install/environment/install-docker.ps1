# Define the parameters
param (
    [string]$Version = "24.0.4",   # Default Docker version
    [string]$Architecture = "x86_64" # Default architecture
)

# Function to print a message with a heading
function Print-Message {
    param ([string]$Message)
    Write-Host "======================================="
    Write-Host $Message
    Write-Host "======================================="
}

Print-Message "Checking if running on Windows"

if (-not (Get-CimInstance -ClassName Win32_OperatingSystem)) {
    Write-Error "This script is intended to be run on Windows."
    exit
}

Print-Message "Downloading Docker"

# Construct the Docker download URL
$dockerUrl = "https://desktop.docker.com/win/stable/${Architecture}/Docker%20Desktop%20Installer.exe"
$installerPath = "DockerInstaller.exe"

# Download Docker installer
Invoke-WebRequest -Uri $dockerUrl -OutFile $installerPath

Print-Message "Installing Docker version $Version for $Architecture architecture"

# Install Docker silently
Start-Process -FilePath $installerPath -ArgumentList "/install", "/quiet" -Wait

Print-Message "Cleaning up installer file"

# Remove installer file
Remove-Item -Path $installerPath

Print-Message "Verifying Docker installation"

# Check Docker version
docker --version

Print-Message "Docker installation completed successfully"
