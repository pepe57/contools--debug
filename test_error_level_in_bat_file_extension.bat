@echo off

rem NOTE: `setlocal DISABLEEXTENSIONS` is not tested

setlocal

rem echo pre tests at first
echo --- `echo` pre tests ---

call;
echo ERRORLEVEL=%ERRORLEVEL%
echo ERRORLEVEL=%ERRORLEVEL%
if %ERRORLEVEL% EQU 0 ( echo - PASSED. ) else echo - FAILED.

(call)
echo ERRORLEVEL=%ERRORLEVEL%
echo ERRORLEVEL=%ERRORLEVEL%
if %ERRORLEVEL% EQU 1 ( echo - PASSED. ) else echo - FAILED.

echo ---

echo --- `set` tests on empty/not empty value ---

rem 1.1. ERRORLEVEL=0
call;
set "A=123"
(
  if %ERRORLEVEL% EQU 0 ( <nul set /P "=PASSED: " ) else <nul set /P "=FAILED: "
  echo 1.1. ERRORLEVEL=`0-^>%ERRORLEVEL%` EXPR=`set "A=123"`
)

rem 1.2. ERRORLEVEL=1
(call)
set "A=123"
(
  if %ERRORLEVEL% EQU 1 ( <nul set /P "=PASSED: " ) else <nul set /P "=FAILED: "
  echo 1.2. ERRORLEVEL=`1-^>%ERRORLEVEL%` EXPR=`set "A=123"`
)

rem 2.1. ERRORLEVEL=0
call;
set "A="
(
  if %ERRORLEVEL% EQU 0 ( <nul set /P "=PASSED: " ) else <nul set /P "=FAILED: "
  echo 2.1. ERRORLEVEL=`0-^>%ERRORLEVEL%` EXPR=`set "A="`
)

rem 2.2. ERRORLEVEL=1
(call)
set "A="
(
  if %ERRORLEVEL% EQU 1 ( <nul set /P "=PASSED: " ) else <nul set /P "=FAILED: "
  echo 2.2. ERRORLEVEL=`1-^>%ERRORLEVEL%` EXPR=`set "A="`
)

rem 3.1. ERRORLEVEL=1
call;
<nul set /P "A=123"
echo;
(
  if %ERRORLEVEL% EQU 1 ( <nul set /P "=PASSED: " ) else <nul set /P "=FAILED: "
  echo 3.1. ERRORLEVEL=`0-^>%ERRORLEVEL%` EXPR=`^<nul set /P "A=123"`
)

rem 3.2. ERRORLEVEL=1
(call)
<nul set /P "A=123"
echo;
(
  if %ERRORLEVEL% EQU 1 ( <nul set /P "=PASSED: " ) else <nul set /P "=FAILED: "
  echo 3.2. ERRORLEVEL=`1-^>%ERRORLEVEL%` EXPR=`^<nul set /P "A=123"`
)

rem 4.1. ERRORLEVEL=1
call;
<nul set /P "A="
(
  if %ERRORLEVEL% EQU 1 ( <nul set /P "=PASSED: " ) else <nul set /P "=FAILED: "
  echo 4.1. ERRORLEVEL=`0-^>%ERRORLEVEL%` EXPR=`^<nul set /P "A="`
)

rem 4.2. ERRORLEVEL=1
(call)
<nul set /P "A="
(
  if %ERRORLEVEL% EQU 1 ( <nul set /P "=PASSED: " ) else <nul set /P "=FAILED: "
  echo 4.2. ERRORLEVEL=`1-^>%ERRORLEVEL%` EXPR=`^<nul set /P "A="`
)

echo ---
