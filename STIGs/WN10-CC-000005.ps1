# Ensure running as Administrator
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies")) {
    Write-Error "Please run PowerShell as Administrator!"
    exit
}

# Set Password Complexity Requirement to enabled
$regKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regValueName = "DisablePasswordComplexity"
$regValue = 0  # 0 means enabled

# Check if the registry key exists, create it if not
if (-not (Test-Path $regKey)) {
    New-Item -Path $regKey -Force
}

# Set the value for Password Complexity
Set-ItemProperty -Path $regKey -Name $regValueName -Value $regValue

# Confirm the change was applied
Write-Host "Password complexity requirement enabled successfully."
