<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : LaDarius Edwards
    LinkedIn        : www.linkedin.com/in/ladarius-edwards
    GitHub          : https://github.com/Ledwar16
    Date Created    : 2025-04-08
    Last Modified   : 2025-04-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-AU-000500.ps1 
#>

# Define the registry key and value
$regKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$regValueName = "MaxSize"
$regValue = 0x00008000

# Ensure the registry key exists, create it if necessary
if (-not (Test-Path $regKeyPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog" -Name "Application" -Force
}

# Set the registry value
Set-ItemProperty -Path $regKeyPath -Name $regValueName -Value $regValue

Write-Host "Registry key $regValueName set to $regValue at $regKeyPath"
