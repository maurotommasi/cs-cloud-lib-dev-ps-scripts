# Define the parameters
param (
    [string]$nodeVersion = "18.0.0",  # Default Node.js version
    [string]$nodeArch = "x64"         # Default architecture (x64 or x86)
)

# Construct the URL for the specified version and architecture
$nodeJsBaseUrl = "https://nodejs.org/dist/"
$installerFileName = "node-$nodeVersion-$nodeArch.msi"
$installerUrl = "$nodeJsBaseUrl$nodeVersion/$installerFileName"
$downloadPath = "$env:TEMP\$installerFileName"

# Download the Node.js installer
Write-Host "Downloading Node.js $nodeVersion for $nodeArch architecture..."
Invoke-WebRequest -Uri $installerUrl -OutFile $downloadPath

# Install Node.js
Write-Host "Installing Node.js..."
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$downloadPath`" /quiet" -Wait

# Clean up downloaded installer
Remove-Item -Path $downloadPath

Write-Host "Node.js $nodeVersion installation completed successfully."
