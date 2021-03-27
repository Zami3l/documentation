# Installation Clamav

> Clamav est un ensemble d'outils, un moteur, Open Source, développé en langage C, à destination des systèmes Unix/Linux, pour détecter et neutraliser les Trojans, virus, malwares et autres malveillances.

## Installation

#### Archlinux

```zsh
$ pacman -S clamav
```

#### RedHat

```zsh
$ dnf install clamav clamav-update
```

## Installation ClamTK (Interface de gestion graphique)

#### Archlinux

```zsh
$ pacman -S clamtk
```

#### RedHat

```zsh
$ dnf install clamtk
```

## Configuration

#### Ajout proxy

**Archlinux** `/etc/clamav/freshclam.conf`  
**Redhat** `/etc/freshclam.conf`

```zsh
HTTPProxyServer http://proxy.zami3l.com
HTTPProxyPort 9999
```

#### Mise à jour automatique base de données

**Archlinux** `/etc/clamav/freshclam.conf`  
**Redhat** `/etc/freshclam.conf`

```zsh
# Nombre de vérifications sur une période de 24 heures
# Ici, on paramètre une vérification toutes les 12h
Checks 2
# Redémarrage du service clamav après la mise à jour
# Archlinux
NotifyClamd /etc/clamav/clamd.conf
# Redhat
NotifyClamd /etc/clamd.d/scan.conf
```

## Services

#### Freshclam

Service pour la mise à jour automatique de la base de données Clamav

```zsh
$ systemctl start freshclam
$ systemctl enable freshclam
```
