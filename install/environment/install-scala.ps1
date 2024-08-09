# Define the parameters
param (
    [string]$scalaVersion = "2.13.8"  # Default Scala version
)

# Construct the URL for Coursier
$coursierUrl = "https://git.io/coursier-cli-windows-exe"
$coursierExePath = "$env:TEMP\cs.exe"

# Download the Coursier executable
Write-Host "Downloading Coursier..." -ForegroundColor Green
Invoke-WebRequest -Uri $coursierUrl -OutFile $coursierExePath

# Install Scala using Coursier
Write-Host "Installing Scala $scalaVersion..." -ForegroundColor Green
Start-Process -FilePath $coursierExePath -ArgumentList "install scala:$scalaVersion" -Wait

# Optionally, add Coursier to the PATH
$coursierBinPath = [System.IO.Path]::Combine($env:USERPROFILE, ".cs", "bin")
if (-not ($env:Path -contains $coursierBinPath)) {
    [System.Environment]::SetEnvironmentVariable("Path", "$env:Path;$coursierBinPath", [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Updated PATH environment variable to include Coursier." -ForegroundColor Green
}

# Clean up the downloaded Coursier executable
Remove-Item -Path $coursierExePath

Write-Host "Scala $scalaVersion installation completed successfully." -ForegroundColor Green
