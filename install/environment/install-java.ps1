# Define the parameters
param (
    [string]$javaVersion = "17.0.0",  # Default Java version
    [string]$javaArch = "windows-x64" # Default architecture
)

# Construct the URL for the specified version and architecture
$baseUrl = "https://download.oracle.com/java"
$installerFileName = "jdk-$javaVersion_$javaArch_bin.exe"
$installerUrl = "$baseUrl/GA/jdk$javaVersion/$installerFileName"
$downloadPath = "$env:TEMP\$installerFileName"

# Download the JDK installer
Write-Host "Downloading Java JDK $javaVersion for $javaArch architecture..."
Invoke-WebRequest -Uri $installerUrl -OutFile $downloadPath

# Install Java JDK
Write-Host "Installing Java JDK..."
Start-Process -FilePath $downloadPath -ArgumentList "/s" -Wait

# Clean up downloaded installer
Remove-Item -Path $downloadPath

Write-Host "Java JDK $javaVersion installation completed successfully."
