@echo off
if "%~1"=="" cd /d "%USERPROFILE%" & goto :eof
for /f "usebackq delims=" %%i in (`zoxide query -- %*`) do (
    cd /d "%%i"
    goto :eof
)
