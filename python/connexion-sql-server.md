# Connexion à une base SQL Server avec Python

Pour se connecter à une base SQL Server, nous allons utiliser la bibliothèque pyodbc.

Pour commencer, on installe le moteur ODBC puis le driver FreeTDS :

```shell_session
$ pacman -S unixodbc freetds
```
Puis pyodbc avec pip :

```shell_session
$ pip install --user pyodbc
```

On paramètre ensuite le moteur ODBC en lui indiquant :
- Les drivers à utiliser dans le fichier /etc/odbcinst.ini
```bash
[FreeTDS]
Driver          = /usr/lib/libtdsodbc.so
UsageCount      = 1
```

- Les connexions aux serveurs dans /etc/odbc.ini
```bash
[sqlserver]
Driver = FreeTDS
Server = <IP Serveur>
Port = <PORT Serveur>
TDS_Version = 7.3
```

Nous pouvons maintenant requêter notre BDD avec python :
```python
import pyodbc

BDD = pyodbc.connect(
    'DRIVER=FreeTDS;'
    'SERVER=<IP Serveur>;'
    'PORT=<PORT Serveur>;'
    'DATABASE=<Nom base de donnée>;'
    'UID=<User>;'
    'PWD=<Password>;'
    'CHARSET=UTF-8;'
    'TDS_Version=7.3')

cursor = BDD.cursor()

cursor.execute("SELECT * FROM <Nom base de donnée>")

for ligne in cursor:
    print(ligne)
```