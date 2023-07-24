@echo off

rem Création de l'environnement virtuel
echo Création de l'environnement virtuel...
python -m venv venv
if %errorlevel% neq 0 (
    echo Erreur lors de la création de l'environnement virtuel.
    exit /b 1
)

rem Activation de l'environnement virtuel
echo Activation de l'environnement virtuel...
call venv\Scripts\activate
if %errorlevel% neq 0 (
    echo Erreur lors de l'activation de l'environnement virtuel.
    exit /b 1
)

rem Installation des dépendances
echo Installation des dépendances...
python -m pip install --upgrade pip > nul
if %errorlevel% neq 0 (
    echo Erreur lors de la mise à jour de pip.
    exit /b 1
)

python -m pip install -r requirements.txt > nul
if %errorlevel% neq 0 (
    echo Erreur lors de l'installation des dépendances.
    exit /b 1
)

rem Vérification des cookies
echo Vérification des cookies...
set "tampon="
for /f %%i in ('minetcookies tiktok') do set "tampon=%%i"

if not defined tampon (
    echo Vous devez vous connecter à TikTok pour pouvoir utiliser ce script.
    exit /b 1
)

echo Vous pouvez maintenant lancer le script principal (main.cmd)
