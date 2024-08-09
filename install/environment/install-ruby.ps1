# Define the parameters
param (
    [string]$rubyVersion = "3.1.0",  # Default Ruby version
    [string]$rubyArch = "x64"        # Default architecture (x64 or x86)
)

# Construct the URL for the specified version and architecture
$baseUrl = "https://github.com/oneclick/rubyinstaller2/releases/download"
$installerFileName = "rubyinstaller-$rubyVersion-$rubyArch.exe"
$installerUrl = "$baseUrl/RubyInstaller-$rubyVersion/$installerFileName"
$downloadPath = "$env:TEMP\$installerFileName"

# Download the Ruby installer
Write-Host "Downloading Ruby $rubyVersion for $rubyArch architecture..." -ForegroundColor Green
Invoke-WebRequest -Uri $installerUrl -OutFile $downloadPath

# Install Ruby
Write-Host "Installing Ruby..." -ForegroundColor Green
Start-Process -FilePath $downloadPath -ArgumentList "/verysilent" -Wait

# Clean up downloaded installer
Remove-Item -Path $downloadPath

Write-Host "Ruby $rubyVersion installation completed successfully." -ForegroundColor Green
