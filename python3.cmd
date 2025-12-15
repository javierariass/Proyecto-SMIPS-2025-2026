@echo off
where py >nul 2>&1
if %ERRORLEVEL%==0 (
    py -3 %*
) else (
    where python >nul 2>&1
    if %ERRORLEVEL%==0 (
        python %*
    ) else (
        echo Python not found. Install Python or set PATH.
        exit /b 1
    )
)
