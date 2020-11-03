Effacer les signatures de système de fichiers d'un HDD
===

Lors d'une mise en place d'un raid par exemple, il est possible que vous soyez obliger d'effacer les signatures du HDD pour qu'il soit visible par le système.

Il suffit d'utiliser l'outil [wipefs](https://man.developpez.com/man8/wipefs/).

Pour effacer toutes les signatures on utilisera l'option **-a**

```bash
$ wipefs -a /dev/sda
/dev/sda: 2 bytes were erased at offset 0x000001fe (dos): 55 aa
/dev/sda: calling ioctl to re-read partition table: Succès
```