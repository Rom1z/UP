<#
.SYNOPSIS
    Мониторинг свободного места на диске C: и отправка уведомления по почте.
.DESCRIPTION
    Если свободное место менее 10%, отправляется email администратору.
    Требуется настроить параметры SMTP-сервера.
#>

$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$freePercent = ($disk.FreeSpace / $disk.Size) * 100
$threshold = 10

if ($freePercent -lt $threshold) {
    $smtpServer = "192.168.1.1"   # замените на ваш SMTP-сервер
    $from = "monitor@company.local"
    $to = "admin@company.local"
    $subject = "⚠️ Низкий запас свободного места на сервере"
    $body = "На диске C: осталось {0:N2}% свободного места." -f $freePercent

    try {
        Send-MailMessage -SmtpServer $smtpServer -From $from -To $to -Subject $subject -Body $body
        Write-Host "Уведомление отправлено."
    } catch {
        Write-Error "Ошибка отправки почты: $_"
    }
} else {
    Write-Host "Свободного места достаточно: $freePercent%"
}
