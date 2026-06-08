@echo off

rem CAUTION:
rem   The `+` is affected by `65000` (UTF-7) code page because is the Unicode
rem   shift character (See RFC 2152).
rem   For example, the expressions like set /A X=1+1 and any other including
rem   the plus character will be malformed.

rem repro: Windows XP/7/8.1

setlocal

set TEST=0

echo;1. `plus` sign does WORK HERE:
chcp.com 437
echo;=+002B=
cmd.exe /C @echo;=+002B=
set /A TEST+=1
echo TEST=%TEST%
echo;---
rem CAUTION: being loaded text line must not contain NUL, CR or LF character
for /F "usebackq tokens=* delims="eol^= %%i in ("ascii-nocrlf.txt") do set "CHARS_NOCRLF=%%i"
set CHARS_NOCRLF > temp.dat
rem CAUTION: will print not all characters!
type temp.dat
echo;
echo;---
for /F "usebackq tokens=* delims="eol^= %%i in ("temp.dat") do echo;%%i
echo;===

rem workaround for the 65000 active codepage
set "?2B=+"

echo;2. `plus` sign is BROKEN HERE:
chcp.com 65000
echo;=+002B=
cmd.exe /C @echo;=+002B=
set /A TEST+=1
echo TEST=%TEST%
echo;---
rem CAUTION: will encode characters using base64 like code point sequence: `+X..X-`
set CHARS_NOCRLF > temp.dat
rem CAUTION: will leave artefacts after decoding
type temp.dat
echo;---
rem NOTE: won't leave artefacts after decoding, but does not print control characters like at 437 code page
for /F "usebackq tokens=* delims="eol^= %%i in ("temp.dat") do echo;%%i
echo;===


echo;3. `plus` sign is WORKAROUNDED HERE:
echo;=%?2B%002B=
rem NOTE: `cmd.exe` has a command line double expansion
cmd.exe /C @echo;=%%?2B%%002B=
set /A TEST=1%?2B%1
echo TEST=%TEST%
echo;===

echo;4. `plus` sign again does WORK HERE!
chcp.com 65001
echo;=+002B=
cmd.exe /C @echo;=+002B=
set /A TEST+=1
echo TEST=%TEST%
rem NOTE: will encode characters using utf-8
set CHARS_NOCRLF > temp.dat
rem CAUTION: print will be truncated!
type temp.dat
echo;
echo;---
rem NOTE: won't leave artefacts after decoding, but does not print control characters like at 437 code page
for /F "usebackq tokens=* delims="eol^= %%i in ("temp.dat") do echo;%%i
echo;===

del /F /Q /A:-D temp.dat
