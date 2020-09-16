# Exporter un dossier depuis un référentiel dans un nouveau repository

Nous aurons la structure suivante :

```
.
├── cloneA
|   └── complet-repository
|   |   ├── folder1
|   |   ├── folder2
|   |   ├── lab
|   |   └── README.md
|   └── folderA
├── cloneB
    └── new-repository
```

Je veux exporter mon dossier **lab** depuis mon référentiel **complet-repository** avec l'historique dans mon nouveau repository nommé **new-repository**.

Je commence par créer la structure et cloner **complet-repository**
```bash
$ mkdir cloneA && \
  cd cloneA && \
  git clone --branch master --origin origin -v https://github.com/zami3l/complet-repository.git && \
  cd complet-repository
```

Pour éviter les erreurs, on supprime l'origin du repository **(Il ne faut surtout pas push ce repértoire)**
```
$ git remote rm origin
```

On va maintenant extraire le dossier **lab** en exportant seulement l'historique lié à celui-ci.
```bash
$ git filter-branch --subdirectory-filter lab -- --all
```

On nettoie les données inutiles :
```bash
$ git reset --hard && \
  git gc --aggressive && \
  git prune && \
  git clean -fd
```

On déplace les fichiers vers un nouveau dossier et on commit :
```bash
$ mkdir ../folderA && \
  mv {.,}* ../folderA && \
  cd ../folderA && \
  git add . && \
  git commit -m "init(lab): preparation-merge"
```

Maintenant, on crée la deuxième structure et on clone **new-repository**
```bash
$ mkdir cloneB && \
  cd cloneB && \
  git clone https://github.com/zami3l/new-repository.git && \
  cd new-repository
```

On ajoute une connexion distante avec l'ancien repository et on pull les données avec l'historique dans notre nouveau repository :
```bash
$ git remote add cloneA ~/cloneA/folderA && \
  git pull cloneA master --allow-unrelated-histories
```

Il ne nous reste plus qu'à supprimer la connexion distante puis push les modifications :
```bash
$ git remote rm cloneA && \
  git push
``` 

Notre nouveau repository est maintenant prêt à être utilisé. :)