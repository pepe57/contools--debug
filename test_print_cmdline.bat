@echo off

setlocal DISABLEDELAYEDEXPANSION

(
  setlocal DISABLEEXTENSIONS
  (PROMPT=$_)
  echo on
  for %%z in (%%z) do ^
rem |%*|
  @echo off
  endlocal
)
