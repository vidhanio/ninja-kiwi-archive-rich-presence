@echo off

set directory=%~dp0
Pushd %directory%

echo I need to find the location of the Ninja Kiwi Archive on your computer, and the easiest way to do that is for you to open it and see where it came from

echo Checking admin rights...
net session 1>nul 2>nul

if not '%ERRORLEVEL%'=='0' (
echo Admin rights not detected. Please run with admin perms
pause
EXIT /B
)

auditpol /set /category:{6997984C-797A-11D9-BED3-505054503030} /success:enable>nul

taskkill /im "Ninja Kiwi Archive.exe" 1>nul 2>nul

echo Please ensure Ninja Kiwi Archive is closed then reopen it. once you have reopened Ninja Kiwi Archive, come back here and press any key to continue
pause>nul

wevtutil qe Security /c:200 /f:text /rd:true /q:"*[System[(EventID=4688)]]">openedfiles.dat

findstr /i "Ninja Kiwi Archive.exe" openedfiles.dat>ninjakiwilocation.dat

set /p loc=<ninjakiwilocation.dat

echo Ninja Kiwi Archive is at %loc:~19%

set /a "result=%result%-19"

call set parsed=%loc:~19%

rem debug echo %parsed%

set /p fgiddle=<LinkWithKiwipt5.dat

>ninjakiwilocation.dat (
echo|set /p="%parsed%%fgiddle%"
)

del openedfiles.dat 1>nul 2>nul

if "%parsed%"=="~19" (
echo TASK FAILED. please run me again and make sure that Ninja Kiwi Archive is closed when you start me.
) else (
echo task completed.
)

pause