# Configuration samba

Samba est une implémentation du protocole SMB/CIFS, il facilite le partage entre les systèmes Linux/Unix et Windows.  
Dans cet exemple, nous allons mettre en place une configuration de partage simple et rapide pour effectuer quelques tests.

## Installation samba

```zsh
$ pacman -S samba
```

## Ajout configuration

Emplacement : /etc/samba/smb.conf

```zsh
[global]
    
    workgroup = WORKGROUP
    netbios name = centos
    security = user

[NAME SHARE]

    comment = Share folder
    path = /data/smb
    browsable = yes
    writable = yes
    guest ok = yes
    read only = no
```

## Ajout utilisateur

```zsh
$ smbpasswd -a [USER]
```

## Redémarrage des services

```zsh
$ systemctl restart smb nmb
```

## Test

```zsh
$ smbclient -L //[SRV]/[PARTAGE] -U [USER]
```
