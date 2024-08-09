# Define the parameters
param (
    [string]$rustVersion = "1.70.0",  # Default Rust version
    [string]$rustArch = "x86_64"      # Default architecture (x86_64 for 64-bit or i686 for 32-bit)
)

# Construct the URL for rustup-init.exe
$rustupUrl = "https://static.rust-lang.org/rustup/dist/$rustArch/rustup-init.exe"
$downloadPath = "$env:TEMP\rustup-init.exe"

# Download rustup-init.exe
Write-Host "Downloading rustup-init.exe for $rustArch..." -ForegroundColor Green
Invoke-WebRequest -Uri $rustupUrl -OutFile $downloadPath

# Install Rust using rustup
Write-Host "Installing Rust $rustVersion..." -ForegroundColor Green
Start-Process -FilePath $downloadPath -ArgumentList "-y --default-toolchain $rustVersion" -Wait

# Clean up downloaded rustup-init.exe
Remove-Item -Path $downloadPath

Write-Host "Rust $rustVersion installation completed successfully." -ForegroundColor Green
