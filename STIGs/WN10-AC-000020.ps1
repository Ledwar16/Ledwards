<#
.SYNOPSIS
   This script sets the password history policy on a Windows machine to remember the last 24 passwords by modifying the appropriate registry key, ensuring compliance with the STIG requirement WN10-AC-000020.

.NOTES
    Author          : LaDarius Edwards
    LinkedIn        : www.linkedin.com/in/ladarius-edwards
    GitHub          : https://github.com/Ledwar16/Ledwards/
    Date Created    : 2024-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-AC-000020.ps1 
#>

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
