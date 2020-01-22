---
title: Fonctionnement de Makepkg
permalink: fonctionnement-makepkg.html
sidebar: generic
product: Linux
---

Makepkg permet de construire et compiler des paquets se basant sur un PKGBUILD.

Son fonctionnement se base sur plusieurs étapes :
1. Récupération des sources, extraction et stockage dans le dossier **src**
2. Lancement de la fonction **prepare()** pour patcher si besoin les sources
3. Lancement de la fonction **build()** pour compiler les sources
4. Lancement de la fonction **package()** pour installer le programme dans le dossier **pkg**
5. Nettoyage automatique du dossier **pkg** (Suppression des symboles binaires, compression des manuels, etc..)
6. Compression du dossier **pkg** dans une archive **.pkg.taz.xz** qui servira d'installation pour pacman

L'architecture ci-dessous représente le dossier après compilation :

```
FOLDER/  
        PKGBUILD
        src/
            <Les sources extraites>
        pkg/
            <Reflet de ce qui sera installé dans le système>
        programme.pkg.taz.xz
```
