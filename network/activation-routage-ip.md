# Activation du routage IP

Par défaut, les fonctions de routage IP entre interfaces réseau du système sont désactivées.


##### Activation de l'IP Forwarding #####

Il suffit d'exécuter la commande suivante :

```shell_session
$ echo 1 > /proc/sys/net/ipv4/ip_forward
```

On peut le vérifier avec la commande (Qui doit renvoyer True si l'ip forwarding est activé) :

```shell_session
$ sysctl net.ipv4.ip_forward
```