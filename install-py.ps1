# Set the desired Python version and architecture
$pythonVersion = "3.8.10"
$architecture = "amd64"  # Use "amd64" for 64-bit or "win32" for 32-bit

# Set the download URL and file name
$pythonInstallerUrl = "https://www.python.org/ftp/python/$pythonVersion/python-$pythonVersion-$architecture.exe"
$installerFileName = "python-$pythonVersion-$architecture.exe"

# Set the download directory
$downloadDirectory = "$env:USERPROFILE\Downloads"

# Full path to the installer
$installerFilePath = Join-Path -Path $downloadDirectory -ChildPath $installerFileName

# Download the installer
Write-Host "Downloading Python $pythonVersion..." -ForegroundColor Green
Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $installerFilePath

# Run the installer silently
Write-Host "Installing Python $pythonVersion..." -ForegroundColor Green
Start-Process -FilePath $installerFilePath -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1" -Wait

# Verify installation
Write-Host "Verifying Python installation..." -ForegroundColor Green
$pythonPath = (Get-Command python).Source
$installedVersion = & python --version

if ($installedVersion) {
    Write-Host "Python successfully installed at: $pythonPath" -ForegroundColor Green
    Write-Host "Installed version: $installedVersion" -ForegroundColor Green
} else {
    Write-Host "Python installation failed." -ForegroundColor Red
}

# Cleanup: Remove the installer
Remove-Item -Path $installerFilePath -Force
Write-Host "Cleanup completed." -ForegroundColor Green
