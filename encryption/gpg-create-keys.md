Création de clés avec GPG
===

Le logiciel [PGP](https://fr.wikipedia.org/wiki/Pretty_Good_Privacy) est un logiciel de chiffrement cryptographique.  

[PGP](https://fr.wikipedia.org/wiki/Pretty_Good_Privacy) se propose de garantir la confidentialité et l'authentification pour la communication des données. Il est souvent utilisé pour la signature de données, le chiffrement et le déchiffrement des textes, des courriels, fichiers, répertoires et partitions de disque entier pour accroître la sécurité des communications par courriel.

Dans notre cas, nous allons créer un trousseau de clés de façon à obtenir ceci :

```
$ gpg --list-secret-keys
/home/zami3l/.gnupg/pubring.kbx
-------------------------------
sec#   rsa4096/0x1111111111111111 2021-01-06 [C]
 Empreinte de la clef = 0000 1111 2222 3333 4444  5555 6666 7777 8888 9999
uid                  [  ultime ] Zami3l <xx@xx.dev>
ssb   rsa4096/0x2222222222222222 2048-01-06 [S] [expire : 2050-01-06]
ssb   rsa4096/0x3333333333333333 2048-01-06 [E] [expire : 2050-01-06]
ssb   rsa4096/0x4444444444444444 2048-01-06 [A] [expire : 2050-01-06]
```

La première clé **sec** (0x1111111111111111) correspond à notre clé privée permettant de **certifier**.  
La deuxième clé **ssb** (0x2222222222222222) permet de **signer**.  
La troisième clé **ssb** (0x3333333333333333) permet de **chiffrer**.  
La dernière clé **ss** (0x3333333333333333) permet de s'**authentifier**.

## 1. Création de la clé primaire

Pour réaliser ces différentes clés il faut tout d'abord créer la clé primaire via :

```
$ gpg --homedir .gnupg --expert --full-gen-key
```

Notre clé sera de type **(8) RSA (indiquez vous-même les capacités)**
Pour que la première clé ne soit que pour la certification, il faut ensuite enchainer la combinaison suivante :
1. (S) Inverser la capacité de signature
2. (C) Inverser la capacité de chiffrement
3. (Q) Terminé

Par mesure de précaution, on choisira une clé de type **4096** bits.

Pour la clé primaire, on laissera la valeur **0** pour éviter l'expiration.

On choisit pour terminer une identité incluant le **Nom** et l'**adresse email** associé à la clé.

Une fois créée, on peut vérifier notre clé primaire à l'aide de :

```
$ gpg --list-secret-keys
/home/zami3l/.gnupg/pubring.kbx
-------------------------------
sec#   rsa4096/0x1111111111111111 2021-01-06 [C]
 Empreinte de la clef = 0000 1111 2222 3333 4444  5555 6666 7777 8888 9999
uid                  [  ultime ] Zami3l <xx@xx.dev>
```

## 2. Ajout d'une sous-clé pour la signature

On effectue ensuite une modification de notre clé primaire pour lui ajouter une sous-clé pour **signer**.

```
$ gpg --homedir .gnupg --expert --edit-key null@zamiel.dev
```

A partir de notre shell gpg, on exécute la commande **addkey** puis on choisit le type **(4) RSA (signature seule)**.

On définit ensuite la taille sur 4096 bits et une date d'expiration de 2 ans.

Pour terminer, on exécute la commande **save** pour sauvegarder et quitter.

## 3. Ajout d'une sous-clé pour le chiffrement

On réitère les mêmes commandes que pour la sous-clé de signature à la différence qu'on utilisera une clé de type **(6) RSA (chiffrement seul)**.

## 4. Ajout d'une sous-clé pour l'authentification

On réitère les mêmes commandes que pour la sous-clé de signature/chiffrement cependant on choisira une clé de type **(8) RSA (indiquez vous-même les capacités)**.

Pour obtenir une sous-clé que pour l'authentification il faut exécuter les commandes suivantes :
1. (S) Inverser la capacité de signature
2. (C) Inverser la capacité de chiffrement
3. (A) Inverser la capacité d'authentification
4. (Q) Terminé

