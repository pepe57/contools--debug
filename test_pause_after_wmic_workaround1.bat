@echo off

setlocal

rem script restarts with the pause on exit
if %IMPL_MODE%0 NEQ 0 goto IMPL
"%~dp0_externals\contools--utils\bin\contools\callf.exe" /v IMPL_MODE 1 /no-expand-env /no-subst-pos-vars /no-esc /pause-on-exit // ^
  "%COMSPEC%" "/c \"@\"%~f0\" {*}\"" ^
  %*
exit /b

:IMPL
rem wait without pause to be able to press a key before the `wmic.exe` run
for /L %%i in (1,1,10000) do echo %%i

del /F /Q /A:-D ".temp\out.txt" >nul 2>nul

rem execute with new minimized console and does print into a file
start "" /MIN /WAIT "%SystemRoot%\System32\wbem\wmic.exe" /OUTPUT:.temp\out.txt path Win32_OperatingSystem get LocalDateTime /VALUE

type .temp\out.txt
