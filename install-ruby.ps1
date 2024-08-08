# Define the specific version and architecture
$rubyVersion = {{rubyVersion}} # Set your desired Ruby version here
$rubyArch = {{rubyArch}}        # Set your desired architecture (x64 or x86)

# Construct the URL for the specified version and architecture
$baseUrl = "https://github.com/oneclick/rubyinstaller2/releases/download"
$installerFileName = "rubyinstaller-$rubyVersion-$rubyArch.exe"
$installerUrl = "$baseUrl/RubyInstaller-$rubyVersion/$installerFileName"
$downloadPath = "$env:TEMP\$installerFileName"

# Download the Ruby installer
Write-Host "Downloading Ruby $rubyVersion for $rubyArch architecture..."
Invoke-WebRequest -Uri $installerUrl -OutFile $downloadPath

# Install Ruby
Write-Host "Installing Ruby..."
Start-Process -FilePath $downloadPath -ArgumentList "/verysilent" -Wait

# Clean up downloaded installer
Remove-Item -Path $downloadPath

Write-Host "Ruby $rubyVersion installation completed successfully."
