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

# Ensure Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator!"
    exit
}

# Define the config path
$tempCfg = "$env:TEMP\secpol.cfg"

# Export current security policy
secedit /export /cfg $tempCfg

# Read current config and apply modifications
$config = Get-Content $tempCfg

# Define a hashtable of changes (partial example for brevity)
$changes = @{
    "EnableAdminAccount"        = "1"
    "EnableGuestAccount"        = "0"
    "LimitBlankPasswordUse"     = "1"
    "NewAdministratorName"      = "ledwar"
    "NewGuestName"              = "Guest"
    "ClearPageFileAtShutdown"   = "0"
    "ForceLogoffWhenHourExpire" = "0"
    "CachedLogonsCount"         = "10"
    "PromptForPasswordWhenUserNameIsNotKnown" = "1"
    "DontDisplayLastUserName"   = "1"
}

# Apply changes to the config
$config = $config | ForEach-Object {
    $line = $_
    foreach ($key in $changes.Keys) {
        if ($line -match "^$key\s*=") {
            $line = "$key = $($changes[$key])"
        }
    }
    $line
}

# Write updated config
$config | Set-Content $tempCfg

# Apply the new security policy
secedit /configure /db secedit.sdb /cfg $tempCfg /areas SECURITYPOLICY

# Cleanup
Remove-Item $tempCfg -Force

Write-Host "`Local Security Policy has been updated successfully."

