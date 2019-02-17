---
title: Configurer son adresse IP
permalink: configuration-ip.html
sidebar: generic
product: Generic
---

----
La configuration d'adresses IP peut se faire de plusieurs façon. Ici, nous allons utiliser [netctl](https://wiki.archlinux.org/index.php/netctl), installé par défaut sur Arch Linux.

##### Nom du périphérique réseau #####
Pour commencer, il faut connaitre le nom de son périphérique réseau.

```shell_session
$ ip link show
```

Résultat :
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether d8:50:e6:49:16:d5 brd ff:ff:ff:ff:ff:ff
3: vmnet1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 00:50:56:c0:00:01 brd ff:ff:ff:ff:ff:ff
4: vmnet2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 00:50:56:c0:00:02 brd ff:ff:ff:ff:ff:ff
5: vmnet8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 00:50:56:c0:00:08 brd ff:ff:ff:ff:ff:f
```
Dans mon cas, le nom de mon périphérique réseau est `eno1`. Il est aussi possible d'avoir `eth0`, `ens33`, etc..

Nous pouvons aussi utiliser :
```shell_session
$ ls /sys/class/net/
```
Résultat :
```
eno1  lo  vmnet1  vmnet2  vmnet8
```


##### Adresse IP static #####

Pour configurer une adresse IP static, netctl nous fournit un exemple de configuration.
On copie et utilise cet exemple pour notre propre configuration.

```shell_session
$ cp /etc/netctl/examples/ethernet-static /etc/netctl/lan-home
#Copie du fichier d'exemple et création du profil netctl "LAN-HOME"
```

Modification du profil en fonction de nos besoins :
```bash
Description = 'Ma configuration LAN'
Interface = eno1
Connection = ethernet
IP = static
Address = ('192.168.1.99/24')
Gateway = '192.168.1.1'
DNS = ('84.200.69.80' '84.200.70.40')
```
Lancement du profil avec netctl :
```shell_session
netctl start lan
```
Lancement du profil à chaque démarrage machine :
```shell_session
netctl enable lan
```


##### Adresse IP DHCP #####
Pour la configuration d'une adresse IP en DHCP, on utilise le même principe que pour une adresse IP static.
```shell_session
$ cp /etc/netctl/examples/ethernet-dhcp /etc/netctl/lan-auto
#Copie du fichier d'exemple et création du profil netctl "LAN-AUTO"
```
On configure le fichier lan-auto :
```bash
Description = 'Ma configuration auto'
Interface = eno1
Connection = ethernet
IP = dhcp
DNS = ('84.200.69.80' '84.200.70.40')
```

```shell_session
$ netctl start lan
#Lance le profil netctl
$ netctl enable lan
#Lancement du profil à chaque démarrage machine
```
