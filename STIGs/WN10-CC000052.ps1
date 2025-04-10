<#
.SYNOPSIS
This script ensures the EccCurves registry key is set to NistP384 and NistP256 in the correct order for SSL configuration, creates the necessary registry path if it doesn't exist, forces a Group Policy update to apply the changes, and then verifies the updated configuration.
.NOTES
    Author          : LaDarius Edwards
    LinkedIn        : www.linkedin.com/in/ladarius-edwards
    GitHub          : https://github.com/Ledwar16/Ledwards/
    Date Created    : 2024-04-10
    Last Modified   : 2025-04-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC000052

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-CC000052.ps1 
#>

# Define registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set EccCurves to NistP384 and NistP256 in the correct order
$EccCurves = "NistP384", "NistP256"
Set-ItemProperty -Path $RegPath -Name "EccCurves" -Value $EccCurves -Type MultiString

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name "EccCurves"
