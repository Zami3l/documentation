Mount une image ISO avec un offset
===

Avec l'outil [fuseiso](https://wiki.archlinux.org/index.php/FuseISO), nous pouvons monter une image ISO (.iso, .nrg, .bin, .mdf and .img) simplement avec la commande 

```bash
$ fuseiso image directory
```

ou avec l'outil mount :

```bash
$ mount -o loop image directory
```

Cependant, dans certains cas nous devons paramétrer un offset, soit car l'image dispose de plusieurs partitions, soit car celui-ci ne commence pas par l'octet 512.

On obtient donc ce type d'erreurs :

Sous fuseiso :
```
init: wrong standard identifier in volume descriptor 0, skipping..
init: wrong standard identifier in volume descriptor 1, skipping..
init: wrong standard identifier in volume descriptor 2, skipping..
init: wrong standard identifier in volume descriptor 3, skipping..
init: wrong standard identifier in volume descriptor 4, skipping..
init: wrong standard identifier in volume descriptor 5, skipping..
init: wrong standard identifier in volume descriptor 6, skipping..
init: wrong standard identifier in volume descriptor 7, skipping..
init: wrong standard identifier in volume descriptor 8, skipping..
init: wrong standard identifier in volume descriptor 9, skipping..
init: wrong standard identifier in volume descriptor 10, skipping..
init: wrong standard identifier in volume descriptor 11, skipping..
init: wrong standard identifier in volume descriptor 12, skipping..
init: wrong standard identifier in volume descriptor 13, skipping..
init: wrong standard identifier in volume descriptor 14, skipping..
init: wrong standard identifier in volume descriptor 15, skipping..
init: wrong standard identifier in volume descriptor 16, skipping..
init: wrong standard identifier in volume descriptor 17, exiting..
```

Avec mount : 
```
mount: mauvais type de système de fichiers, option erronée, superbloc erroné sur /dev/loop0, page de code ou programme auxiliaire manquant, ou autre erreur.
```

Il faut donc définir le début du secteur dans notre commande.  
Exemple ici, le fichier USB.img commence par l'offset **1048576** (2048 x 512)
```
$ file USB.img
downloads/USB.img: DOS/MBR boot sector; partition 1 : ID=0x83, start-CHS (0x4,4,1), end-CHS (0x191,144,2), startsector 2048, 202752 sectors
```

```
$ fdisk -l USB.img
Disque USB.img : 100 MiB, 104857600 octets, 204800 secteurs
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets
Type d'étiquette de disque : dos
Identifiant de disque : 0x3d9b4ec8

Périphérique Amorçage Début    Fin Secteurs Taille Id Type
USB.img1               2048 204799   202752    99M 83 Linux
```

Il faut donc monter l'image ISO avec :
```
$ mount -o loop,offset=1048576 USB.img directory/
```