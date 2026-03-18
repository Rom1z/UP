
@echo off
rem Скрипт для подключения сетевого диска Z: к общей папке Docs
net use Z: \\SRV-FILE\Docs /persistent:yes
if %errorlevel% equ 0 (
    echo Сетевой диск Z: успешно подключён.
) else (
    echo Ошибка подключения сетевого диска.
)
pause
