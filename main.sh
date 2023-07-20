#echo "$@"
echo "Vérification des cookies..."
OUTPUT="$(minetcookies "$@")" || exit 1
# echo "$OUTPUT"

echo "Récupération des données..."
minet "$@" -o temp.csv || exit 1
# echo "$(<temp.csv)"

if [ "$1" = "tiktok" ]; then
    echo "Récolte des vidéos..."
    tksel temp.csv "$3" || exit 1  # --no-headless
    pellipop \
    --input "$OUTPUT" \
    --output "$OUTPUT"-pellipop \
    --frequency 1 \
    --remove_duplicates || exit 1
else
  echo "$(<temp.csv)" || exit 1
fi

rm temp.csv

echo "Fin du script"
