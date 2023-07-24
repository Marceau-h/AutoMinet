@echo off
rem Activation de l'environnement virtuel
echo Activation de l'environnement virtuel...
call venv\Scripts\activate
if %errorlevel% neq 0 (
    echo Erreur lors de l'activation de l'environnement virtuel.
    exit /b 1
)


echo Vérification des cookies...
for /f "usebackq delims=" %%I in (`minetcookies %*`) do set OUTPUT=%%I || goto :exit_on_error
REM echo %OUTPUT%

echo Récupération des données...
echo minet %*
minet %* -o temp.csv

if "%~1"=="tiktok" (
    echo Récolte des vidéos...
    tksel temp.csv %3 || goto :exit_on_error  REM --no-headless
    REM echo "on tente de copier"
    REM copy temp.csv "%OUTPUT:~0,-1%/meta.csv" || goto :exit_on_error
    echo "découpe dans pellipop"
    pellipop --input "%OUTPUT:~0,-1%" --frequency 1 --remove_duplicates || goto :exit_on_error
) else (
    type temp.csv || goto :exit_on_error
)

del temp.csv

exit /b

:exit_on_error
echo Une erreur s'est produite. Arrêt du script.
exit /b
