# Cheatsheet Clamav

## Mettre à jour la base de données
```zsh
$ freshclam
```

## Scan récursif d'un répertoire

`-i` permet d'afficher seulement les malwares trouvés  
`-r` scan récursif

```zsh
$ clamscan -r -i [FOLDER]
```

## Scripts

##### check_database_clamav.sh

Ce script permet de vérifier automatiquement via crontab la mise à jour de la base de données.  
Un compte-rendu est automatiquement envoyé par email.

##### clamscan_daily.sh

Ce script permet d'effectuer un scan automatique via crontab du système.
Un compte-rendu du scan est également envoyé par email.
