<#
.SYNOPSIS
This script ensures the AllowDomainPINLogon registry key is set to 0 (disabling the use of convenience PIN sign-in for domain accounts), creates the necessary registry path if it doesn't exist, forces a Group Policy update to apply the changes, and then verifies the updated configuration.
.NOTES
    Author          : LaDarius Edwards
    LinkedIn        : www.linkedin.com/in/ladarius-edwards
    GitHub          : https://github.com/Ledwar16/Ledwards/
    Date Created    : 2024-04-10
    Last Modified   : 2025-04-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000370

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-CC-000370.ps1 
#>


# Define registry path
$RegPath = "HKLM:\Software\Policies\Microsoft\Windows\System"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set AllowDomainPINLogon to 0 (Disable convenience PIN sign-in)
Set-ItemProperty -Path $RegPath -Name "AllowDomainPINLogon" -Value 0 -Type DWord

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name "AllowDomainPINLogon"
