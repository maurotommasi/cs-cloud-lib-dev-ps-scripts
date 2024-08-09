# Define the parameters
param (
    [string]$dotnetVersion = "7.0.0",  # Default .NET version
    [string]$dotnetArch = "x64"        # Default architecture
)

# Construct the URL for the .NET SDK installer
$baseUrl = "https://dotnetcli.azureedge.net/dotnet/Sdk"
$installerFileName = "dotnet-sdk-$dotnetVersion-win-$dotnetArch.exe"
$installerUrl = "$baseUrl/$dotnetVersion/$installerFileName"
$downloadPath = "$env:TEMP\$installerFileName"

# Download the .NET SDK installer
Write-Host "Downloading .NET SDK $dotnetVersion for $dotnetArch architecture..."
Invoke-WebRequest -Uri $installerUrl -OutFile $downloadPath

# Install the .NET SDK
Write-Host "Installing .NET SDK..."
Start-Process -FilePath $downloadPath -ArgumentList "/quiet", "/norestart" -Wait

# Clean up the downloaded installer
Remove-Item -Path $downloadPath

Write-Host ".NET SDK $dotnetVersion installation completed successfully."
