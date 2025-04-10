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


# Ensure script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    exit
}

function Set-AuditPolicy {
    param (
        [string]$subcategory,
        [string]$success = "nochange",
        [string]$failure = "nochange"
    )

    Write-Host "Setting $subcategory | Success: $success | Failure: $failure"
    AuditPol /set /subcategory:"$subcategory" /success:$success /failure:$failure
}

# Set Logon and Logoff to Success and Failure
Set-AuditPolicy -subcategory "Logon" -success "enable" -failure "enable"
Set-AuditPolicy -subcategory "Logoff" -success "enable" -failure "enable"

# Set all others to Not Configured (equivalent to disabling Success/Failure auditing)
$notConfigured = @(
    "Account Lockout",
    "User / Device Claims",
    "Group Membership",
    "IPsec Extended Mode",
    "IPsec Main Mode",
    "IPsec Quick Mode",
    "Network Policy Server",
    "Other Logon/Logoff Events",
    "Special Logon"
)

foreach ($subcategory in $notConfigured) {
    Set-AuditPolicy -subcategory $subcategory -success "disable" -failure "disable"
}

Write-Host "`Audit policy updated successfully according to specified configuration."

