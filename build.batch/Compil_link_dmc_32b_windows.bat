@echo off
REM ---------------------------------------------------------------------------------------------------
REM
REM		 Compil_link_dmc_32b_windows.bat : 	Nom de ce batch  
REM
REM      Batch de lancement d'une générations d'une application Windows (source C avec un fichier resource) 
REM    avec le compilateur Digital Mars Compiler v857.
REM
REM     Dans les grands principes, on modifie certaines variables d'environnement dont le PATH Windows, afin 
REM     de pouvoir lancer une compilation du source C, du fichier de resource et enfin de l'édition de lien
REM     final qui génère l'application attendue.
REM     Ce batch prend quatre paramètres  :
REM 				le répertoire des sources de l'application (le 1er paramètre),
REM 				le nom de l'application (qui doit être identique au nom du fichier source C, 
REM 								ainsi qu'au nom du fichier des ressources -> extension ".rc")
REM					le type de génération (compilation + linkage/manager de librairie) attendue parmi la 
REM									liste suivante : console|windows|lib|dll
REM					la catégorie de génération attendue parmi la liste suivante : Debug|Release
REM
REM 	PS : la procédure "create_dir.bat" permet de créer TOUS les répertoires utiles à ces générations multiples 
REM 					(certains compilateurs ne sont pas capables de les créer ONLINE s'ils sont absents !!)
REM 
REM 	AUTHOR : 						Thierry DECHAIZE
REM     Date de création :				26 Septembre 2022   
REM 	Date dernière modification : 	27 septembre 2022  -> adjonction de deux nouveaux paramètres afin de gérer : 
REM 								la cible attendue (Console, appli windows, lib ou dll) et le mode DEBUG|RELEASE.
REM 	Détails des modifications : 	le paramétrage permet une certaine généricité, mais le structure des sources 
REM 									est imposée sur le sous-répertoire \src : %NAME_APPLI%.c + %NAME_APPLI%.rc
REM 	Version de ce script :			1.1.3  ->  "Version majeure" . "Version mineure" . "niveau de patch"
REM
REM ---------------------------------------------------------------------------------------------------
REM set dmc=C:\dmc
  
if [%1]==[] goto usage
if [%2]==[] goto usage
if not exist %1\ goto usage
echo "Répertoire principal de l'application : %1"
echo "Nom de l'application  				: %2"

set DIRINIT=%CD%
SET PATHSAV=%PATH%
SET LIBSAV=%LIB%
SET INCSAV=%INCLUDE%
set SOURCE_DIR=%1
set NAME_APPLI=%2
cd %SOURCE_DIR%

REM    Génération d'une application [console|windows|lib|dll] (compil + link/lib) pour le compilateur Digital Mars Compiler 
:DMC
SET PATH=C:\dm\bin;%PATH%
SET INC1=C:\dm\include\WIN32
SET INC2=C:\dm\include
SET INC3=C:\dm\stlport\stlport\stl
set LIB=C:\dm\lib
if "%3"=="console" goto CONSOL
if "%3"=="windows" goto APPWIN
if "%3"=="lib" goto LIBRA
if "%3"=="dll" goto DLLA

:CONSOL
echo "Digital Mars Compiler C/C++ v8.57 -> Genération console de l'application en mode : %4"
if "%4"=="Debug" goto DEBCONS
set "CFLAGS=-c -mn" 
dmc %CFLAGS% -DNDEBUG -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Release\%NAME_APPLI%.obj src\%NAME_APPLI%.c 
rcc -32 -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Release\%NAME_APPLI%.res src\%NAME_APPLI%.rc
link /NOLOGO /subsystem:console objDMC\Release\%NAME_APPLI%.obj , , binDMC\Release\%NAME_APPLI%.exe , glu32.lib opengl32.lib gdi32.lib advapi32.lib comdlg32.lib winmm.lib user32.lib kernel32.lib , objDMC\Release\%NAME_APPLI%.res
goto FIN
:DEBCONS
set "CFLAGS=-c -mn -g"
dmc %CFLAGS% -DDEBUG -D_DEBUG -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Debug\%NAME_APPLI%.obj src\%NAME_APPLI%.c
rcc -32  -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Debug\%NAME_APPLI%.res src\%NAME_APPLI%.rc
link /NOLOGO /subsystem:console /debug objDMC\Debug\%NAME_APPLI%.obj , , binDMC\Debug\%NAME_APPLI%.exe , glu32.lib opengl32.lib gdi32.lib advapi32.lib comdlg32.lib winmm.lib user32.lib kernel32.lib , , objDMC\Debug\%NAME_APPLI%.res 
goto FIN

:APPWIN
echo "Digital Mars Compiler C/C++ v8.57 -> Genération windows de l'application en mode : %4"
if "%4"=="Debug" goto DEBAPP
set "CFLAGS=-c -mn"
dmc %CFLAGS% -DNDEBUG -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Release\%NAME_APPLI%.obj src\%NAME_APPLI%.c
rcc -32 -I%INC1% -I%INC2% -I%INC3%  -oobjDMC\Release\%NAME_APPLI%.res src\%NAME_APPLI%.rc
link /NOLOGO /subsystem:windows  objDMC\Release\%NAME_APPLI%.obj , binDMC\Release\%NAME_APPLI%.exe , , glu32.lib opengl32.lib gdi32.lib advapi32.lib comdlg32.lib winmm.lib user32.lib kernel32.lib , , objDMC\Release\%NAME_APPLI%.res
goto FIN
:DEBAPP
set "CFLAGS=-c -mn -g"
dmc %CFLAGS% -DDEBUG -D_DEBUG -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Debug\%NAME_APPLI%.obj src\%NAME_APPLI%.c
rcc -32 -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Debug\%NAME_APPLI%.res src\%NAME_APPLI%.rc
link /NOLOGO /subsystem:windows /debug objDMC\Debug\%NAME_APPLI%.obj ,  binDMC\Debug\%NAME_APPLI%.exe , , glu32.lib opengl32.lib gdi32.lib advapi32.lib comdlg32.lib winmm.lib user32.lib kernel32.lib ,  , objDMC\Debug\%NAME_APPLI%.res
goto FIN

:LIBRA
echo "Digital Mars Compiler C/C++ v8.57 -> Genération d'une librairie en mode : %4"
if "%4"=="Debug" goto DEBLIB
set "CFLAGS=-c -mn"
dmc %CFLAGS% -DNDEBUG  -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Release\%NAME_APPLI%.obj src\%NAME_APPLI%.c
REM rcc -32  -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Release\%NAME_APPLI%.res src\%NAME_APPLI%.rc
lib -c binDMC\Release\%NAME_APPLI%.lib objDMC\Release\%NAME_APPLI%.obj
goto FIN
:DEBLIB
set "CFLAGS=-c -mn -g"
dmc %CFLAGS% -DDEBUG -D_DEBUG -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Debug\%NAME_APPLI%.obj src\%NAME_APPLI%.c
REM rcc -32 -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Debug\%NAME_APPLI%.res src\%NAME_APPLI%.rc
lib -c binDMC\Debug\%NAME_APPLI%.lib objDMC\Debug\%NAME_APPLI%.obj
goto FIN

:DLLA
echo "Digital Mars Compiler C/C++ v8.57 -> Genération d'une librairie partagée (.ie. DLL) en mode : %4"
if "%4"=="Debug" goto DEBDLL
set "CFLAGS=-c -mn -WD"
dmc %CFLAGS% -DNDEBUG  -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Release\%NAME_APPLI%.obj src\%NAME_APPLI%.c
rcc -32  -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Release\%NAME_APPLI%.res src\%NAME_APPLI%.rc
link /IMPLIB=binDMC\Release\%NAME_APPLI%.lib objDMC\Release\%NAME_APPLI%.obj ,  , binDMC\Release\%NAME_APPLI%.dll , opengl32.lib gdi32.lib advapi32.lib comdlg32.lib winmm.lib user32.lib kernel32.lib , , objDMC\Release\%NAME_APPLI%.res
goto FIN
:DEBDLL
set "CFLAGS=-c -mn -WD -g"
dmc %CFLAGS% -DDEBUG -D_DEBUG -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Debug\%NAME_APPLI%.obj src\%NAME_APPLI%.c
rcc -32  -I%INC1% -I%INC2% -I%INC3% -oobjDMC\Debug\%NAME_APPLI%.res src\%NAME_APPLI%.rc
link /debug /IMPLIB=binDMC\Debug\%NAME_APPLI%.lib objDMC\Debug\%NAME_APPLI%.obj , , binDMC\Debug\%NAME_APPLI%.dll , glu32.lib opengl32.lib gdi32.lib advapi32.lib comdlg32.lib winmm.lib user32.lib kernel32.lib , , objDMC\Debug\%NAME_APPLI%.res
goto FIN

:usage
echo "Usage : %0 DIRECTORY_APPLI NAME_APPLI console|windows|lib|dll Debug|Release"
echo "et si pas de deuxième paramètre, affichage de cette explication d'usage"
echo "ou alors, le répertoire des sources n'existe pas ... !"
 
:FIN
SET INCLUDE=%INCSAV%
SET LIB=%LIBSAV%
SET INC1=""
SET INC2=""
SET INC3=""
SET PATH=%PATHSAV%
cd %DIRINIT%