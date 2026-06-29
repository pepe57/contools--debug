@echo off

setlocal

call :TEST 01 setlocal

setlocal DISABLEDELAYEDEXPANSION

call :TEST 02 setlocal DISABLEDELAYEDEXPANSION

setlocal ENABLEDELAYEDEXPANSION

call :TEST 03 setlocal ENABLEDELAYEDEXPANSION

endlocal

call :TEST 04 endlocal

endlocal

call :TEST 05 endlocal

exit /b

:TEST
echo;%*
if not "!!" == "" echo;-- DISABLED: "!!" == ""
if "!!" == "" echo;-- ENABLED: "!!" == ""
