---
titre: Les bases Atom
---
### Les Bases Atom

Maintenant qu'Atom est installé sur votre système, c'est partis, configuré-le et familiarisez vous avec l'éditeur.

Quand vous lancez Atom pour la première fois, vous devrez avoir un écran qui ressemble à ça:

![Atom's welcome screen](../../images/first-launch.png)

Ceci est l'écran d'accueil d'Atom qui vous donne un bon point de départ pour savoir commennt débuter avec l'éditeur.

#### Terminologie

Vous pouvez trouver les définitions de chaques termes que nous utilisons tout au long du manuel et du glossaire.
(/resources/sections/glossary/).

#### Palette de Commande

Sur cet écran d'accueil, nous allons introduire la partie qui est probablement la plus importante des commandes d'Atom, la palette de commande. Si vous appuyez <kbd class="platform-mac">Cmd+Shift+P</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+P</kbd> la palette de commande va apparaitre.

{{#note}}

Tout au long de la documentation, nous utiliserons des raccourcis clavier comme <kbd class="platform-mac">Cmd+Shift+P</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+P</kbd> pour montrer comment utiliser une commande. Il y a déja des raccourcis clavier par défauts pour votre système d'exploitation qui ont été détécté au lancement.

Si vous voulez voir un système différent de celui que nous avons détécté, vous pouvez en choisir un different en utilisant le sélécteur en haut de la page:

![Platform Selector](../../images/platform-selector.png "Platform Selector")

Si le système n'est pas présent, alors la page actuelle n'a aucun contenu spécifique au système.

Si vous avez personalisé vos raccourci Atom, vous pouvez toujours voir votre configuratoin dans la "Command Palette" ou l'onglet clavier dans les paramètres [Settings View](#settings-and-preferences).

{{/note}}

Ce menu de recherche peut accomplir n'importe quelle tâche possible sur Atom. Au lieu de cliquer sur tous les menus d'applications pour rechercher quelque chose, appuyez simplement sur <kbd class="platform-mac">Cmd+Shift+P</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+P</kbd> et rechercher votre commande.

![Command Palette](../../images/command-palette.png "Command Palette")

Non seulement vous pouvez voir et rechercher rapidement des milliers de commandes possibles, mais vous pouvez également voir s'il y a un raccourci clavier associé. C'est formidable parce que cela signifie que vous pouvez deviner votre façon de faire des choses intéressantes tout en apprenant les touches de raccourci pour le faire.

Pour le reste de la documentation, nous allons essayer d'être clair dans le texte que vous pouvez rechercher sur la palette de commande.

#### Paramètres et préférences

Atom a de nombreux paramètres que vous pouvez modifier dans l'écran des paramètres.

![Settings View](../../images/settings.png "Settings View")

Cela inclut des choses comme changer le thème, spécifier comment gérer les manipulations , les paramètres de police, la taille de l'onglet, la vitesse de défilement et bien plus encore. Vous pouvez également utiliser cet écran pour installer de nouveaux packages et thèmes, que nous aborderons dans les packages d'Atom [Atom Packages](/using-atom/sections/atom-packages).

Pour ouvrir l'écran des paramètres, vous pouvez:

* Utilisez <span class="platform-mac">*Atom > Preferences*</span><span class="platform-windows">*File > Settings*</span><span class="platform-linux">*Edit > Preferences*</span> dans la barre de menu
* Recherchez `settings-view:open` in the [Command Palette](#command-palette)
* Utilisez les raccourcis clavier <kbd class="platform-mac">Cmd+,</kbd><kbd class="platform-windows platform-linux">Ctrl+,</kbd> 

##### Changer le Thème

L'écran des paramètres vous permet également de modifier les thèmes pour Atom. Atom propose 4 thèmes d'interface utilisateur différents, des variantes foncées et claires du thème Atom et One, ainsi que 8 thèmes avec des syntaxes différentes. Vous pouvez modifier le thème actif ou installer de nouveaux thèmes en cliquant sur l'onglet Thèmes dans la barre latérale dans l'écran des Paramètres.

![Changing the theme from the Settings View](../../images/theme.png "Changing the theme from the Settings View")

Les thèmes de l'interface utilisateur contrôlent le style des éléments, tels que les onglets et l'arborescence, tandis que les thèmes de syntaxe contrôlent la mise en évidence de la syntaxe de texte que vous chargez dans l'éditeur. Pour modifier la syntaxe ou le thème de l'interface utilisateur, choisissez simplement quelque chose de différent dans la liste déroulante appropriée.

Il ya aussi des dizaines de thèmes sur https://atom.io que vous pouvez choisir si vous voulez quelque chose de différent. Nous aborderons la personnalisation d'un thème dans [Style Tweaks](/using-atom/sections/basic-customization) et la création de votre propre thème dans [Creating a Theme](/hacking-atom/sections/creating-a-theme).

##### Soft Wrap

Vous pouvez utiliser l'écran des paramètres pour spécifier vos préférences de tabulation et de contoure.

![Whitespace and wrapping preferences settings](../../images/settings-wrap.png)

Activer l'option "Soft Tabs" vous permettra d'insérer des espaces à la place des caractères de tabulation lorsque vous appuyer sur <kbd class="platform-all">Tab</kbd> et le paramètre "Tab Length" vous permmetra de spécifier le nombre d'espaces que vous souhaitez, ou combien d'espaces il faut pour représenter une tabulation si l'option "Soft Tabs" est désactivée.

L'option "Soft Wrap" coupera les lignes qui sont trop longues pour tenir dans votre fenêtre. Si celle-ci est désactivée, vous serez obligés de faire défiler votre fenêtre pour voir le reste. Si vous choissisez l'option "Soft Wrap At Preferred Line Length", les lignes seront coupées automatiquement au bout du 80ième caractère au lieu de la fin de l'écran. Cette valeur est bien sur modifiable.

Dans la personnalisation de base [Basic Customization](/using-atom/sections/basic-customization/) nous verrons comment définir différentes préférences de coupures pour différents types de fichiers (par exemple, si vous souhaitez couper les fichiers Markdown mais pas les autres).

#### Ouvrir, Modifier et Sauvegarder des fichiers

Maintenant que votre éditeur est à votre convenance, commençons l'ouverture et l'édition de fichiers. C'est pour ça que vous être sur Atom, non?

##### Ouvrir un fichier

Il y a plusieurs moyens d'ouvrir un fichier dans Atom. Vous pouvez le faire en sélectionnant Fichier > Ouvrir depuis la barre menue ou en appuyant sur <kbd class="platform-mac">Cmd+O</kbd><kbd class="platform-windows platform-linux">Ctrl+O</kbd> pour choisir un fichier de la boite de dialogue.

![Open file by dialog](../../images/open-file.png "Open file by dialog")

Cette méthode est utile pour ouvrir un fichier qui n'est pas contenu dans le projet sur lequel vous êtes actuelement en train de travailler, ou si vous commencez à partir d'une nouvelle fenêtre.

Un autre moyen d'ouvrir un fichier dans Atom est de passer par les lignes de commandes en utilisant les commandes `atom` <span class="platform-mac">. La barre de menu Atom possède une commande appelée "Install Shell Commands" qui installe les commandes `atom` et `apm` (/getting-started/sections/installing-atom/#installing-atom-on-mac).</span><span class="platform-windows platform-linux">Les commandes `atom` and `apm` sont installées automatiquement [installation process](/getting-started/sections/installing-atom/).</span>

On peut ouvrir un ou plusieurs fichiers en même temps grâce à la commande `atom`.

``` command-line
$ atom --help
> Atom Editor v1.8.0

> Usage: atom [options] [path ...]

> One or more paths to files or folders may be specified. If there is an
> existing Atom window that contains all of the given folders, the paths
> will be opened in that window. Otherwise, they will be opened in a new
> window.

> ...
```


Cette méthode est facile d'utilisation si vous êtes habitué à utiliser un terminal ou à travailler à partir d'un terminal. Lancer juste `atom [files]`et vous êtes prêt à écrire.

##### Editer et sauvegarder des fichiers

Editer un fichier est plutôt facile. Vous pouvez cliquer et scroller le contenu et écrire pour changer le contenu. Il n'y a pas de mode d'édition spécial ou de commandes particulières. Si vous voulez quelque chose d'un peu plus complexe, regardez donc les différents packages d'Atom [Atom package list](https://atom.io/packages). Il y en a beaucoup qui sont assez similaires aux styles assez populaires.
 
Pour sauvegarder un fichier, aller dans Fichier > Sauvegarder depuis le menu ou appuyer sur <kbd class="platform-mac">Cmd+S</kbd><kbd class="platform-windows platform-linux">Ctrl+S</kbd>. Si vous choissisez Fichier > Enregistrer-sous ou <kbd class="platform-mac">Cmd+Shift+S</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+S</kbd>, vous pouvez ainsi renommer votre fichier tout en le sauvegardant. Enfin, vous pouvez sauvegarder l'intégralité de vos fichiers ouverts en allant dans Fichier > Sauvegarder tout <span class="platform-mac">or press <kbd class="platform-mac">Alt+Cmd+S</kbd></span>.

#### Ouvrir des répertoires

Atom ne fonctionne pas seulement avec des fichiers uniques; Vous passerez probablement la plupart de votre temps à travailler sur des projets avec plusieurs fichiers. Pour ouvrir un répertoire, choisissez le menu <span class="platform-mac">*File > Open*</span><span class="platform-windows platform-linux">*File > Open Folder*</span> et sélectionnez un répertoire dans la boîte de dialogue. Vous pouvez également ajouter plus d'un répertoire à votre fenêtre Atom actuelle, en choisissant Fichier> Ajouter un dossier de projet dans la barre de menus ou en appuyant sur <kbd class="platform-mac">Cmd+Shift+O</kbd><kbd class="platform-windows platform-linux">Alt+Ctrl+O</kbd>.

Vous pouvez ouvrir autant de répertoires que vous voulez grâce à la ligne de commande `atom` en indiquant tous les chemins correspondants. Par exemple, vous pouvez exécuter la commande `atom ./hopes ./dreams` pour ouvrir à la fois les répertoires `hopes`et `dreams`en même temps.

Lorsque vous ouvrez Atom avec un ou plusieurs répertoires, une arborescence s'affiche automatiquement sur le côté de votre fenêtre.

![Tree View in an open project](../../images/project-view.png "Tree View in an open project")

L'arborescence vous permet d'explorer et de modifier la structure des fichiers et des répertoires de votre projet. Vous pouvez ouvrir, renommer, supprimer et créer de nouveaux fichiers à partir de cette vue.

Vous pouvez également le masquer et le montrer avec <kbd class="platform-mac">Cmd+\\</kbd><kbd class="platform-windows platform-linux">Ctrl+\\</kbd> ou la commande `tree-view:toggle` toggle à partir de la palette de commandes, et <kbd class="platform-mac">Ctrl+0</kbd><kbd class="platform-windows platform-linux">Alt+\\</kbd> le zoomera. Lorsque la vue arborescente est activée, vous pouvez appuyer sur <kbd class="platform-all">A</kbd>, <kbd class="platform-all">M</kbd>, or <kbd class="platform-all">Delete</kbd> pour ajouter, déplacer ou supprimer des fichiers et des dossiers. Vous pouvez également cliquer avec le bouton droit de la souris sur un fichier  <span class="platform-mac">Finder</span><span class="platform-windows">Windows Explorer</span><span class="platform-linux">your native filesystem</span> ou un dossier dans la vue Arborescence pour voir plusieurs des différentes options.
 
{{#note}}

**Packages d'Atom**

Comme plusieurs parties d'Atom, l'arborescence n'est pas directement intégrée à l'éditeur, mais est son propre package autonome livré avec Atom par défaut. Les packages regroupés sous Atom sont désignés sous le nom de packages Core. Ceux qui ne sont pas regroupés avec Atom sont désignés sous le nom de packages communautaires.

Vous pouvez trouver le code source de l'arborescence sur https://github.com/atom/tree-view.

C'est l'une des choses intéressantes au sujet d'Atom. Beaucoup de ses fonctionnalités de base sont en fait simplement des packages mis en œuvre de la même façon que vous mettre en œuvre toute autre fonctionnalité. Cela signifie que si vous n'aimez pas l'arborescence, vous pouvez écrire votre propre implémentation de cette fonctionnalité et la remplacer entièrement.

{{/note}}

##### Ouvrir un fichier dans un projet

Une fois que vous avez ouvert un projet dans Atom, vous pouvez facilement trouver et ouvrir tout fichier présent au sein du projet.

Si vous appuyer sur <kbd class="platform-mac">Cmd+T</kbd><kbd class="platform-windows platform-linux">Ctrl+T</kbd> or <kbd class="platform-mac">Cmd+P</kbd><kbd class="platform-windows platform-linux">Ctrl+P</kbd>, Fuzzy Finder apparaitra. Cela vous permettra d'effectuer une recherche rapide de n'importe quel fichier présent dans le projet.

![Opening files with the Fuzzy Finder](../../images/finder.png "Opening files with the Fuzzy Finder")

Vous pouvez également rechercher uniquement les fichiers ouverts (plutôt que tous les fichiers de votre projet) avec <kbd class="platform-mac">Cmd+B</kbd><kbd class="platform-windows platform-linux">Ctrl+B</kbd>. Cela recherche dans vos "tampons" ou des fichiers ouverts. Vous pouvez également limiter cette recherche avec <kbd class="platform-mac">Cmd+Shift+B</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+B</kbd>, qui ne recherche que les fichiers qui sont nouveaux ou qui ont été modifiés depuis votre dernier commit Git.

Fuzzy finder utilise les paramètres `core.ignoredNames`, `fuzzy-finder.ignoredNames` et `core.excludeVCSIgnoredPaths` pour filtrer les fichiers et les dossiers qui ne seront pas affichés. Si vous avez un projet avec des tonnes de fichiers dont vous ne voulez pas faire la recherche, vous pouvez ajouter des motifs ou des chemins à ces paramètres de configuration ou à vos fichiers [standard `.gitignore` files](https://git-scm.com/docs/gitignore). Nous en apprendrons plus sur les paramètres de configuration dans les paramètres de [Global Configuration Settings](/using-atom/sections/basic-customization/#global-configuration-settings), mais pour l'instant, vous pouvez facilement les définir dans la vue Paramètres sous Paramètres de base.

Les noms `core.ignoredNames` et `fuzzy-finder.ignoredNames` sont interprétés comme schémas globaux comme implémenté par le [minimatch Node module](https://github.com/isaacs/minimatch).

{{#tip}}

**Notation de configuration**

Vous verrez parfois que nous ferons références à des paramètres de configuration appelés "Ignored names in Core Settings". D'autres fois, vous nous verrez utiliser le nom abrégé comme `core.ignoredNames`. Les deux se réfèrent à la même chose. Le raccourci est le nom du package, puis un point `.`, Suivi du nom "camel-cased" du paramètre.

Si vous avez une phrase que vous voulez à camel-case, procédez comme suit:

1. Passez en minuscule le premier mot
1. Passez en majuscule la première lettre de chaque mot suivant
1. Supprimez les espaces

Ainsi "Ignored Names" devient "ignoredNames".

{{/tip}}
