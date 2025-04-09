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
    STIG-ID         : WN10-AU-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-AU-000035.ps1 
#>

# Function to safely apply AuditPol settings
function Set-AuditPolicy {
    param(
        [string]$subcategory,
        [string]$failureMode
    )

    try {
        # Apply the audit policy to the subcategory
        Write-Host "Setting $subcategory to $failureMode"
        AuditPol /set /subcategory:$subcategory /failure:$failureMode
    }
    catch {
        Write-Error "Failed to apply $subcategory with $failureMode"
    }
}

# Check if running as Administrator
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies")) {
    Write-Error "Please run PowerShell as Administrator!"
    exit
}

# Enable Failure Auditing for "Audit User Account Management"
Set-AuditPolicy -subcategory "User Account Management" -failureMode "enable"

Write-Host "Audit policy configuration complete."
