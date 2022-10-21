@echo off
REM ---------------------------------------------------------------------------------------------------
REM
REM		 generate_all_with_command_files.bat : 	Nom de ce batch  
REM
REM      Batch de lancement de toutes les g�n�rations d'une application Windows (source C avec un fichier resource) 
REM    avec plusieurs batch de g�n�ration, on d'une seule g�n�ration, si le deuxi�me param�tre fait partie de la liste suivante :
REM    
REM          [BCC|MINGW32OF|MINGW64CB|DEVCPP|CYGWIN32|CYGWIN64|MINGW32WL|MINGW64WL|TDM32|TDM64|MSYS2W32|MSYS2W64|NMAKEX32|NMAKEX64|VS2022X32|VS2022X64|CLANGX32|CLANGX64|CLANGW32|CLANGW64|CLANGMW32|CLANGMW64|DMC|LCC32|LCC64|PELLESC32|PELLESC64|WATCOM32|WATCOM64] 
REM
REM     Dans les grands principes, il y a un fichier batch diff�rent pour chaque cat�gorie de compilateurs stock� sous %APPLI_DIR%\build.batch\Compil_link_"Id Compilateur"_[32|64]b_windows.bat
REM     Il est n�cessaire de g�n�rer l'application attendue pour chacune des versions Debug et Release (.ie. on lance le batch deux fois de suite ...).
REM     Il faut bien etendu, positionner pour chaque compilateur les variables d'environnement PATH, et parfois LIB et INCLUDE, mais tout cette "tambouille" d'identification de r�pertoires
REM 	est bien g�r�e dans chacun de ces batchs. J'ai ainsi permis un totale autonomie : vous pouvez les utilisez ind�pendamment de TOUTES contraintes d'outils tierces.
REM 	Seuls, les param�trages de chaque PATH, INCLUDE (il peut en exister plusieurs INC1, INC2 ...) et LIB (il peuten exister plusieurs LIB, LIB2 ...) sont d�pendants des r�pertoires
REM     d'installtion des diff�rents environnements de d�veloppement (IDE + compilateurs, compilateurs ou packages assimilant compilateurs + outils).
REM
REM     Points d'attention, j'ai positionn� des variables d'environnement sous Windows (en mode "syst�me") pour g�rer les diff�rentes versions de Visual Studio, du KIT WINDOWS et de CLANG installees :
REM          CLANG_VERSION     valu� (� date) par       15.0.2     		(derni�re version sur Windows 11, aussi bien pour les binaires valables pour VS2022 que pour les environnements Mingw et MSYS)
REM          VS_VERSION        valu� (� date) par       2022       		(derni�re version sur Windows 11)
REM          VS_NUM            valu� (� date) par       14.33.31629     (derni�re version sur Windows 11)
REM          KIT_WIN_VERSION   valu� (� date) par       10    			(derni�re version sur Windows 11)
REM          KIT_WIN_NUM       valu� (� date) par       10.0.22621.0    (derni�re version sur Windows 11)
REM
REM 	PS : la proc�dure "create_dir.bat" permet de cr�er TOUS les r�pertoires utiles � ces g�n�rations multiples (certains compilateurs ne sont pas caapbles de les cr�er ONLINE s'ils sont absents),
REM          et ensuite on lance generate_all_with_command_files.bat "nom_r�pertoire" "nom_appli" [id_generator].
REM 
REM 	AUTHOR : 						Thierry DECHAIZE
REM     Date de cr�ation :				10 octobre 2022   
REM 	Date derni�re modification : 	10 octobre 2022   -> adjonction d'un deuxi�me param�tre recup�r� dans la variable %NAME_APPLI% pour augmenter le param�trage de ce script.
REM 	D�tails des modifications : 	Ce deuxi�me param�tre d�cale par cons�quent le troisi�me (toujours optionnel) qui continue de servir de choix du g�n�rateur/compilateur souhait� pour tests.
REM 	Version de ce script :			1.1.4  ->  "Version majeure" . "Version mineure" . "niveau de patch"
REM
REM ---------------------------------------------------------------------------------------------------
  
if [%1]==[] goto usage
if not exist %1\ goto usage
@echo on
echo "Directory del'application : %1"
echo "Nom de l'application  	: %2"

@echo off
set DIRINIT=%CD%
SET PATHSAV=%PATH%
set APPLI_DIR=%1
set NAME_APPLI=%2
REM cd call %APPLI_DIR%
 
:SUITE
if "%3" NEQ "" goto %3

REM             G�n�ration batch pour le compilateur Borland C/C++ 5.51 
:BCC
call %APPLI_DIR%\build.batch\Compil_link_Borland_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_Borland_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch --fresh pour GCC 9.2.0 int�gr� � MINGW32 (version officielle)
:MINGW32OF
call %APPLI_DIR%\build.batch\Compil_link_MINGW32OF_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_MINGW32OF_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour GCC 3.4.5 int�gr� � Dev-Panda 4.9.9.2  (Dev-Cpp n'est plus maintenu !)
:DEVCPP
call %APPLI_DIR%\build.batch\Compil_link_DEVCPP_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_DEVCPP_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch --fresh pour GCC 8.1.0 int�gr� � l'environnement IDE Code::Blocks
:MINGW64CB
call %APPLI_DIR%\build.batch\Compil_link_MINGW64CB_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_MINGW64CB_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour GCC 12.1.0 int�gr� � l'environnement CYGWIN 32 bits
:CYGWIN32
call %APPLI_DIR%\build.batch\Compil_link_cygwin_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_cygwin_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour GCC 12.1.0 int�gr� � l'environnement CYGWIN 64 bits
:CYGWIN64
call %APPLI_DIR%\build.batch\Compil_link_cygwin_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_cygwin_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour GCC 12.2.0 int�gr� � l'environnement WINLIBS 32 bits
:MINGW32WL
call %APPLI_DIR%\build.batch\Compil_link_MINGW32WL_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_MINGW32WL_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour GCC 12.2.0 int�gr� � l'environnement WINLIBS 64 bits
:MINGW64WL
call %APPLI_DIR%\build.batch\Compil_link_MINGW64WL_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_MINGW64WL_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour GCC 12.2.0 int�gr� � l'environnement MSYS2 en 32 bits
:MSYS2W32
call %APPLI_DIR%\build.batch\Compil_link_MSYS2W32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_MSYS2W32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour GCC 12.2.0 int�gr� � l'environnement MSYS2 en 64 bits
:MSYS2W64
call %APPLI_DIR%\build.batch\Compil_link_MSYS2W64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_MSYS2W64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour GCC 10.3.0 int�gr� � l'environnement TDM 32 bits
:TDM32
call %APPLI_DIR%\build.batch\Compil_link_TDMW32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_TDMW32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour GCC 10.3.0 int�gr� � l'environnement TDM 64 bits
:TDM64
call %APPLI_DIR%\build.batch\Compil_link_TDMW64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_TDMW64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour Visual Studio 2022 en version 32 BITS
:VS2022X32 
call %APPLI_DIR%\build.batch\Compil_link_VS2022X32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_VS2022X32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour Visual Studio 2022 en version 64 BITS
:VS2022X64 
call %APPLI_DIR%\build.batch\Compil_link_VS2022X64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_VS2022X64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour CLANG en version 32 BITS adoss� � Visual Studio 2022 
:CLANGX32 
call %APPLI_DIR%\build.batch\Compil_link_CLANGX32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_CLANGX32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour CLANG en version 64 BITS adoss� � Visual Studio 2022 
:CLANGX64 
call %APPLI_DIR%\build.batch\Compil_link_CLANGX64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_CLANGX64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour CLANG MINGW GNU/GCC en version 32 bits
:CLANGW32
call %APPLI_DIR%\build.batch\Compil_link_CLANGW32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_CLANGW32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour CLANG MINGW GNU/GCC en version 64 bits
:CLANGW64
call %APPLI_DIR%\build.batch\Compil_link_CLANGW64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_CLANGW64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour CLANG MSYS2 GNU/GCC en version 32 bits
:CLANGMW32
call %APPLI_DIR%\build.batch\Compil_link_CLANGMW32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_CLANGMW32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour CLANG MSYS2 GNU/GCC en version 64 bits
:CLANGMW64
call %APPLI_DIR%\build.batch\Compil_link_CLANGMW64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_CLANGMW64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour DMC 32 bits
:DMC
call %APPLI_DIR%\build.batch\Compil_link_dmc_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_dmc_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour LCC 32 bits
:LCC32
call %APPLI_DIR%\build.batch\Compil_link_lcc32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_lcc32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour LCC 64 bits
:LCC64
call %APPLI_DIR%\build.batch\Compil_link_lcc64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_lcc64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour PellesC 32 bits
:PELLESC32
call %APPLI_DIR%\build.batch\Compil_link_pellesc32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_pellesc32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour PellesC 64 bits
:PELLESC64
call %APPLI_DIR%\build.batch\Compil_link_pellesc64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_pellesc64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch pour Open WATCOM 2.0 en version 32 bits
:WATCOM32
call %APPLI_DIR%\build.batch\Compil_link_OW32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_OW32_32b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration batch our Open WATCOM 2.0 en version 64 bits 
:WATCOM64
call %APPLI_DIR%\build.batch\Compil_link_OW64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Debug
call %APPLI_DIR%\build.batch\Compil_link_OW64_64b_windows.bat %APPLI_DIR% %NAME_APPLI% windows Release
 
:ARCHIVE
cd %APPLI_DIR%
del /Q *.7z *.tgz *.tar
REM "C:\CodeBlocks\cbp2make.exe" --locall -in $(project_dir)$(project_filename) -out makefile
@echo on
%PYTHON64% C:\src\tools\Size_exec.py %NAME_APPLI%
%PYTHON64% C:\src\tools\Calc_checksums.py %NAME_APPLI%
set mydate=%date%
set mytime=%time%
set DAY=%mydate:~0,2%
set MONTH=%mydate:~3,2%
set YEAR=%mydate:~6,4%
echo Current time is %mydate%:%mytime%
echo Jour : %DAY%
echo Mois : %MONTH%
echo Ann�e : %YEAR%
"C:\Program Files\7-Zip\7z" a %NAME_APPLI%_%YEAR%-%MONTH%-%DAY%_src.7z src\*.* res\*.* data\*.* build.cmake\* build.batch\* *.bat *.txt *.html *.md doxygen\* doc\* *.cbp *.workspace -x!*.bak -p"%NAME_APPLI%_tde"
"C:\Program Files\7-Zip\7z" a -ttar %NAME_APPLI%-%YEAR%-%MONTH%_%DAY%_all.tar * -x!*.7z x!*.bak -p"%NAME_APPLI%_tde"
"C:\Program Files\7-Zip\7z" a -tgzip %NAME_APPLI%_%YEAR%-%MONTH%-%DAY%_all.tgz *.tar
del /Q *.tar
GOTO FIN

:usage
echo Usage : %0 DIRECTORY_SRC NAME_APPLI [Id_Compilateur] 
echo   avec compilateur = [BCC|MINGW32OF|MINGW64CB|DEVCPP|CYGWIN32|CYGWIN64|MINGW32WL|MINGW64WL|TDM32|TDM64|MSYS2W32|MSYS2W64|NMAKEX32|NMAKEX64|VS2022X32|VS2022X64|CLANGX32|CLANGX64|CLANGW32|CLANGW64|CLANGMW32|CLANGMW64|DMC|LCC32|LCC64|PELLESC32|PELLESC64|WATCOM32|WATCOM64]
echo   et si pas de trois�me param�tre, g�n�ration de toutes les compilations avec les utilitaires "make" sp�cifiques � chaque cat�gorie de compilateurs (hors compilateur VS2022 car g�n�ration d'une solution)
 
:FIN
cd %DIRINIT%
