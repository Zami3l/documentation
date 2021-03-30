# Configuration clamav avec samba

Samba intègre un module `vfs_virusfilter` pour permettre l'analyse et le filtrage des fichiers via l'antivirus Clamav.

Exemple de configuration pour `/etc/samba/smb.conf` 

```shell
# ClamAV
vfs objects = virusfilter
        # Type anti-virus
        virusfilter:scanner = clamav
        # Path Socket
        virusfilter:socket path = /run/clamd.scan/clamd.sock
        # Scanner les fichiers à la fermeture
        virusfilter:scan on close = yes
        # Aucun préfix
        virusfilter:quarantine prefix =
        virusfilter:rename prefix =
        # Type d'action si fichier infecté (Déplacer en quarantaine)
        virusfilter:infected file action = quarantine
        # Path quarantaine
        virusfilter:quarantine directory = /quarantaine
```
