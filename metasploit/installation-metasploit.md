# Installation de Metasploit

[Metasploit](https://wiki.archlinux.org/index.php/Metasploit_Framework), est un projet (open source, sous Licence BSD modifiée1) en relation avec la sécurité des systèmes informatiques. Son but est de fournir des informations sur les vulnérabilités de systèmes informatiques, d'aider à la pénétration et au développement de signatures pour les systèmes de détection d'intrusion (IDS, Intrusion Detection System).   


#### Préparation postgresql ####

Metasploit a besoin d'une base de donnée de type [PostgreSQL](https://wiki.archlinux.org/index.php/PostgreSQL) pour pouvoir fonctionner. 

On commence par installer PostgreSQL
```bash
$ pacman -S postgresql
```
On se connecte avec le compte postgres pour configurer notre base
```bash
$ sudo -iu postgres
```

On crée notre cluster
```bash
$ initdb --locale fr_FR.UTF-8 -D /var/lib/postgres/data
```

On peut maintenant démarrer le service PostgreSQL ***dans un autre terminal***
```bash
$ systemctl start postgresql.service
```

Toujours avec l'utilisateur ***postgres*** on crée un utilisateur ***msf*** pour metasploit
```bash
$ createuser --interactive
Saisir le nom du rôle à ajouter : msf
Le nouveau rôle est-il super-utilisateur ? (o/n) n
```

Toujours avec l'utilisateur ***postgres*** on crée notre base de donnée pour stocker les données de Metasploit
```bash
$ createdb msf -O msf
# -O Permet d'associer à l'utilisateur msf les droits de lecture/écriture sur la base msf
```

#### Installation et configuration de Metasploit ####

On commence par l'installation de Metasploit
```bash
$ pacman -S metasploit
```

On lance la console de Metasploit pour connecter msf à PostgreSQL
```bash
$ msfconsole
```

Normalement, Metasploit n'est pas connecté à une base de donnée par défaut
```bash
msf5 > db_status
[*] postgresql selected, no connection
```

On va donc connecter Metasploit à notre base de donnée qu'on vient de créer
```bash
msf5 > db_connect msf@msf
Connected to Postgres data service: /msf
```

On peut également revérifier avec 
```bash
msf5 > db_status 
[*] Connected to msf. Connection type: postgresql. Connection name: fsociety.
```

Comme dirait BlackArch.. Maintenant :  
**HACK THE PLANET! D00R THE PLANET!**