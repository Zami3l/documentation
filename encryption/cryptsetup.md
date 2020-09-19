Cryptsetup - Commandes basiques
===

## Création d'une partition chiffrée
```bash
$ cryptsetup --verbose luksFormat --verify-passphrase /dev/sdX1
```

## Déverrouiller la partition chiffrée
```bash
$ cryptsetup -v luksOpen /dev/sdX1 volumeEncrypted 
```

## Formatage du device mapper de la partition chiffrée
```bash
$ mkfs.ext4 /dev/mapper/volumeEncrypted
```

## Créer et Monter le device mapper de la partition chiffrée
```bash
$ mkdir /mnt/volumeEncrypted && mount /dev/mapper/volumeEncrypted /mnt/volumeEncrypted
```

## Démonter le device mapper de la partition chiffrée
```bash
$ umount /mnt/volumeEncrypted
```

## Verrouiller la partition chiffrée
```bash
$ cryptsetup -v luksClose volumeEncrypted 
```

## Bonus :

### Récupérer l'UUID des partitions
```bash
$ lsblk -f
```

### Créer des alias de déverrouillage et de verrouillage
```bash
# Déverrouillage
alias dopen='sudo cryptsetup -v luksOpen /dev/disk/by-uuid/00000000-1111-2222-3333-444444444444 volumeEncrypted && sudo mount --uuid aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee /mnt/private'

# Verrouillage
alias dclose='sudo umount /mnt/private ; sudo cryptsetup -v luksClose volumeEncrypted'
```

Représentation de l'exemple ci-dessus :
```
NAME                    FSTYPE          UUID
sdb
│
├─[...]
│
└─sdb3                  crypto_LUKS     00000000-1111-2222-3333-444444444444              
  └─volumeEncrypted     ext4            aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee
```

Super utile quand on souhaite monter une partition chiffrée d'une clé USB.