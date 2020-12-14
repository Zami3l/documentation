John The Ripper
===

## Extraire et déchiffrer /etc/shadow
Nous allons voir comment déchiffrer le mot de passe de l'utilisateur stocké dans /etc/shadow via john.

Elle se décompense en deux étapes :
- La première consiste à combiner les fichiers **/etc/passwd** et **/etc/shadow**
- La deuxième est le déchiffrement

### 1 - Combinaison

```bash
# /etc/passwd
buddy:x:0:0:buddy:/home/buddy:/bin/bash

# /etc/shadow
buddy:$6$3GvJsNPG$ZrSFprHS13divBhlaKg1rYrYLJ7m1xsYRKxlLh0A1sUc/6SUd7UvekBOtSnSyBwk3vCDqBhrgxQpkdsNN6aYP1:18233:0:99999:7:::
```

Via l'outil **unshadow**, on effectue la combinaison :
```bash
$ unshadow /etc/passwd /etc/shadow > unshadowed
```

```bash
$ cat unshadowed
buddy:$6$3GvJsNPG$ZrSFprHS13divBhlaKg1rYrYLJ7m1xsYRKxlLh0A1sUc/6SUd7UvekBOtSnSyBwk3vCDqBhrgxQpkdsNN6aYP1:0:0:buddy:/home/buddy:/bin/bash
```
### 2 - Déchiffrement
Il ne nous reste plus qu'à lancer l'attaque par dictionnaire avec john :
```bash
$ john unshadowed --wordlist=/usr/share/wordlists/rockyou.txt
```

```bash
$ john --show unshadowed
buddy:rainbow:0:0:buddy:/home/buddy:/bin/bash
```

Le mot de passe de l'utilisateur **buddy** est : **rainbow**