@echo off
setlocal enabledelayedexpansion

set TEMP_PATH=%PATH%
set PATH="C:\Windows\Microsoft.NET\Framework\v4.0.30319"
set RUN_FLAG=0
set SOURCE_FILE=
set CSC_ARGS=
set EXE_FILE=

for %%i in (%*) do (
    if %%i==/run (
        set RUN_FLAG=1
    ) else if %%i==/r (
        set RUN_FLAG=1
    ) else (
        set CSC_ARGS=!CSC_ARGS! %%i
    )

    set v=%%i
    set prefix=!v:~0,1!
    if not !prefix!==/ (
        set SOURCE_FILE=!v!
    )
)

call :exe %CSC_ARGS%
echo.

if exist !EXE_FILE! (
    del !EXE_FILE!
)

set PATH=%TEMP_PATH%
endlocal

exit /b

:exe


csc.exe %*

if %RUN_FLAG%==1 (
    set EXE_FILE=%SOURCE_FILE:cs=exe%
    if exist !EXE_FILE! (
        echo.
        echo .\!EXE_FILE!
        echo.
        .\!EXE_FILE!
    )
)
exit /b

