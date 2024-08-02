# Define the version of Python you want to install
$pythonVersion = {{python_version}}

# Function to check if Chocolatey is installed
function Is-ChocolateyInstalled {
    try {
        Get-Command choco -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

# Function to install Chocolatey
function Install-Chocolatey {
    Write-Output "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Check if Chocolatey is installed
if (-not (Is-ChocolateyInstalled)) {
    Install-Chocolatey
}

# Refresh environment variables to ensure Chocolatey is available
& cmd /c refreshenv

# Install the specific version of Python
Write-Output "Installing Python $pythonVersion..."
choco install python --version $pythonVersion -y

# Verify the installation
Write-Output "Verifying Python installation..."
$pythonPath = (Get-Command python).Source
$pythonInstalledVersion = & $pythonPath --version

Write-Output "Installed Python version: $pythonInstalledVersion"
