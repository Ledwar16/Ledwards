<#
.SYNOPSIS
This script ensures the DisableInventory registry key is set to 1 (turning off the Inventory Collector feature), creates the necessary registry path if it doesn't exist, forces a Group Policy update to apply the changes, and then verifies the updated configuration.
    Author          : LaDarius Edwards
    LinkedIn        : www.linkedin.com/in/ladarius-edwards
    GitHub          : https://github.com/Ledwar16/Ledwards/
    Date Created    : 2024-04-10
    Last Modified   : 2025-04-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000175

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-CC-000175.ps1 
#>

# Define registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set DisableInventory to 1 (Turn off Inventory Collector)
Set-ItemProperty -Path $RegPath -Name "DisableInventory" -Value 1 -Type DWord

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name "DisableInventory"
