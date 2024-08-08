# Define the specific version and architecture
$phpVersion = {{phpVersion}}   # Set your desired PHP version here
$phpArch = {{phpArch}}       # Set your desired architecture (x64 or x86)
$phpThreadSafe = {{phpThreadSafe}} # Choose "thread-safe" or "non-thread-safe"

# Construct the URL for the specified version and architecture
$baseUrl = "https://windows.php.net/downloads/releases"
$installerFileName = "php-$phpVersion-Win32-vs16-$phpArch.zip"
$downloadPath = "$env:TEMP\$installerFileName"
$installDir = "C:\php"

# Determine thread-safe or non-thread-safe
if ($phpThreadSafe -eq "thread-safe") {
    $phpUrl = "$baseUrl/archives/$installerFileName"
} else {
    $installerFileName = "php-$phpVersion-nts-Win32-vs16-$phpArch.zip"
    $phpUrl = "$baseUrl/archives/$installerFileName"
}

# Download the PHP zip file
Write-Host "Downloading PHP $phpVersion for $phpArch ($phpThreadSafe)..."
Invoke-WebRequest -Uri $phpUrl -OutFile $downloadPath

# Extract the zip file to the installation directory
Write-Host "Extracting PHP..."
Expand-Archive -Path $downloadPath -DestinationPath $installDir -Force

# Clean up downloaded file
Remove-Item -Path $downloadPath

# Update PATH environment variable
Write-Host "Updating PATH environment variable..."
$env:Path += ";$installDir"
[System.Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)

Write-Host "PHP $phpVersion installation completed successfully."
