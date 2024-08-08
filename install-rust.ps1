# Define the specific version and architecture
$rustVersion = {{rustVersion}}  # Set your desired Rust version here
$rustArch = {{rustArch}}  # Set your desired architecture

# Construct the URL for rustup-init.exe
$rustupUrl = "https://static.rust-lang.org/rustup/dist/$rustArch/rustup-init.exe"
$downloadPath = "$env:TEMP\rustup-init.exe"

# Download rustup-init.exe
Write-Host "Downloading rustup-init.exe for $rustArch..."
Invoke-WebRequest -Uri $rustupUrl -OutFile $downloadPath

# Install Rust using rustup
Write-Host "Installing Rust $rustVersion..."
Start-Process -FilePath $downloadPath -ArgumentList "-y --default-toolchain $rustVersion" -Wait

# Clean up downloaded rustup-init.exe
Remove-Item -Path $downloadPath

Write-Host "Rust $rustVersion installation completed successfully."
