@echo off

setlocal

call "%%~dp0__init__\__init__.bat" || exit /b

set PLACEHOLDER10=0123456789

set __TMPL_SCRIPT__=ExecuteGlobal("Close() : Set objShell = CreateObject(""WScript.Shell"") : objShell.Popup ""{{STR}}""")

call :GENSTR 0

call set __SCRIPT__=%%__TMPL_SCRIPT__:{{STR}}=%STR%%%

call "%%CONTOOLS_ROOT%%/std/strlen.bat" /v __SCRIPT__

set OVERHEAD_LEN=%ERRORLEVEL%

echo Shows a popup:
call :POPUP 498

echo Does not show anything:
call :POPUP 499
call :POPUP 500

exit /b

:POPUP
set /A "STR_LEN=%~1+0"

if %STR_LEN% GTR %OVERHEAD_LEN% (
  set /A REMINDER_LEN=STR_LEN-OVERHEAD_LEN
) else set REMINDER_LEN=0

call :GENSTR %%REMINDER_LEN%%

call set __SCRIPT__=%%__TMPL_SCRIPT__:{{STR}}=%STR%%%

call "%%CONTOOLS_ROOT%%/std/strlen.bat" /v __SCRIPT__

echo Script length: %ERRORLEVEL%
"%SystemRoot%\System32\mshta.exe" vbscript:%__SCRIPT__%
exit /b

:GENSTR
set "LEN=%~1"

set /A INT=LEN / 10
set /A REM=LEN %% 10

set "STR="

for /L %%i in (1,1,%INT%) do call set "STR=%%STR%%%%PLACEHOLDER10%%"
if %REM% NEQ 0 call set "STR=%%STR%%%%PLACEHOLDER10:~0,%REM%%%"
