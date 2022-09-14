# tools_tde
Quelques outils facilitant l'usage des outils de génération (aussi bien CB que CMAKE)

Le plus important est "create_dir.bat". je l'utilise en permanence car il permet la création de TOUS les sous-répertoires utiles aux générations à partir du "master".
ATTENTION : le master est la structure la plus haute de votre application, et il est recommandé pour CMAKE de ne pas y laisser les sources de celle-ci.
C'est la raison, pour laquelle, j'ai systèmatiquement déposé les sources dans le sous-répertoire "src".
Pour les générations CMAKE, il est nécessaire de créer sous le master un sous-répertoire "build.cmake" contenant TOUS les fichiers de paramètrage (CMAKELists.txt pour CMAKE, 
et makefile pour chaque génération gérée hors CMAKE).
Donc, tous ces modèles (paramètrables avec le nom de l'application) se retrouvent ici dans le répertoire de référence "build.cmake".
Enfin, il y a bien évidemment l'outil de génération "generate_all_with_cmake.bat" lui aussi paramétrable, il suffit de la lancer en mode sans paramètre pour obtenir
l'aide adéquate.
Enfin, il y a des scripts "python" de calcul des checksums des exécutables générés ou de transfert automatique d'un fichier vers une liste de répertoires (pour le moment 
celle liste est figée dans le script, mais en l'examinant, vous pouvez modifier cette trame à votre convenance).
Le script de génération automatique en ligne de commande CB ne fonctionne pas (... encore !).
je lance donc la génération CB directement dans l'IDE.

A vous de jouer, tout est là, avec des commentaires explicatifs dans chaque script (ou presque ... -) ).
