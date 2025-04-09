<#
.SYNOPSIS
    This script configures Windows audit policies to enable failure auditing for User Account Management, ensuring system security and event logging.

.NOTES
    Author          : LaDarius Edwards
    LinkedIn        : www.linkedin.com/in/ladarius-edwards
    GitHub          : https://github.com/Ledwar16/Ledwards/
    Date Created    : 2024-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-CC-000005.ps1 
#>

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
