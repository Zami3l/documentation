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