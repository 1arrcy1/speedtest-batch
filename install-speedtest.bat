@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
echo installing speedtest-cli
timeout 3

if exist %appdata%\speedtest (
  GOTO start
) else (
  GOTO install
)

:install
mkdir %appdata%\speedtest
cd %appdata%\speedtest
curl -L -O https://github.com/1arrcy1/speedtest-batch/archive/refs/heads/main.zip
powershell -command "expand-archive main.zip"
cd main
cd speedtest-batch-main
move /Y speedtest.exe ..\..
move /Y speedtest.md ..\..
move /Y src ..\..
move /Y test-csv.ps1 ..\..
move /Y main.ipynb ..\..
cd ..
cd ..
RD /S /Q main
del /F /Q main.zip
cls
GOTO start

:start
cd %appdata%\speedtest
Powershell -executionpolicy remotesigned -File test-csv.ps1
echo saved to downloads
pause
exit
