@echo off
rem setlocal ENABLEDELAYEDEXPANSION

set directory=%~dp0
Pushd %directory%

set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0 %params%""", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

echo Checking admin rights...
net session>nul

cls

if not '%ERRORLEVEL%'=='0' (
echo Admin rights not detected. Please run with admin perms
pause
EXIT /B
)

if not exist ninjakiwilocation.dat call FindNinjaKiwi.bat

rem if not exist %loc% set /a "loc=%%loc:~0,%result%%%"

echo Setting security logger
auditpol /set /category:{6997984C-797A-11D9-BED3-505054503030} /success:enable>nul

(type LinkWithKiwipt1.xml && type ninjakiwilocation.dat && type LinkWithKiwipt4.xml)>LinkWithKiwiOpen.xml
for %%a in ("%cd%") do set "p_dir=%%~dpa"
echo %p_dir%
echo %p_dir%\RunHidden.vbs>>LinkWithKiwiOpen.xml
type LinkWithKiwipt2.xml>>LinkWithKiwiOpen.xml

echo Creating tasks
schtasks /create /tn NinjaKiwiRichPresenceOpen /XML LinkWithKiwiOpen.xml

pause

exit

:fnf
echo Could not locate Ninja Kiwi Archive.exe
pause
exit
goto :eof