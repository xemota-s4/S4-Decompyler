@echo off
@title 
setlocal enabledelayedexpansion
SET VERSION=0.0.2
SET "GAME_FILE=GameFiles"

:: ------------------------------------------------------------------------------------------------
:: Detect Gamefiles folder
:: ------------------------------------------------------------------------------------------------

if not exist "%GAME_FILE%\" (
    mkdir %GAME_FILE%
)


:: ------------------------------------------------------------------------------------------------
:: 0. Detect uncompyle6 / decompile3
:: ------------------------------------------------------------------------------------------------
:DECOMPYLEFILE
set pyminver=3.7.0
set dcminver=3.7.6
set ucminver=3.7.4

FOR /F "tokens=* USEBACKQ" %%F IN (`py --version`) DO (SET py3=%%F)
set "py3=%py3:* =%"

FOR /F "tokens=* USEBACKQ" %%F IN (`decompyle3.exe --version`) DO (SET dcp3=%%F)
set "dcp3=%dcp3:* =%"

FOR /F "tokens=* USEBACKQ" %%F IN (`uncompyle6.exe --version`) DO (SET ucp6=%%F)
set "ucp6=%ucp6:* =%"

rem version check now in a function (tm)
CALL :VersionCheck python "%py3%" "%pyminver%"
CALL :VersionCheck "decompyle3" "%dcp3%" "%dcminver%"
CALL :VersionCheck "uncompyle6" "%ucp6%" "%ucminver%"
CALL :VersionCheck "unpyc3" "3.11" "x.xx"
echo.

if "%PREREQUIRED_NOT_SATIFIED%"=="1" goto :EndProgramFailure

echo Tap on any key to continue..
timeout 10 >nul 2>&1

:: ------------------------------------------------------------------------------------------------
:: 1. Method select to detect Zip files
:: ------------------------------------------------------------------------------------------------
:loop_user_method_selection
cls
CALL :Tittle
CALL :ZipMethod
echo Method selected: %choice%
timeout 2 >nul 2>&1

if "%choice%"=="1" CALL :Method1_AutoS4PathDetection
if "%choice%"=="2" CALL :Method2_UserS4Path
if "%choice%"=="3" CALL :Method3_waiting_for_zip
goto :loop_user_method_selection


:: --------------------------------------------------
:: 2. Ask output folder 
:: --------------------------------------------------
:START_PROCESS
echo Output folder configuration ...
set /p OUTPUT_NAME=Output directory name : 
set /p OUTPUT_PATH=Path where output directory should created : 
set "FOLDER_OUTPUT=%OUTPUT_PATH%\%OUTPUT_NAME%"
echo.

:: --------------------------------------------------
:: 2. Paths info
:: --------------------------------------------------
echo Paths information : 
CALL :ProgramPaths "%FOLDER_OUTPUT%"
echo.

:: --------------------------------------------------
:: 3. ZIP files detction and uncompressing
:: --------------------------------------------------
echo ZIP - Detection and unzipping...
CALL :ZipDetectUnzip "%FOLDER_OUTPUT%"
echo.


:: --------------------------------------------------
:: 6. Browse extracted files
:: --------------------------------------------------
echo Exploration des fichiers extraits...
echo.
echo Next step : Uncompyling S4 Game python script
echo Tap on any key to continue..
pause >nul 2>&1
echo.

rem start time
for /f %%i in ('powershell -NoProfile -Command "[DateTimeOffset]::Now.ToUnixTimeMilliseconds()"') do set START=%%i

CALL :display_tree_folder "%FOLDER_OUTPUT%" "base"
CALL :uncompyle_repertory "%FOLDER_OUTPUT%\base"

CALL :display_tree_folder "%FOLDER_OUTPUT%" "core"
CALL :uncompyle_repertory "%FOLDER_OUTPUT%\core"

CALL :display_tree_folder "%FOLDER_OUTPUT%" "simulation"
CALL :uncompyle_repertory "%FOLDER_OUTPUT%\simulation"

rem end time
for /f %%i in ('powershell -NoProfile -Command "[DateTimeOffset]::Now.ToUnixTimeMilliseconds()"') do set END=%%i
for /f %%i in ('powershell -NoProfile -Command "%END% - %START%"') do set ELAPSED=%%i

:: --------------------------------------------------
:: FIN
:: --------------------------------------------------
echo.
echo ==================================================
echo FIN DU PROCESS
echo OUTPUT : %FINAL_OUTPUT%
echo TEMP   : %UNZIP_TEMP%
echo TIME ELAPSED : %ELAPSED%
echo ==================================================
pause
Exit 0

:EndProgramFailure
echo.
echo Requires not statisfied. Please fix them, then retry. 
echo End of program.
echo.
pause 
Exit 0

:EndProgramDev
echo.
echo  _______________________________________________________
echo ^|                                                      ^|
echo ^| --^> Please retry and use the method number 2 or 3.   ^|
echo ^|______________________________________________________^| 
echo.
echo End of program.
pause
Exit 0


rem ----------------------------------------------------------------------------
:VersionCheck
set "program=%~1"
set "cur_ver=%~2"
set "min_ver=%~3"

echo Checking %program% version

if "%cur_ver%"=="" (
    echo Current : %cur_ver%  [Min : %min_ver%]	
    echo [STATUS] %program% not found
    echo.
    set "PREREQUIRED_NOT_SATIFIED=1"
    exit /b
)

echo Current : %cur_ver%  [Min : %min_ver%]
echo [STATUS] Checking Ok  
exit /b

rem ----------------------------------------------------------------------------

:ProgramPaths
set "output=%~1"
set "SCRIPT_DIR=%~dp0"

echo Script fullpath   - %SCRIPT_DIR%

if not exist "%output%" (
    mkdir "%output%"
    echo Output directory  - %output%
    echo [STATUS] Output folder created
) else (
    echo Output directory  - %output% 
    echo [STATUS] Output folder already exists
)

timeout 3 >nul 2>&1

exit /b


rem -------------------------------------------------------------------------------
:ZipDetectUnzip
set "output_folder=%~1"

for %%F in (%GAME_FILE%\*.zip) do (
    echo    [DETECTING] ZIP found : %%~nxF

    powershell -command ^
        "Expand-Archive -Path '%%~fF' -DestinationPath '%output_folder%\%%~nF' -Force"

    set /a ZIP_COUNT+=1
)

echo Total ZIP traites : !ZIP_COUNT!
echo.

exit /b


rem -------------------------------------------------------------------------------

:display_tree_folder
set "output_folder=%~1"
set "folder=%~2"

echo %output_folder%
echo _________________________________________________ 
echo _________________________________________________ >> Uncompiling.log
echo.
echo.  						       >> Uncompiling.log
echo           Structure of %folder% folder		       
echo           Structure of %folder% folder            >> Uncompiling.log
echo _________________________________________________ 
echo _________________________________________________ >> Uncompiling.log
tree "%output_folder%\%folder%" /f                        
tree "%output_folder%\%folder%"                        >> Uncompiling.log
echo.
echo.						       >> Uncompiling.log
echo.
exit /b


rem --------------------------------------------------------------------------------

:uncompyle_repertory
set "folder_to_uncompyle=%~1"
set /a PYC_COUNT=0
set /a OK_COUNT=0
set /a FAIL_COUNT=0

echo Uncompiling files...

for /r "%folder_to_uncompyle%" %%F in (*.pyc) do (
    set /a PYC_COUNT+=1
    set "file=%%F"
    echo Decompiling : !file!
    echo FICHIER : !file! >> Uncompiling.log

    decompyle3 -o %%~dpF "!file!" >nul 2>&1

    if errorlevel 1 (
        echo [WARNING] decompyle3 failed, trying uncompyle6
        uncompyle6 -o %%~dpF "!file!" >nul 2>&1
      
        if errorlevel 1 (
            echo [WARN] uncompyle6 failed, trying unpyc3

            py "%UNPYC%" "!file!" > "%%~dpnF.py" >nul 2>&1

            if exist "%%~dpnF.py" (
                echo [OK] Decompiled with unpyc3
                set /a OK_COUNT+=1
                echo.
                if exist "%%~dpnF.py" del /f /q "!file!" 
            ) else (
                echo [ERROR] Could not decompile !file!
                set /a FAIL_COUNT+=1
                echo.
            )
        ) else (
            echo [OK] Decompiled with uncompyle6
            set /a OK_COUNT+=1
            echo.
            if exist "%%~dpnF.py" del /f /q "!file!" 
        )
    ) else (
        echo [OK] Decompiled with decompyle3
        set /a OK_COUNT+=1
        echo.
        if exist "%%~dpnF.py" del /f /q "!file!"
    )
)

echo.
echo _________________________________________________________________________________________
echo.
echo UNCOMPILLING RESULTS
echo _________________________________________________________________________________________
echo .pyc files found           : %PYC_COUNT%
echo Successfully uncompiled    : %OK_COUNT%
echo Failed to uncompiled       : %FAIL_COUNT%
echo _________________________________________________________________________________________

exit /b

:Tittle
echo _________________________________________________________________________________________
echo.
echo                             S4Decompyler - v%VERSION%  
echo _________________________________________________________________________________________
echo.
exit /b

:ZipMethod
echo The first step is to detect the base, core and simultation .zip files.
echo There is 3 methods available. Select the one you feel more confortable.
echo.
echo  [1] Automatic folder detection
echo      - The script will try to find the folder automatically.
echo.
echo  [2] Copy/paste the path folder of your Sims4 executable
echo      - The script needs the folder where the sims4.exe is to detect it
echo.
echo  [3] Manual folder creation
echo      - A new folder will be created, and you must place your ZIP files inside it.
echo.
set /p CHOICE=Please select an option (1, 2 or 3): 

exit /b


:Method1_AutoS4PathDetection
cls
echo In development
goto :EndProgramDev




:Method2_UserS4Path
cls
echo Enter the folder path where the TS4_x64.exe is located on your disk.
set /p "PATH_S4_GAME=directory path: "

rem check the input of the user, if the folder exists
if not exist "%PATH_S4_GAME%\" (
    echo ERROR: Directory not found.
    goto :EndProgramFailure
)

rem go 2 folders above (Game\Bin -> Sims 4 root)
for %%I in ("%PATH_S4_GAME%\..\..") do set "GAME_ROOT=%%~fI"

set "GAME_ZIP_PATH=%GAME_ROOT%\Data\Simulation\Gameplay"

rem check if the Gameplay folder exists
if not exist "%GAME_ZIP_PATH%\" (
    echo ERROR: Gameplay folder not found.
    echo Expected location: "%GAME_ZIP_PATH%"
    goto :EndProgramFailure
)

rem copy .zip in GameFiles folder 
echo Copying of .zip files in GameFiles folder [...]
robocopy "%GAME_ZIP_PATH%" "%GAME_FILE%" *.zip  >nul 2>&1

goto :START_PROCESS


:Method3_waiting_for_zip
cls
echo This method assumes that those files are in ./GameFiles folder :
echo     + core.zip, 
echo     + base.zip,
echo     + simulation.zip 
echo.
echo Check the Sims 4 folder at 'C:\Program Files\EA Games\The Sims 4\Data\Simulation\Gameplay'
echo Copy and paste these files in ./GameFiles with this script in ./.
echo.
echo Tap on any key to continue..
pause >nul 2>&1
echo.
goto :START_PROCESS
