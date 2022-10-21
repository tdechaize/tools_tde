# tools_tde

Quelques outils facilitant l'usage des outils de génération (aussi bien CB que CMAKE)

Le plus important est "create_dir.bat". je l'utilise en permanence car il permet la création de TOUS les sous-répertoires utiles aux générations à partir du répertoire "master".
ATTENTION : Ce répertoire "master" est la structure la plus haute de votre application, et il est recommandé pour CMAKE de ne pas y laisser les sources de celle-ci.
C'est la raison, pour laquelle, j'ai systèmatiquement déposé les sources dans le sous-répertoire "src".
Pour les générations CMAKE, il est nécessaire de créer sous le master un sous-répertoire "build.cmake" contenant TOUS les fichiers de paramètrage (CMAKELists.txt pour CMAKE, 
et makefile pour chaque génération gérée hors CMAKE).
Donc, tous ces modèles (paramètrables avec le nom de l'application) se retrouvent ici dans le répertoire de référence "build.cmake".
Pour la génération en "ligne de commandes", il est nécessaire de créer un répertoire build.batch contenant les scripts de compilations/linkage de chaque environnement de développement (compilers, IDES or development package).
Enfin, il y a bien évidemment l'outil de génération "generate_all_with_cmake.bat" ou encore "generate_all_with_command_files.bat", eux aussi paramétrables, il suffit de les lancer en mode sans paramètre pour obtenir l'aide adéquate.
Pour conclure, vous trouverez des scripts "python" de calcul des tailles (volumes générès sur disque pour statistiques si besoin) et des checksums des exécutables générés, ou encore de transfert automatique d'un fichier vers une liste de répertoires (pour le moment 
celle liste est figée dans le script, mais en l'examinant, vous pouvez modifier cette trame à votre convenance).

Le script de génération automatique en ligne de commande CB ne fonctionne pas (... encore !).
je lance donc la génération dr TOUTES les générations directement dans l'IDE  Code::Blocks en choisissant la "cible virtuelle" -> All_build.

A vous de jouer, tout est là, avec des commentaires explicatifs dans chaque script (ou presque ... -) ).
