# Define the parameters
param (
    [string]$perlVersion = "5.32.1.1",  # Default Perl version
    [string]$perlArch = "64bit"         # Default architecture (32bit or 64bit)
)

# Construct the URL for the specified version and architecture
$baseUrl = "https://strawberryperl.com/download/$perlVersion"
$installerFileName = "strawberry-perl-$perlVersion-$perlArch.msi"
$installerUrl = "$baseUrl/$installerFileName"
$downloadPath = "$env:TEMP\$installerFileName"

# Download the Perl installer
Write-Host "Downloading Strawberry Perl $perlVersion for $perlArch architecture..."
Invoke-WebRequest -Uri $installerUrl -OutFile $downloadPath

# Install Perl
Write-Host "Installing Strawberry Perl..."
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$downloadPath`" /quiet" -Wait

# Clean up downloaded installer
Remove-Item -Path $downloadPath

Write-Host "Strawberry Perl $perlVersion installation completed successfully."
