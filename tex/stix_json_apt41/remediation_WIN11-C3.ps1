# ============================================================================
# APT41 Incident Response Script
# Generated: 2025-12-06 17:02:42
# Target System: WIN11-C3
# Detected Techniques: T1021.001, T1021.002, T1550.002, T1550.003
# ============================================================================

# ÉTAPE 1: Collecte d'informations
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "APT41 Incident Response - Starting" -ForegroundColor Cyan
Write-Host "System: WIN11-C3" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Cyan

# Créer un répertoire pour les logs
$logDir = "C:\APT41_Response_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
New-Item -Path $logDir -ItemType Directory -Force

# ÉTAPE 2: Capture de l'état actuel
Write-Host "[+] Capturing system state..." -ForegroundColor Green
Get-Process | Export-Csv "$logDir\processes.csv" -NoTypeInformation
Get-Service | Export-Csv "$logDir\services.csv" -NoTypeInformation
Get-NetTCPConnection | Export-Csv "$logDir\network_connections.csv" -NoTypeInformation
Get-ScheduledTask | Export-Csv "$logDir\scheduled_tasks.csv" -NoTypeInformation


# ============================================================================
# Remediation for T1021.001: RDP Lateral Movement
# ============================================================================

Write-Host '[+] Applying fixes for RDP Lateral Movement...' -ForegroundColor Yellow

try {
    (Get-WmiObject -class Win32_TSGeneralSetting -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-Tcp'").SetUserAuthenticationRequired(1)
    Write-Host '  [OK] Command executed successfully' -ForegroundColor Green
} catch {
    Write-Host '  [ERROR] Command failed: $_' -ForegroundColor Red
    $_ | Out-File -Append '$logDir\errors.log'
}

try {
    New-NetFirewallRule -DisplayName "RDP-Restricted" -Direction Inbound -LocalPort 3389 -Protocol TCP -Action Allow -RemoteAddress "10.0.0.0/8"
    Write-Host '  [OK] Command executed successfully' -ForegroundColor Green
} catch {
    Write-Host '  [ERROR] Command failed: $_' -ForegroundColor Red
    $_ | Out-File -Append '$logDir\errors.log'
}


# ============================================================================
# Remediation for T1021.002: SMB/PsExec
# ============================================================================

Write-Host '[+] Applying fixes for SMB/PsExec...' -ForegroundColor Yellow

try {
    net share ADMIN$ /delete
    Write-Host '  [OK] Command executed successfully' -ForegroundColor Green
} catch {
    Write-Host '  [ERROR] Command failed: $_' -ForegroundColor Red
    $_ | Out-File -Append '$logDir\errors.log'
}

try {
    net share C$ /delete
    Write-Host '  [OK] Command executed successfully' -ForegroundColor Green
} catch {
    Write-Host '  [ERROR] Command failed: $_' -ForegroundColor Red
    $_ | Out-File -Append '$logDir\errors.log'
}

try {
    Set-SmbServerConfiguration -RequireSecuritySignature $true -Force
    Write-Host '  [OK] Command executed successfully' -ForegroundColor Green
} catch {
    Write-Host '  [ERROR] Command failed: $_' -ForegroundColor Red
    $_ | Out-File -Append '$logDir\errors.log'
}

try {
    Get-Service | Where-Object {$_.Name -like "*PSEXE*"} | Stop-Service -Force
    Write-Host '  [OK] Command executed successfully' -ForegroundColor Green
} catch {
    Write-Host '  [ERROR] Command failed: $_' -ForegroundColor Red
    $_ | Out-File -Append '$logDir\errors.log'
}


# ============================================================================
# Remediation for T1550.002: Pass-the-Hash
# ============================================================================

Write-Host '[+] Applying fixes for Pass-the-Hash...' -ForegroundColor Yellow

try {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "LsaCfgFlags" -Value 1
    Write-Host '  [OK] Command executed successfully' -ForegroundColor Green
} catch {
    Write-Host '  [ERROR] Command failed: $_' -ForegroundColor Red
    $_ | Out-File -Append '$logDir\errors.log'
}

try {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" -Name "NtlmMinClientSec" -Value 537395200
    Write-Host '  [OK] Command executed successfully' -ForegroundColor Green
} catch {
    Write-Host '  [ERROR] Command failed: $_' -ForegroundColor Red
    $_ | Out-File -Append '$logDir\errors.log'
}

try {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RunAsPPL" -Value 1
    Write-Host '  [OK] Command executed successfully' -ForegroundColor Green
} catch {
    Write-Host '  [ERROR] Command failed: $_' -ForegroundColor Red
    $_ | Out-File -Append '$logDir\errors.log'
}


# ============================================================================
# Remediation for T1550.003: Pass-the-Ticket
# ============================================================================

Write-Host '[+] Applying fixes for Pass-the-Ticket...' -ForegroundColor Yellow

try {
    klist purge
    Write-Host '  [OK] Command executed successfully' -ForegroundColor Green
} catch {
    Write-Host '  [ERROR] Command failed: $_' -ForegroundColor Red
    $_ | Out-File -Append '$logDir\errors.log'
}

try {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters" -Name "LogLevel" -Value 1
    Write-Host '  [OK] Command executed successfully' -ForegroundColor Green
} catch {
    Write-Host '  [ERROR] Command failed: $_' -ForegroundColor Red
    $_ | Out-File -Append '$logDir\errors.log'
}


# ÉTAPE FINALE: Rapport
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Remediation Complete" -ForegroundColor Green
Write-Host "Logs saved to: $logDir" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Cyan

# Créer un rapport
@"
APT41 Incident Response Report
===============================
Date: $(Get-Date)
System: {system_name}
Techniques Addressed: {', '.join(techniques)}

Actions Taken:
- RDP Lateral Movement: Applied 2 fixes
- SMB/PsExec: Applied 4 fixes
- Pass-the-Hash: Applied 3 fixes
- Pass-the-Ticket: Applied 2 fixes

Next Steps:
1. Review logs in $logDir
2. Monitor for 24 hours
3. Validate credential changes
4. Update Wazuh rules

"@ | Out-File "$logDir\response_report.txt"

Write-Host "[+] Response report created" -ForegroundColor Green
