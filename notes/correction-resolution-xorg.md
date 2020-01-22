# Ajout d'une résolution sur Xorg

[Xorg](https://wiki.archlinux.org/index.php/xorg) permet de prendre en charge l'interface graphique sous GNU/Linux. Par exemple, [i3wm](https://wiki.archlinux.org/index.php/i3) (Gestionnaire de fenêtre) est par défaut lié à Xorg.
Si vous utilisez votre système d'exploitation sur une machine virtuelle, il est possible que celui ci ne détecte pas la bonne résolution de votre écran.

---

Dans ce tutoriel, nous allons voir comment ajouter une résolution (1920x1080) à Xorg.

```shell_session
$ cvt 1920 1080 60
#Génère un code pour la résolution

$ xrandr
#Permet de savoir la sortie utilisée pour l'écran
#Pour une sortie virtualisée, c'est probablement "Virtual1")

$ xrandr --newmode « 1920x1080_60.00 » 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
#Ajout de la résolution dans xrandr via le code généré par la commande "cvt 1920 1080 60"

$ xrandr -addmode Virtual1 1920x1080_60.00
#Ajout du nouveau mode à Xorg

$ xrandr -s 1920x1080
#Activation du mode ajouté
```
