@echo off
for /f "usebackq delims=" %%i in (`zoxide query -i -- %*`) do (
    cd /d "%%i"
    goto :eof
)
