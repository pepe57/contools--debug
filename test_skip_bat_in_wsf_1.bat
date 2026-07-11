<!-- : bat in vbs skip

@echo off

setlocal

"%SystemRoot%\System32\cscript.exe" //NOLOGO //JOB:TEST_SKIP_BAT_IN_WSF "%~f0?.wsf"
exit /b 0

rem end of bat -->

<package>
  <job id="TEST_SKIP_BAT_IN_WSF">
    <script language="VBScript">
      WScript.Echo "PASSED."
    </script>
  </job>
</package>
