# Script de limpieza automatica para descargas
# Se ejecuta diariamente via tareas programadas

@echo off
setlocal

echo Limpiando descargas antiguas...
forfiles /p "C:\docker-services\media\downloads\completed" /s /m *.* /d -30 /c "cmd /c del @path"
forfiles /p "C:\docker-services\media\downloads\incomplete" /s /m *.* /d -7 /c "cmd /c del @path"

echo Limpieza completada:  echo endlocal
