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
