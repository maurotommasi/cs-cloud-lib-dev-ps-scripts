# Define the parameters
param (
    [string]$phpVersion = "8.1.0",           # Default PHP version
    [string]$phpArch = "x64",                # Default architecture (x64 or x86)
    [string]$phpThreadSafe = "thread-safe"   # Default thread safety (thread-safe or non-thread-safe)
)

# Construct the URL for the specified version and architecture
$baseUrl = "https://windows.php.net/downloads/releases"
if ($phpThreadSafe -eq "thread-safe") {
    $installerFileName = "php-$phpVersion-Win32-vs16-$phpArch.zip"
} else {
    $installerFileName = "php-$phpVersion-nts-Win32-vs16-$phpArch.zip"
}
$phpUrl = "$baseUrl/archives/$installerFileName"
$downloadPath = "$env:TEMP\$installerFileName"
$installDir = "C:\php"

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
