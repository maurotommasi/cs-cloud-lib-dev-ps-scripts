# Define the specific version and architecture
$mingwVersion = {{mingwVersion}} # Set your desired MinGW-w64 version here
$mingwArch = {{mingwArch}}    # Set your desired architecture (x86_64 for 64-bit, i686 for 32-bit)

# Construct the URL for the MinGW-w64 installer
$baseUrl = "https://sourceforge.net/projects/mingw-w64/files/mingw-w64"
$installerFileName = "mingw-w64-v$mingwVersion-$mingwArch-win32-seh-rt_v10-rev0.7z"
$installerUrl = "$baseUrl/$mingwVersion/$installerFileName/download"
$downloadPath = "$env:TEMP\$installerFileName"
$extractPath = "$env:LOCALAPPDATA\MinGW"

# Download the MinGW-w64 installer
Write-Host "Downloading MinGW-w64 $mingwVersion for $mingwArch architecture..."
Invoke-WebRequest -Uri $installerUrl -OutFile $downloadPath

# Extract the downloaded 7z file
Write-Host "Extracting MinGW-w64..."
Start-Process -FilePath "7z.exe" -ArgumentList "x `"$downloadPath`" -o`"$extractPath`"" -Wait

# Clean up the downloaded installer
Remove-Item -Path $downloadPath

# Update PATH environment variable
$mingwBinPath = [System.IO.Path]::Combine($extractPath, "mingw64", "bin")
if (-not ($env:Path -contains $mingwBinPath)) {
    [System.Environment]::SetEnvironmentVariable("Path", "$env:Path;$mingwBinPath", [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Updated PATH environment variable to include MinGW-w64."
}

Write-Host "MinGW-w64 $mingwVersion installation completed successfully."
