# Ensure running as Administrator
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies")) {
    Write-Error "Please run PowerShell as Administrator!"
    exit
}

# Set Enforce Password History to 24 (this ensures 24 previous passwords are remembered)
$regKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regValueName = "PasswordHistorySize"
$regValue = 24

# Check if the registry key exists, create it if not
if (-not (Test-Path $regKey)) {
    New-Item -Path $regKey -Force
}

# Set the value for Password History Size (24 passwords)
Set-ItemProperty -Path $regKey -Name $regValueName -Value $regValue

# Confirm the change was applied
Write-Host "Password history set to 24 successfully."
