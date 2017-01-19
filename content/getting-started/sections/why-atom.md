---
titre: Pourquoi Atom?
---
### Pourquoi Atom?

Il existe un grand nombre d'éditeurs de texte sur le web; alors pourquoi perdre son temps à apprendre à utiliser Atom?

Les éditeurs comme Sublime ou TextMate sont faciles à utiliser mais n'offre qu'une extensibilité limitée. Contrairement à Emacs et Vim qui permettent une plus grande flexibilité mais qui ne sont pas vraiment abordable et qui ne peuvent être customiser qu'avec des scripts de langages spéciaux uniquement.

Avec Atom, on pense que l'on peut réaliser quelque chose de mieux. Notre objectif est une combinaison sans compromis entre la sécurité contre le hacking et l'utilisation de l'éditeur: un éditeur qui sera à la fois accueillant pour un débutant en programmation mais qu'il continuera d'utiliser au fur et à mesure de son apprentissage.

Alors que l'on construisait Atom grâce à Atom, ce qui a commencé en simple expérience est devenu graduellement en un outil indispensable pour notre quotidien. A la surface, Atom est juste un éditeur de texte moderne auquel on est habitué. Soulèvez le capot et tu trouveras un système qui ne demande qu'à être hacker.

#### Le Noyau d'Atom

Comme on le sait, le web a ses défauts, mais deux décennies de développement l'on transformé en une plateforme incroyablement
malléable et puissante. Donc, lorsque nous nous sommes mis à développer un éditeur de texte, la technologie Web était le choix
évident. Mais d'abord, il fallait le libérer de ses chaînes.

##### La Toile Web

Les navigateurs Web sont géniaux pour naviguer sur des pages web, mais écrire du code est une activité un peu spéciale qui nécessite des outils adéquats à la tâche. Plus important, les navigateurs restreignent sérieusement l'accès au système local pour des raisons de sécurité, et pour nous, un éditeur de texte qui ne pouvait pas écrire des fichiers ou exécuter des sous processus locaux n'était pas envisageable.

C'est pour cette raison que nous n'avons pas construit Atom comme une application web traditionnelle. 

Au lieu de cela, Atom est une variante spécialisée de Chromium conçu pour être un éditeur de texte plutôt qu'un navigateur Web. Chaque fenêtre Atom est essentiellement une page Web locale. Toutes les API disponibles pour une application Node.js typique sont également disponibles pour le code en cours d'exécution dans le contexte JavaScript de chaque fenêtre. Cet éditeur hybride offre une expérience de développement client unique.

Comme tout est local, vous n'avez pas à vous soucier des pipelines d'actifs, de la concaténation de scripts et des définitions de modules asynchrones. Si vous voulez charger un code, il suffit de le demander en haut de votre fichier. Le système de modules de noeud simplifie la coupure du système en lots de petits paquets ciblés.

##### JavaScript, Voici C++

Intéragir avec le code source est assez simple. Par exemple, nous avons écrit un papier sur les expressions régulières d'Oniguruma pour notre assistance de grammaire TextMate. Avec un navigateur, il aura fallu avoir recours à Esprima ou NaCl. L'intégration des noeuds dans Atom rend la tâche plus simple.

En plus des API de Noeud, nous exposons aussi des API pour des dialogues natals, permettant ainsi l'ajout d'applications, des menus contextuels, des manipulations de fenêtres, etc.

##### Web Tech: les parties amusantes

Une autre chose plutôt sympathique avec Atom lorsque l'on écrit du code est la garantie que l'on tourne sur la dernière version de Chromium. Cela veut dire que l'on a pas besoin de se soucier des problèmes de compatibilités entre le navigateur et les polyfills. Nous pouvons donc utiliser toutes les magnifiques fonctionnalités du web de demain... aujourd'hui.

Par exemple, la disposition de notre espace de travail est basée sur Flexbox. Cette norme est assez récente et est sujet à beaucoup de changements depuis que nous avons commencé à l'utiliser mais cela ne nous importe peu tant que ça fonctionne.

Grâce à l'évolution constante des technologies du Web, nous sommes confiant quant à la direction que prend le projet Atom. Les technologies UI vont et viennent, mais le web est une norme qui devient de plus en plus complète et omniprésente au fil des années. Et explorer les fins fonds de ses capacités est quelque chose qui nous motive et qui nous excite.

#### Un éditeur de texte Open Source

Pour nous, Atom est un exemple parfait de complément à la principale mission de GitHub, à savoir la construction, la création de meilleurs logiciels grâce à l'entraide et au travail fourni tous ensemble. Atom est un projet à long terme, et GitHub sera toujours là pour nous soutenir. Mais nous ne pouvons atteindre la perfection seuls Comme nous l'on montré Emacs ou Vim, au cours des 3 dernières décennies, c'est que pour construire une communauté florissante et durable autour d'un projet comme Atom, cela passe par un éditeur open source.

Atom est gratuit et open source et vous pouvez le retrouver à l'adresse https://github.com/atom.
