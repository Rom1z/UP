```powershell
<#
.SYNOPSIS
    Устанавливает драйверы из указанной папки.
.DESCRIPTION
    Рекурсивно ищет INF-файлы в заданном каталоге и устанавливает их с помощью pnputil.
.PARAMETER DriverPath
    Путь к папке с драйверами.
.EXAMPLE
    .\install-drivers.ps1 -DriverPath "C:\Drivers"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$DriverPath
)

if (-not (Test-Path $DriverPath)) {
    Write-Error "Папка $DriverPath не найдена."
    exit 1
}

$infFiles = Get-ChildItem -Path $DriverPath -Filter *.inf -Recurse
if ($infFiles.Count -eq 0) {
    Write-Host "INF-файлы не найдены."
    exit 0
}

foreach ($inf in $infFiles) {
    Write-Host "Установка драйвера: $($inf.FullName)"
    & pnputil /add-driver $inf.FullName /install
}

Write-Host "Установка драйверов завершена."
```
