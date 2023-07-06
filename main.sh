# echo "$@"
echo "Installation des dépendances..."
python3 -m pip install --upgrade pip > /dev/null
python3 -m pip install -r requirements.txt > /dev/null

echo "Vérification des cookies..."
OUTPUT="$(python3 minetcookies.py "$@")"
# echo "$OUTPUT"

echo "Récupération des données..."
minet "$@" > temp.csv
# echo "$(<temp.csv)"

if [ "$1" = "tiktok" ]; then
    echo "Récolte des vidéos..."
    python3 tksel.py temp.csv "$3"  # --no-headless
    cp temp.csv "$OUTPUT"/meta.csv
else
  echo "$(<temp.csv)"
fi

rm temp.csv


