<#
.SYNOPSIS
This script ensures that the AllowTelemetry registry key is set to 0 (restricting diagnostic data collection for security purposes), creates the necessary registry path if it doesn't exist, forces a Group Policy update to apply the changes, and then verifies the new configuration.
.NOTES
    Author          : LaDarius Edwards
    LinkedIn        : www.linkedin.com/in/ladarius-edwards
    GitHub          : https://github.com/Ledwar16/Ledwards/
    Date Created    : 2024-04-10
    Last Modified   : 2025-04-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-CC-000205.ps1 
#>

# Define registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set AllowTelemetry to 0 (Security) to restrict diagnostic data collection
Set-ItemProperty -Path $RegPath -Name "AllowTelemetry" -Value 0 -Type DWord

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name "AllowTelemetry"
