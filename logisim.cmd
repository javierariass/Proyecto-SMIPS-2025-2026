@echo off
REM logisim.cmd - wrapper that prefers local logisim.exe, else uses LOGISIM_JAR
setlocal
set SCRIPT_DIR=%~dp0
set LOCAL_EXE=%SCRIPT_DIR%logisim.exe
if exist "%LOCAL_EXE%" (
  "%LOCAL_EXE%" %*
  endlocal
  exit /b %ERRORLEVEL%
)
if not "%LOGISIM_JAR%"=="" (
  java -jar "%LOGISIM_JAR%" %*
  endlocal
  exit /b %ERRORLEVEL%
)
echo logisim.exe not found in project folder and LOGISIM_JAR not set.
echo Put logisim.exe in the project directory or set LOGISIM_JAR to the jar path.
echo Example: setx LOGISIM_JAR "C:\path\to\logisim-evolution.jar"
endlocal
exit /b 1
