echo "Création de l'envirronement virtuel..."
python3 -m venv venv || exit 1
source venv/bin/activate || exit 1
#which python

echo "Installation des dépendances..."
python3 -m pip install --upgrade pip > /dev/null || exit 1
python3 -m pip install -r requirements.txt &> /dev/null || exit 1

echo "Vérification des cookies..."
tampon="$(minetcookies tiktok)" || exit 1

if [ "$(echo "$tampon" | grep "sessionid=")" = "" ]; then
    echo "Vous devez vous connecter à TikTok pour pouvoir utiliser ce script"
    exit 1
fi

echo "Vous pouvez maintenant lancer le script principal (main.sh)"
