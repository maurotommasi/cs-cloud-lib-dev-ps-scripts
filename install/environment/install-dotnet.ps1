# Define the specific version and architecture
$dotnetVersion = {{dotnetVersion}}  # Set your desired .NET version here
$dotnetArch = {{dotnetVersion}}       # Set your desired architecture (x64 or x86)

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
