@ECHO OFF

IF "%1"=="" (
    ECHO "Usage: %0% <filename> <srcroot>"
    EXIT 1
)

::SETLOCAL ENABLEEXTENSIONS

SET FILE=%1

IF EXIST %1% (
    FOR /f "tokens=3 skip=1" %%i in (build.h) DO SET OLDINFO=%%~i
)

IF NOT "%2" == "" (
    cd %2
    SET gitdir=%2%
) ELSE (
    SET gitdir=%cd%
)

IF EXIST .git (
    git diff >NUL 2>&1
    FOR /f %%i in ('git describe --dirty') DO SET REPO_DESC=%%i
    FOR /f %%j in ('git log -n 1 --format^=%%ci') DO SET REPO_TIME=%%j
) ELSE (
    echo %gitdir% must be the root of git repository!
)

IF NOT "%REPO_DESC%" == "" (
    SET NEWINFO=#define BUILD_DESC "%REPO_DESC%"
) ELSE (
    SET NEWINFO=// No build information available
)

:: only update build.h if necessary
if NOT "%OLDINFO%" == "%REPO_DESC%" (
    echo Generate new build-info file ^=^>  %FILE%

    echo #define BUILD_DATE "%REPO_TIME%" >%FILE%
    echo #define BUILD_DATE "%REPO_TIME%" 

    echo %NEWINFO% >>%FILE%
    echo %NEWINFO%

) ELSE ( echo "no new build-info")

::ENDLOCAL