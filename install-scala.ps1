# Define the specific version of Scala
$scalaVersion = {{scalaVersion}}  # Set your desired Scala version here

# Construct the URL for Coursier
$coursierUrl = "https://git.io/coursier-cli-windows-exe"
$coursierExePath = "$env:TEMP\cs.exe"

# Download the Coursier executable
Write-Host "Downloading Coursier..."
Invoke-WebRequest -Uri $coursierUrl -OutFile $coursierExePath

# Install Scala using Coursier
Write-Host "Installing Scala $scalaVersion..."
Start-Process -FilePath $coursierExePath -ArgumentList "install scala:$scalaVersion" -Wait

# Optionally, add Coursier to the PATH
$env:CoursierBinPath = [System.IO.Path]::Combine($env:USERPROFILE, ".cs", "bin")
if (-not ($env:Path -contains $env:CoursierBinPath)) {
    [System.Environment]::SetEnvironmentVariable("Path", "$env:Path;$env:CoursierBinPath", [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Updated PATH environment variable to include Coursier."
}

# Clean up the downloaded Coursier executable
Remove-Item -Path $coursierExePath

Write-Host "Scala $scalaVersion installation completed successfully."
