# echo "$@"
echo "Installation des dépendances..."
python3 -m pip install --upgrade pip > /dev/null || exit
python3 -m pip install -r requirements.txt > /dev/null || exit

echo "Vérification des cookies..."
OUTPUT="$(minetcookies "$@")" || exit
# echo "$OUTPUT"

echo "Récupération des données..."
minet "$@" -o temp.csv || exit
# echo "$(<temp.csv)"

if [ "$1" = "tiktok" ]; then
    echo "Récolte des vidéos..."
    tksel temp.csv "$3" || exit  # --no-headless
    cp temp.csv "$OUTPUT"/meta.csv || exit
    pellipop --input "$OUTPUT" --output "$OUTPUT"-pellipop --frequency 1 --remove_duplicates || exit
else
  echo "$(<temp.csv)" || exit
fi

rm temp.csv


