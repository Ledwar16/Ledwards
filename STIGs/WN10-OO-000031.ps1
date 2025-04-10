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
    STIG-ID         : WN10-OO-000031

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-OO-000031.ps1 
#>

# Define registry path for BitLocker policies
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set UseAdvancedStartup to 1 (Enable advanced startup options for BitLocker)
Set-ItemProperty -Path $RegPath -Name "UseAdvancedStartup" -Value 1 -Type DWord

# Set UseTPMPIN to 1 (Require startup PIN with TPM)
Set-ItemProperty -Path $RegPath -Name "UseTPMPIN" -Value 1 -Type DWord

# Set UseTPMKeyPIN to 1 (Require startup key and PIN with TPM)
Set-ItemProperty -Path $RegPath -Name "UseTPMKeyPIN" -Value 1 -Type DWord

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name UseAdvancedStartup, UseTPMPIN, UseTPMKeyPIN
