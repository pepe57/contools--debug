@echo off

setlocal DISABLEDELAYEDEXPANSION

cd "%~dp0"

set "REM_ECHO=_externals\userbin\scripts\bat\rem-echo.bat"

set ?.=^^^<nul 2^^^>nul start "" /B /WAIT cmd.exe /c @start "" /WAIT cmd.exe /k @echo close me!

set ?.

echo ---

PROMPT=$S$H
echo on

@echo 1. exe cmdline expansion

"%COMSPEC%" /c @"%%REM_ECHO%%" %%?.%%

@echo ---

@echo 2. start+exe cmdline expansion with old environment

start "" /I /B /WAIT "%COMSPEC%" /c @"%REM_ECHO%" %%?.%%

@echo ---

@echo 3. call+script expansion

call "%%REM_ECHO%%" %%?.%%

@echo ---

@echo 4. script w/o call expansion

"%REM_ECHO%" %?.%
