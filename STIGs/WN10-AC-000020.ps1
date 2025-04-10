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

# Ensure the script is running with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "❌ This script must be run as Administrator."
    exit
}

# Temporary file to store exported security policy
$tempFile = "$env:TEMP\secpol.cfg"

# Export current local security policy
secedit /export /cfg $tempFile

# Read and update password policies
$updatedPolicy = Get-Content $tempFile | ForEach-Object {
    if ($_ -match "^PasswordHistorySize") {
        "PasswordHistorySize = 24"
    } elseif ($_ -match "^MaximumPasswordAge") {
        "MaximumPasswordAge = 42"
    } elseif ($_ -match "^MinimumPasswordAge") {
        "MinimumPasswordAge = 0"
    } elseif ($_ -match "^MinimumPasswordLength\s*=") {
        "MinimumPasswordLength = 0"
    } elseif ($_ -match "^PasswordComplexity") {
        "PasswordComplexity = 0"
    } elseif ($_ -match "^ClearTextPassword") {
        "ClearTextPassword = 0"
    } else {
        $_
    }
}

# Save the modified policy
$updatedPolicy | Set-Content $tempFile

# Apply the new policy settings
secedit /configure /db secedit.sdb /cfg $tempFile /areas SECURITYPOLICY

# Cleanup
Remove-Item $tempFile -Force

Write-Host "`n✅ Password policy applied successfully:"
Write-Host " - Enforce password history: 24"
Write-Host " - Maximum password age: 42 days"
Write-Host " - Minimum password age: 0 days"
Write-Host " - Minimum password length: 0"
Write-Host " - Complexity requirements: Disabled"
Write-Host " - Store passwords using reversible encryption: Disabled"

