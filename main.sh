# echo "$@"
echo "Installation des dépendances..."
python3 -m pip install --upgrade pip > /dev/null || exit_on_error
python3 -m pip install -r requirements.txt > /dev/null || exit_on_error

echo "Vérification des cookies..."
OUTPUT="$(python3 minetcookies.py "$@")" || exit_on_error
# echo "$OUTPUT"

echo "Récupération des données..."
minet "$@" -o temp.csv
# echo "$(<temp.csv)"

if [ "$1" = "tiktok" ]; then
    echo "Récolte des vidéos..."
    python3 tksel.py temp.csv "$3" || exit_on_error  # --no-headless
    cp temp.csv "$OUTPUT"/meta.csv || exit_on_error
    pellipop --input "$OUTPUT" --output "$OUTPUT"-pellipop --frequency 1 --remove_duplicates || exit_on_error
else
  echo "$(<temp.csv)" || exit_on_error
fi

rm temp.csv


