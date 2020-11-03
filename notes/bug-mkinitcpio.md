Résolution des bugs liés à mkinitcpio
===

## Quelques exemples de problèmes liés à mkinitcpio

1. Freeze lors du chargement de initramfs (Après le boot loader)

2. ERROR: Failed to load preset: `/etc/mkinitcpio.d/linux.preset`

3. ERROR: file `/boot/vmlinuz` not found

## Il existe plusieurs solutions pour résoudre ces problèmes :

- Réinstallation et regénération du kernel

```bash
$ pacman -S linux
$ mkinitcpio -P linux
```

2. Si le problème persiste toujours il est possible que le fichier linux.preset soit corrompu.

```bash
$ rm /etc/mkinitcpio.d/linux.preset
$ pacman -S linux
$ mkinitcpio -P linux
```