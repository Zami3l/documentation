Veracrypt - Commandes basiques
===

## Création interactive d'une partition chiffrée
```bash
$ veracrypt -t -c
```

## Monter la partition chiffrée
```bash
$ veracrypt ~/encrypt /mnt/encrypt

#Avec keyfile
$ veracrypt -k keyfile ~/encrypt /mnt/encrypt
```

## Démonter la partition chiffrée
```bash
$ veracrypt -d encrypt

#Démonter tous les volumes
$ veracrypt -d
```