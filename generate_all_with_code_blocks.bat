@echo off
REM ---------------------------------------------------------------------------------------------------
REM
REM		 generate_all_with_code_blocks.bat : 	Nom de ce batch  
REM
REM      Batch de lancement de toutes les générations d'une application Windows (source C avec un fichier resource) 
REM    avec l'IDE Code::Blocks en mode ligne de commande,
REM    ou d'une seule génération, si le troisième paramètre fait partie de la liste suivante :
REM    
REM          [BCC|MINGW32OF|MINGW64CB|DEVCPP|CYGWIN32|CYGWIN64|MINGW32WL|MINGW64WL|TDM32|TDM64|MSYS2W32|MSYS2W64|NMAKEX32|NMAKEX64|VS2022X32|VS2022X64|CLANGX32|CLANGX64|CLANGW32|CLANGW64|CLANGMW32|CLANGMW64|DMC|LCC32|LCC64|PELLESC32|PELLESC64|WATCOM32|WATCOM64] 
REM
REM     Pré-requis, il faut bien entendu, positionner la variable d'environnement PATH en y incluant le répertoire d'installation de l'IDE Code::Blocks.
REM     L'IDE C::B est capable de générer TOUtes les générations par l'intermédiaire d'une "virtual target" dénommé "all build".
REM     Points d'attention, j'ai positionné des variables d'environnement sous Windows (en mode "système") pour gérer les différentes versions de Visual Studio, du KIT WINDOWS et de CLANG installees :
REM          CLANG_VERSION     valué (à date) par       14.0.6     		(dernière version sur Windows 11, aussi bien pour les binaires valables pour VS2022 que pour les environnements Mingw et MSYS)
REM          VS_VERSION        valué (à date) par       2022       		(dernière version sur Windows 11)
REM          VS_NUM            valué (à date) par       14.33.31629     (dernière version sur Windows 11)
REM          KIT_WIN_VERSION   valué (à date) par       10    			(dernière version sur Windows 11)
REM          KIT_WIN_NUM       valué (à date) par       10.0.22621.0    (dernière version sur Windows 11)
REM		Je les utilise par l'opérateur de traduction %var% des fichiers de commandes Windows.
REM
REM 	PS : la procédure "create_dir.bat" permet de créer TOUS les répertoires utiles à ces générations multiples (certains compilateurs ne sont pas caapbles de les créer ONLINE s'ils sont absents),
REM          et ensuite on lance generate_all_with_code_blocks.bat "nom_répertoire" "nom_appli" [id_generator].
REM 
REM 	AUTHOR : 						Thierry DECHAIZE
REM     Date de création :				9 août 2022   
REM 	Date dernière modification : 	9 septembre 2022   -> adjonction d'un deuxième paramètre recupéré dans la variable %NAME_APPLI% pour augmenter le paramètrage de ce script.
REM 	Détails des modifications : 	Ce deuxième paramètre décale par conséquent le troisième (toujours optionnel) qui continue de servir de choix du générateur/compilateur souhaité pour tests.
REM 	Version de ce script :			1.1.0 ->  "Version majeure" . "Version mineure" . "niveau de patch"
REM
REM ---------------------------------------------------------------------------------------------------
  
if [%1]==[] goto usage
if [%2]==[] goto usage
if not exist %1\ goto usage
@echo on
echo "Directory des sources : %1"
echo "Nom de l'application  : %2"

@echo off
set DIRINIT=%CD%
SET PATHSAV=%PATH%
set SOURCE_DIR=%1
set NAME_APPLI=%2
set TARGET=%3
cd %SOURCE_DIR%

SET PATH=C:\CodeBlocks;%PATH%

:SUITE
if "%3" NEQ "" goto CBONE else set TARGET=%3

REM             Lancement Code::Blocks de toutes les générations 
:CBALL
codeblocks.exe /na /nd --no-splash-screen --batch-build-notify --no-batch-window-close --rebuild %NAME_APPLI%.workspace --target='All_build' 
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
GOTO FIN

REM             Lancement Code::Blocks dpour une seule génération désignée par "target"
:CBONE
codeblocks.exe /na /nd --no-splash-screen --batch-build-notify --no-batch-window-close --rebuild %NAME_APPLI%.workspace --target=’%TARGET%’ 
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
GOTO FIN

:usage
echo Usage : %0 DIRECTORY_SRC NAME_APPLI [Generateur] 
echo   avec compilateur = [BCC|MINGW32OF|MINGW64CB|DEVCPP|CYGWIN32|CYGWIN64|MINGW32WL|MINGW64WL|TDM32|TDM64|MSYS2W32|MSYS2W64|NMAKEX32|NMAKEX64|VS2022X32|VS2022X64|CLANGX32|CLANGX64|CLANGW32|CLANGW64|CLANGMW32|CLANGMW64|DMC|LCC32|LCC64|PELLESC32|PELLESC64|WATCOM32|WATCOM64]
echo   et si pas de troisième paramètre, exécution via CB de toutes les générations.

:FIN
cd %DIRINIT%
