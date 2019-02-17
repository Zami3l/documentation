---
title: Installation des dépôts AUR
permalink: installation-depot-aur.html
sidebar: generic
product: Linux
---


La distribution Arch Linux dispose d'un dépôt communautaire auquel chaque utilisateur d'Arch peut participer.
Ce dépôt appelé [AUR](https://wiki.archlinux.org/index.php/Arch_User_Repository) (_Arch User Repository_) contient des PKGBUILD (_C'est un fichier [Bash](https://wiki.archlinux.org/index.php/Bash) qui permet de construire un paquet_). Il passe forcément par [Git](https://wiki.archlinux.org/index.php/git) mais ce ne sont pas des dépôts "classique", "officiel" d'Arch, et leur contenu n'est pas systématiquement vérifié ni maintenu activement.

Ce tutoriel abordera les deux manières d'installer un paquet d'AUR.


##### Installation automatique #####
Pour rechercher, installer, gérer les conflits et les dépendances automatiquement, il est impératif de disposer de [Yaourt](https://wiki.archlinux.fr/yaourt) et d'Arch Linux base-devel.
L'utilisation de Yaourt permettra de rechercher et d'installer dans un premier temps les paquets dans les dépôts officiels. Si celui-ci n'est pas présent, il basculera sur les dépôts non officiels sur AUR.

Pour lancer la recherche et l'installation d'un paquet, il suffit de lancer la commande suivante :

```shell_session
$ Yaourt -S nomdupaquet
#Recherche nomdupaquet dans les dépots, si celui est présent, il lancera l'installation
```

##### Installation manuelle #####
Pour installer manuellement un paquet, nous avons seulement besoin d'Arch Linux base-devel.
Dans un premier temps, nous devons trouver et cloner à l'aide de Git notre paquet sur notre machine. Puis construire notre paquet avec [Makepkg](https://wiki.archlinux.org/index.php/makepkg) et terminer par l'installer avec [Pacman](https://wiki.archlinux.org/index.php/Pacman).

Nous allons installer [Visual Studio Code](https://aur.archlinux.org/packages/visual-studio-code-bin/) en le recherchant sur [AUR](https://aur.archlinux.org/).

```shell_session
$ git clone https://aur.archlinux.org/visual-studio-code-bin.git
#Clone le répertoire visual-studio-code-bin dans le répertoire courant

$ cd visual-studio-code-bin/
$ makepkg -s
#Construit le paquet dans le répertoire cloné

$ pacman -U visual-studio-code-bin-1.19.2-1-x86_64.pkg.tar.xz
#Installe le paquet crée
```
