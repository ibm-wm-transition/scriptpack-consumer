@echo off
setlocal EnableExtensions EnableDelayedExpansion

set WORKDIR=%~dp0
set WORKDIR=%WORKDIR:~0,-1%
set DEFAULT_APP_HOME=%WORKDIR%
set APP_HOME=%DEFAULT_APP_HOME%

if -%1-==-- set SHOW_HELP=1
for %%i in (%*) do (
  if defined INSTALL_DIR set APP_HOME=%%~i& set INSTALL_DIR=

  if -%%~i-==--d- set INSTALL_DIR=1
  if -%%~i-==--h- set SHOW_HELP=1
  if -%%~i-==---h- set SHOW_HELP=1
  if -%%~i-==---help- set SHOW_HELP=1
  if -%%~i-==---internal-skip-privilege-check- set SKIP_PRIV_CHECK=1
)

if defined SHOW_HELP (
    echo Usage: %~n0 [Options...]
    echo.
    echo Options:
    echo        -h, --h,--help            This usage help.
    echo        -d C:\myapp               Target installation directory.
    echo.
    exit /b 0
)

if %APP_HOME:~-1%==\ set APP_HOME=%APP_HOME:~0,-1%

md "%APP_HOME%" 2> NUL


REM PAYLOAD-EXTRACT-CODE


:runApp
set JAVA="%APP_HOME%\jvm\bin\java"

set CLASSPATH=
for %%i in ("!APP_HOME!\libs\*.jar") do (
    if defined CLASSPATH (
        set CLASSPATH=!CLASSPATH!;"%%i"
    ) else (
        set CLASSPATH="%%i"
    )
)

%JAVA% -cp !CLASSPATH! com.softwareag.scriptpack.consumer.Main %*

endlocal

exit /B %ERRORLEVEL%

@@@