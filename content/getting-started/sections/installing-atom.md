---
titre: Installer Atom
---
### Installer Atom

Pour commencer à utiliser Atom, nous avons besoin de l'avoir sur notre système. Cette section passera en revue l'installation sur votre ordinateur tout comme que les bases d'Atom.

Installer Atom est normalement très simple. Généralement vous allez sur https://atom.io et en haut de la page vous devriez voir un bouton "Téléchargement" comme ci-dessous:


{{#mac}}

![Download buttons on https://atom.io](../../images/mac-downloads.png "Download buttons on https://atom.io")

{{/mac}}

{{#windows}}

![Download buttons on https://atom.io](../../images/windows-downloads.png "Download buttons on https://atom.io")

{{/windows}}

{{#linux}}

![Download buttons on https://atom.io](../../images/linux-downloads.png "Download buttons on https://atom.io")

{{/linux}}

Le bouton devrait être spécifique à votre plate-forme et le package de téléchargement doit s'installer facilement. Cependant, allons plus loin avec un peu plus de détails.

{{#mac}}

#### Installer Atom sur Mac

Atom suit le processus standard d'installation de Mac zip. Vous pouvez soit appuyer sur le bouton de téléchargement du site https://atom.io soit vous pouvez aller à la page [Atom releases] [releases] pour télécharger le fichier `atom-mac.zip`. Une fois que vous avez ce fichier, vous pouvez cliquer dessus pour extraire l'application, puis faites glisser la nouvelle application `Atom` dans votre dossier" Applications ".

Lorsque vous ouvrez Atom pour la première fois, il essaiera d'installer les commandes `atom` et` apm` à utiliser dans le terminal. Dans certains cas, Atom peut ne pas être en mesure d'installer ces commandes car il a besoin d'un mot de passe administrateur. Pour vérifier si Atom a pu installer la commande `atom`, par exemple, ouvrez une fenêtre de terminal et tapez` which atom`. Si la commande `atom` a été installée, vous verrez quelque chose comme ceci:

``` command-line
$ which atom
> /usr/local/bin/atom
$
```

Si les commandes `atom` n'étaient pas installées, la commande `which` ne retournerait rien:

``` command-line
$ which atom
$
```

Pour installer les commandes `atom` et `apm`, lancez "Window: Install Shell Commands" depuis [Command Palette](/getting-started/sections/atom-basics#command-palette), qui vous demandera un mot de passe administrateur.

{{/mac}}

{{#windows}}

#### Installing Atom sur Windows

Atom est disponible avec un exécuteur Windows qui peut-être téléchargé depuis https://atom.io ou depuis [Atom Releases][releases] intitulé `AtomSetup.exe`. Ce programme va installer Atom, ajouter les commandes `atom` et `apm` à votre `PATH`, créer un raccourci sur votre bureau et rendre Atom disponible pour tous les fichiers "Ouvrir avec ..."

![Atom on Windows](../../images/windows.gif)

##### Mode Portable sur Windows

Atom peut également être exécuté en mode portable sur Windows, ce qui lui permet d'être placé sur un périphérique de stockage amovible où il stockera également ses paramètres, packages, cache, etc... pour que vous puissiez facilement le prendre d'une machine à l'autre sans avoir besoin d'installer quoi que ce soit.

Pour commencer avec Atom en mode portable:

1. Téléchargez `atom-windows.zip` depuis [Atom Releases][releases]
1. Extraire `atom-windows.zip` dans votre périphérie de stockage amovible
1. Lancer atom.exe depuis le fichier d'Atom décompréssé
1. Une fois qu'Atom a été lancé, cela créera un dossier `.atom` dans `%USERPROFILE%`
1. Déplacer le dossier `.atom` à côté de votre dossier Atom sur votre périphérie de stockage amovible

Maintenant à chaque fois que vous lancez `atom.exe` à partir de votre périphérique de stockage amovible, il fonctionnera en mode portable et stockera tous ses paramètres et les packages dans le dossier `.atom` sur le périphérie.

Notez qu'il existe certaines limitations au mode portable:

* Il n'y a pas d'intégration d'exploreur ou de ligne de commande pour configurer le `PATH`
* Le dossier `.atom` doit être à côté du dossier contenant atom.ex (et non à l'intérieur)
* Le dossier `.atom` doit être modifiable
* La variable d'environnement `ATOM_HOME` de doit pas être modifié (cela annule le comportement de l'ordinateur)

##### Installeur MSI pour Windows

Atom est aussi disponible dans un package .MSI de [Atom Releases](https://github.com/atom/atom/releases/latest) qui peut être déployé ou installé sur votre machine. Chaque utilisateur se connectant à cette machine trouvera Atom installé dessus automatiquement. (Cela prendra quelques secondes la première fois que vous vous connecterez pour que l'icône apparaisse sur le bureau).

Si l'utilisateur désinstalle Atom, cela le fera uniquement sur sa session et ne sera pas réinstaller à la prochaine connexion. Eventuellement si cette personne souhaite réinstaller Atom une nouvelle fois, il faut supprimer le fichier `%LOCALAPPADATA%\Atom`

{{/windows}}

{{#linux}}

#### Installer Atom sur Linux

Pour installer Atom sur Linux, vous pouvez télécharger [Debian package](https://atom.io/download/deb) ou [RPM package](https://atom.io/download/rpm) soit à partir de [main Atom website](https://atom.io) soit à partir de [Atom project releases page][releases]. Ces packages ne disposent pas actuellement de fonctionnalités de mise à jour automatique. Par conséquent, lorsque vous souhaitez mettre à niveau vers une nouvelle version d'Atom, vous devrez répéter ce processus d'installation.

[releases]: https://github.com/atom/atom/releases/latest

##### Debian and systèmes similaires

pour installer Atom sur Debian, Ubuntu ou des systèmes similaires:

``` command-line
# Install Atom
$ sudo dpkg -i atom-amd64.deb

# Install Atom's dependencies if they are missing
$ sudo apt-get -f install
```

##### RedHat Enterprise et systèmes similaires

Pour installer Atom sur CentOS, Oracle Linux, RedHat Entreprise Linux, Scientific Linux ou des systèmes associés qui utilisent le gestionnaire de packages yum:

``` command-line
$ sudo yum install -y atom.x86_64.rpm
```

##### Fedora et systèmes similaires


Pour télécharger et installer la dernière version d'Atom sur Fedora ou sur d'autres systèmes utilisant le gestionnaire de packages DNF:

``` command-line
$ sudo dnf install -y atom.x86_64.rpm
```

##### SUSE et systèmes similaires

Pour télécharger et installer la dernière version d'Atom sur openSUSE ou sur d'autres systèmes utilisant le gestionnaire de packages Zypp:

``` command-line
$ sudo zypper in -y atom.x86_64.rpm
```

{{/linux}}

#### Construire Atom depuis la source

Vous pouvez également construire Atom depuis le code source. Le répertoire Atom présent sur GitHub vous permettra d'avoir tous les détails nécessaires pour chaque système [build instructions for Mac, Windows, Linux and FreeBSD](https://github.com/atom/atom/tree/master/docs/build-instructions).

#### Paramètres Proxy et pare-feu

##### Derrière un pare-feu?

Si vous êtes derrière un pare-feu et voyez une erreur SSL quand vous installez un package, vous pouvez désactiver la restriction SSL en exécutant:

``` command-line
$ apm config set strict-ssl false
```

##### Utiliser un proxy?

Si vous utilisez un proxy HTTP(S) vous pouvez configurer Apm en utilisant cette commande :

``` command-line
$ apm config set https-proxy <em>YOUR_PROXY_ADDRESS</em>
```

Vous pouvez lancer `apm config get https-proxy` pour vérifier si cela a été installé correctement.
