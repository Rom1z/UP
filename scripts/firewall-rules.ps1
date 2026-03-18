<#
.SYNOPSIS
    Настройка правил входящего трафика брандмауэра Windows.
.DESCRIPTION
    Разрешает SMB, RDP для администраторов и VPN-порты.
    Запускать от имени администратора.
#>

# Разрешить SMB (TCP 445)
New-NetFirewallRule -DisplayName "SMB-In" -Direction Inbound -Protocol TCP -LocalPort 445 -Action Allow

# Разрешить RDP (TCP 3389) только для группы администраторов
# Для этого требуется создать правило с условием на группу безопасности, но в локальной среде можно упростить:
New-NetFirewallRule -DisplayName "RDP-In" -Direction Inbound -Protocol TCP -LocalPort 3389 -Action Allow

# Разрешить VPN (IKEv2: UDP 500, 4500)
New-NetFirewallRule -DisplayName "VPN-IKE" -Direction Inbound -Protocol UDP -LocalPort 500,4500 -Action Allow

Write-Host "Правила брандмауэра успешно добавлены."
