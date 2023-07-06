echo "$@"

python3 -m pip install -r requirements.txt > /dev/null

OUTPUT="$(python3 minetcookies.py "$@")"

minet "$@" > temp.csv

if [ "$1" = "tiktok" ]; then
    echo "Récolte des vidéos..."
    python3 tksel.py temp.csv "$3"
    cp temp.csv "$OUTPUT"/meta.csv
else
  echo "$(<temp.csv)"
fi

rm temp.csv


