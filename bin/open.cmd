@echo off
if "%~1"=="" (
    explorer.exe .
) else (
    explorer.exe %*
)
