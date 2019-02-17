---
title: Convention des commits
permalink: convention-commits.html
tag-name: convention-commits
tag-display: Convention des commits
---

----

Vous trouverez ci-dessous la convention de nommage de mes commits.


```
<type>(<portée>): <sujet>

<description>
```


#### **Le type**

* **```build```** : Changement qui affectent le système de build ou des dépendances externes (upgrade jekyll, ...)
* **```feat```** : Ajout d'une nouvelle fonctionnalité
* **```fix```** : Correction d'un bug
* **```perf```** : Amélioration des performances
* **```refactor```** : Modification qui n’apporte ni nouvelle fonctionalité ni d’amélioration de performances
* **```style```** : Changement qui n’apporte aucune alteration fonctionnelle ou sémantique (indentation, mise en forme, ajout d’espace, renommante d’une variable…)
* **```compilation```** : Modification suite à une compilation (C, C++, ...)
* **```init```** : Ajout des premiers fichiers suite à une création de projets
* **```revert```** : Annulation d'un précédent commit
* **```docs```** : Modification de la documentation, ajout d'un nouvel article

#### **La portée (scope)**

Partie du projet affectée.  
Par exemple, pour des fichiers de configurations Linux, je préciserai si c'est le **bashrc**, **network**, **scripts**, ...

#### **Le sujet**

Description très succinte des changements.
Le style descriptif est utilisé avec des noms, sans majuscule et sans point.  
Par exemple : **supression**, **ajout**, **modification**, **renommage**, **changement**, ...

#### **La description**

On décrit en détail les changements.