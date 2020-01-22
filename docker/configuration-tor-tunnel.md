# Configuration d'un Tunnel TOR avec Docker

## Lien vers le projet
[Github Zamiel : Tunnel TOR avec Docker](https://github.com/Zami3l/Docker/tree/master/tor)

## Présentation

Ce docker permet de faire transiter vos flux dans le réseau TOR.

## Exemple

Nous allons utiliser notre tunnel TOR pour naviguer sur Internet via Firefox.

Pour commencer, on build et run notre docker avec docker-compose.
Pour ce faire, on lance la commande suivante à la racine du projet :   

```
docker-compose up -d
```

On paramètre ensuite notre firefox pour qu'il utilise notre tunnel :

![Paramètrage Network Firefox](../../img/docker_tor/firefox_param_network.png)

![Paramètrage Proxy Firefox](../../img/docker_tor/firefox_param_proxy.png)

Et on vérifie si tout fonctionne avec le site [Check TOR](https://check.torproject.org/)

![Vérification TOR](../../img/docker_tor/firefox_check_tor.png)