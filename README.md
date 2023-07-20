# AutoMinet

## Description
Ce script permet de faire la chaîne de traitement suivante :
- Installer les dépendances nécessaires
- Vérifier les cookies
- Lancer le script minet
- Télécharger les vidéos depuis le fichier de sortie de minet.
- Découper les vidéos en images


## Première utilisation
Au premier lancement, veuillez lancer le script `install.sh` pour installer les dépendances nécessaires au bon fonctionnement du script.

Par la suite, vous pouvez lancer le script `main.sh` pour lancer le script principal.

## Utilisation
Le script `main.sh` prend les mêmes arguments que minet, à savoir :

```bash
./main.sh tiktok search-videos [keyword] [options]
```

## Exemple
```bash
./main.sh tiktok search-videos test --limit 10
```
