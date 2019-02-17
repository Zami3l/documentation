---
title: Installation de TOR et de Proxychains
permalink: install-tor-proxychains.html
tag-name: install-tor-proxcychains
tag-display: TOR et Proxychains
---

[Tor](https://fr.wikipedia.org/wiki/Tor_(r%C3%A9seau)) désigne un réseau informatique décentralisé permettant l'anonymat des clients, reposant sur des serveurs spécifiques appelés « nœuds ».

[Proxychains](https://github.com/rofl0r/proxychains-ng) est un outil permettant de forcer les connexions TCP d'une application a utiliser le réseau TOR.

### Installation de Tor et Proxychains ###
Pour commencer, on installe Tor et Proxychains :

```shell_session
$ apt-get install tor proxychains
```

### Configuration et Démarrage de Tor ###
On indique à Tor d'utiliser le port d'écoute 9050 (Port par défaut).
Pour cela, on décommente la ligne "SOCKSPort 9050" du fichier /etc/tor/torrc et on démarre le service :

```shell_session
$ systemctl start tor
#On lance le service
$ systemctl status tor
#On vérifie que le service est activé
```

On peut également vérifier en utilisant la commande :

```shell_session
$ netstat -tulpn
```

Résultat :

```
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.1:9050          0.0.0.0:*               LISTEN      3040/tor
```

### Configuration et Démarrage de Proxychains ###

On configure maintenant Proxychains pour qu'il utilise le réseau TOR en modifiant le fichier de paramètres /etc/proxychains.conf :

```
# proxychains.conf  VER 3.1
#
#        HTTP, SOCKS4, SOCKS5 tunneling proxifier with DNS.
#

# The option below identifies how the ProxyList is treated.
# only one option should be uncommented at time,
# otherwise the last appearing option will be accepted
#
dynamic_chain
#
# Dynamic - Each connection will be done via chained proxies
# all proxies chained in the order as they appear in the list
# at least one proxy must be online to play in chain
# (dead proxies are skipped)
# otherwise EINTR is returned to the app
#
#strict_chain
#
# Strict - Each connection will be done via chained proxies
# all proxies chained in the order as they appear in the list
# all proxies must be online to play in chain
# otherwise EINTR is returned to the app
#
#random_chain
#
# Random - Each connection will be done via random proxy
# (or proxy chain, see  chain_len) from the list.
# this option is good to test your IDS :)

# Make sense only if random_chain
#chain_len = 2

# Quiet mode (no output from library)
quiet_mode

# Proxy DNS requests - no leak for DNS data
proxy_dns

# Some timeouts in milliseconds
tcp_read_time_out 15000
tcp_connect_time_out 8000

# ProxyList format
#       type  host  port [user pass]
#       (values separated by 'tab' or 'blank')
#
#
#        Examples:
#
#            	socks5	192.168.67.78	1080	lamer	secret
#		http	192.168.89.3	8080	justu	hidden
#	 	socks4	192.168.1.49	1080
#	        http	192.168.39.93	8080
#		
#
#       proxy types: http, socks4, socks5
#        ( auth types supported: "basic"-http  "user/pass"-socks )
#
[ProxyList]
# add proxy here ...
# meanwile
# defaults set to "tor"
socks5 127.0.0.1 9050
```
**dynamic_chain** : Permet d'ignorer les proxies down

**quiet_mode** : Empêche la sortie

**proxy_dns** : Résolution des DNS

**tcp_read_time_out, tcp_connect_time_out** : socker timeouts

**socks5 127.0.0.1 9050** : Redirection vers TOR

### Utilisation de Proxychains ###
Rediriger les connexions TCP des applications sur le réseau Tor de cette façon :

```shell_session
$ proxychains firefox
```
On peut vérifier si cela fonctionne à l'aide de ce [site](https://check.torproject.org/)
