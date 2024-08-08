# Define the specific version and architecture
$goVersion = {{goVersion}}    # Set your desired Go version here
$goArch = {{goArch}}        # Set your desired architecture (amd64 for 64-bit, 386 for 32-bit)

# Construct the URL for the specified version and architecture
$baseUrl = "https://golang.org/dl"
$installerFileName = "go$goVersion.windows-$goArch.msi"
$installerUrl = "$baseUrl/$installerFileName"
$downloadPath = "$env:TEMP\$installerFileName"

# Download the Go installer
Write-Host "Downloading Go $goVersion for $goArch architecture..."
Invoke-WebRequest -Uri $installerUrl -OutFile $downloadPath

# Install Go
Write-Host "Installing Go..."
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $downloadPath /quiet" -Wait

# Clean up downloaded installer
Remove-Item -Path $downloadPath

Write-Host "Go $goVersion installation completed successfully."
