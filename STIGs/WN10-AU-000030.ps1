<#
.SYNOPSIS
This script configures Windows audit policies to enable logging of both successful and failed Logon and Logoff events, ensuring compliance with the STIG WN10-AU-000030.
.NOTES
    Author          : LaDarius Edwards
    LinkedIn        : www.linkedin.com/in/ladarius-edwards
    GitHub          : https://github.com/Ledwar16/Ledwards/
    Date Created    : 2024-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-AU-000030.ps1 
#>


# Ensure running as Administrator
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies")) {
    Write-Error "Please run PowerShell as Administrator!"
    exit
}

# Function to safely apply AuditPol settings
function Set-AuditPolicy {
    param(
        [string]$subcategory,
        [string]$successMode,
        [string]$failureMode
    )

    try {
        # Apply the audit policy to the subcategory
        Write-Host "Setting $subcategory with Success=$successMode and Failure=$failureMode"
        AuditPol /set /subcategory:$subcategory /success:$successMode /failure:$failureMode
    }
    catch {
        Write-Error "Failed to apply $subcategory policy with Success=$successMode and Failure=$failureMode"
    }
}

# Set Logon and Logoff Audit Policies to Success and Failure
Set-AuditPolicy -subcategory "Logon" -successMode "enable" -failureMode "enable"
Set-AuditPolicy -subcategory "Logoff" -successMode "enable" -failureMode "enable"

Write-Host "Audit Logon/Logoff policy configuration complete."
