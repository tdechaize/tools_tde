@echo off
REM ---------------------------------------------------------------------------------------------------
REM
REM		 generate_all_with_cmake.bat : 	Nom de ce batch  
REM
REM      Batch de lancement de toutes les g�n�rations d'une application Windows (source C avec un fichier resource) 
REM    avec l'utilitaire CMAKE, on d'une seule g�n�ration, si le deuxi�me param�tre fait partie de la liste suivante :
REM    
REM          [BCC|MINGW32OF|MINGW64CB|DEVCPP|CYGWIN32|CYGWIN64|MINGW32WL|MINGW64WL|TDM32|TDM64|MSYS2W32|MSYS2W64|NMAKEX32|NMAKEX64|VS2022X32|VS2022X64|CLANGX32|CLANGX64|CLANGW32|CLANGW64|CLANGMW32|CLANGMW64|DMC|LCC32|LCC64|PELLESC32|PELLESC64|WATCOM32|WATCOM64] 
REM
REM     Dans les grands principes, il y a un fichier CMAKELists.txt diff�rent pour chaque cat�gorie de compilateurs stock� sous build.cmake\"Id du Compilateur"
REM     qu'il faut recopier syst�matiquemet sur le r�pertoire des sources de l'application (le 1er param�tre). C'est une "obligation" cmake --fresh ...
REM     Ensuite, une fois copi� dans ce r�pertoire, et apr�s un m�nage dans les r�pertoires utiles � cmake --fresh (pr�caution), il n'y a plus qu'� g�n�rer les Makefile "ad hoc" avec l'aide 
REM     de l'utilitaire cmake (dont l'ex�cutable doit �tre accessible dans le PATH !). 
REM     Pour terminer, il faut ensuite g�n�rer l'application attendue par l'ex�cution de chacun de ces Makefile, l� aussi avec le bon g�n�rateur "make" de chaque compilateur,
REM     et pour chacune des versions Debug et Release.
REM     Il faut bien etendu, positionner pour chaque compilateur les variables d'environnement PATH, et parfois LIB et INCLUDE, le fichier CMAKELists.txt s'occupe du reste (et ce n'est pas rien !),
REM     c'est la raison pour laquelle, je r�cup�re la variable d'environnement PATH initiale (dans PATHSAV) pour y revenir � la fin de chaque g�n�ration.  
REM     Une exception pour l'IDE VS2022, cmake est capable de g�n�rer directement une solution pour cet environnement (un fichier permetant la g�n�ration via l'IDE ou l'utilitaire MSBUILD).
REM     Points d'attention, j'ai positionn� des variables d'environnement sous Windows (en mode "syst�me") pour g�rer les diff�rentes versions de Visual Studio, du KIT WINDOWS et de CLANG installees :
REM          CLANG_VERSION     valu� (� date) par       14.0.6     		(derni�re version sur Windows 11, aussi bien pour les binaires valables pour VS2022 que pour les environnements Mingw et MSYS)
REM          VS_VERSION        valu� (� date) par       2022       		(derni�re version sur Windows 11)
REM          VS_NUM            valu� (� date) par       14.33.31629     (derni�re version sur Windows 11)
REM          KIT_WIN_VERSION   valu� (� date) par       10    			(derni�re version sur Windows 11)
REM          KIT_WIN_NUM       valu� (� date) par       10.0.22621.0    (derni�re version sur Windows 11)
REM		Je les utilise dans les fichiers CMAKELists.txt, soit avec la fonction de traduction cmake $env{var], soit si c'est une variable positionn�e pour les utilitaires des compilateurs 
REM 	par l'op�rateur de traduction %var% des fichiers de commandes Windows. Petite subtilit� !!!
REM     Et pour les trois compilateurs, non support�s par CMAKE (LCC, PellesC et Open WATCOM : pas de g�n�rateur fourni), j'utilise un simple Makefile. 
REM		Mais, comme il y a peu de latitudes avec les diff�rents "make" de ces compilateurs, j'ai pris l'option de cr�er un Makefile diff�rent pour les g�n�rations Release et Debug.
REM
REM 	PS : la proc�dure "create_dir.bat" permet de cr�er TOUS les r�pertoires utiles � ces g�n�rations multiples (certains compilateurs ne sont pas caapbles de les cr�er ONLINE s'ils sont absents),
REM          et ensuite on lance generate_all_with_cmake.bat "nom_r�pertoire" "nom_appli" [id_generator].
REM 
REM 	AUTHOR : 						Thierry DECHAIZE
REM     Date de cr�ation :				2 ao�t 2022   
REM 	Date derni�re modification : 	7 septembre 2022   -> adjonction d'un deuxi�me param�tre recup�r� dans la variable %NAME_APPLI% pour augmenter le param�trage de ce script.
REM 	D�tails des modifications : 	Ce deuxi�me param�tre d�cale par cons�quent le troisi�me (toujours optionnel) qui continue de servir de choix du g�n�rateur/compilateur souhait� pour tests.
REM 	Version de ce script :			1.1.4  ->  "Version majeure" . "Version mineure" . "niveau de patch"
REM
REM ---------------------------------------------------------------------------------------------------
  
if [%1]==[] goto usage
if not exist %1\ goto usage
@echo on
echo "Directory des sources : %1"
echo "Nom de l'application  : %2"

@echo off
set DIRINIT=%CD%
SET PATHSAV=%PATH%
set SOURCE_DIR=%1
set NAME_APPLI=%2
cd %SOURCE_DIR%
 
:SUITE
if "%3" NEQ "" goto %3

REM             G�n�ration make pour le compilateur Borland C/C++ 5.51 
:BCC
SET PATH=C:\BCC55\bin;%PATH%
del /Q makefile_Borland.mak
copy build.cmake\BC55\makefile_Borland.mak *.*
make -DCFG=Debug -DNAME_APPLI=%NAME_APPLI% /f MakeFile_Borland.mak 
move /Y *.exe binBC55\Debug\
move /Y *.map binBC55\Debug\
move /Y *.tds binBC55\Debug\
move /Y *.obj objBC55\Debug\
move /Y *.res objBC55\Debug\
make -DCFG=Release -DNAME_APPLI=%NAME_APPLI% /f MakeFile_Borland.mak 
move /Y *.exe binBC55\Release\
move /Y *.map binBC55\Release\
move /Y *.tds binBC55\Release\
move /Y *.obj objBC55\Release\
move /Y *.res objBC55\Release\
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
del /Q makefile_Borland.mak
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake --fresh pour GCC 9.2.0 int�gr� � MINGW32 (version officielle)
:MINGW32OF
SET PATH=C:\MinGW\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\MINGW32OF\CMAKELists.txt *.*
cmake --fresh -G "MinGW Makefiles" -B build.cmake/MINGW32OF/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MinGW Makefiles" -B build.cmake/MINGW32OF/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\MINGW32OF\Debug
mingw32-make . all
cd ..
cd Release
mingw32-make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour GCC 3.4.5 int�gr� � Dev-Panda 4.9.9.2  (Dev-Cpp n'est plus maintenu)
:DEVCPP
SET PATH=C:\Program Files\RedPanda-Cpp\MinGW64\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\DEVCPP\CMAKELists.txt *.*
cmake --fresh -G "MinGW Makefiles" -B build.cmake/DEVCPP/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MinGW Makefiles" -B build.cmake/DEVCPP/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\DEVCPP\Debug
mingw32-make . all
cd ..
cd Release
mingw32-make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake --fresh pour GCC 8.1.0 int�gr� � l'environnement IDE Code::Blocks
:MINGW64CB
SET PATH=C:\CodeBlocks\MinGW\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\MINGW64CB\CMAKELists.txt *.*
cmake --fresh -G "MinGW Makefiles" -B build.cmake/MINGW64CB/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MinGW Makefiles" -B build.cmake/MINGW64CB/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\MINGW64CB\Debug
mingw32-make . all
cd ..
cd Release
mingw32-make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour GCC 12.1.0 int�gr� � l'environnement CYGWIN 32 bits
:CYGWIN32
SET PATH=C:\Program Files\CMake\bin;C:\cygwin64\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\CYGWIN32\CMAKELists.txt *.*
del /Q build.cmake\CYGWIN32\Debug\*.*
del /Q build.cmake\CYGWIN32\Release\*.*
cmake --fresh -G "Unix Makefiles" -B build.cmake/CYGWIN32/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "Unix Makefiles" -B build.cmake/CYGWIN32/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\CYGWIN32\Debug
make . all
cd ..
cd Release
make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour GCC 12.1.0 int�gr� � l'environnement CYGWIN 64 bits
:CYGWIN64
SET PATH=C:\Program Files\CMake\bin;C:\cygwin64\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\CYGWIN64\CMAKELists.txt *.*
del /Q build.cmake\CYGWIN64\Debug\*.*
del /Q build.cmake\CYGWIN64\Release\*.*
cmake --fresh -G "Unix Makefiles" -B build.cmake/CYGWIN64/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "Unix Makefiles" -B build.cmake/CYGWIN64/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\CYGWIN64\Debug
make . all
cd ..
cd Release
make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour GCC 12.1.0 int�gr� � l'environnement WINLIBS 32 bits
:MINGW32WL
SET PATH=C:\mingw32\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\MINGW32WL\CMAKELists.txt *.*
cmake --fresh -G "MinGW Makefiles" -B build.cmake/MINGW32WL/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MinGW Makefiles" -B build.cmake/MINGW32WL/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\MINGW32WL\Debug
mingw32-make . all
cd ..
cd Release
mingw32-make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour GCC 12.1.0 int�gr� � l'environnement WINLIBS 64 bits
:MINGW64WL
SET PATH=C:\mingw64\bin;%PATH%
del /Q  CMAKELists.txt
copy build.cmake\MINGW64WL\CMAKELists.txt *.*
cmake --fresh -G "MinGW Makefiles" -B build.cmake/MINGW64WL/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MinGW Makefiles" -B build.cmake/MINGW64WL/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\MINGW64WL\Debug
mingw32-make . all
cd ..
cd Release
mingw32-make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour GCC 12.1.0 int�gr� � l'environnement MSYS2 en 32 bits
:MSYS2W32
set PATH=C:\Program Files\CMake\bin;C:\msys64\mingw32\bin;C:\msys64\usr\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\MSYS2W32\CMAKELists.txt *.*
cmake --fresh -G "MSYS Makefiles" -B build.cmake/MSYS2W32/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MSYS Makefiles" -B build.cmake/MSYS2W32/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\MSYS2W32\Debug
make . all
cd ..
cd Release
make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour GCC 12.1.0 int�gr� � l'environnement MSYS2 en 64 bits
:MSYS2W64
set PATH=C:\Program Files\CMake\bin;C:\msys64\mingw64\bin;C:\msys64\usr\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\MSYS2W64\CMAKELists.txt *.*
cmake --fresh -G "MSYS Makefiles" -B build.cmake/MSYS2W64/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MSYS Makefiles" -B build.cmake/MSYS2W64/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\MSYS2W64\Debug
make . all
cd ..
cd Release
make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour GCC 10.3.0 int�gr� � l'environnement TDM 32 bits
:TDM32
set PATH=C:\TDM-GCC-32\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\TDM32\CMAKELists.txt *.*
cmake --fresh -G "MinGW Makefiles" -B build.cmake/TDM32/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MinGW Makefiles" -B build.cmake/TDM32/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\TDM32\Debug
mingw32-make . all
cd ..
cd Release
mingw32-make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour GCC 10.3.0 int�gr� � l'environnement TDM 64 bits
:TDM64
set PATH=C:\TDM-GCC-64\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\TDM64\CMAKELists.txt *.*
cmake --fresh -G "MinGW Makefiles" -B build.cmake/TDM64/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MinGW Makefiles" -B build.cmake/TDM64/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\TDM64\Debug
mingw32-make . all
cd ..
cd Release
mingw32-make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour NMAKE en version 32 BITS
:NMAKEX32 
SET PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\bin\Hostx86\x86;C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\bin\%KIT_WIN_NUM%\x86;%PATH%
SET PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\Msbuild\Current\Bin;%PATH%
set INCLUDE="C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\shared";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\ucrt";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\um";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\include"
set LIB="C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Lib\%KIT_WIN_NUM%\ucrt\x86";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Lib\%KIT_WIN_NUM%\um\x86";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\lib\x86";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\lib\x86\store"
del /Q CMAKELists.txt
copy build.cmake\NmakeX32\CMAKELists.txt *.*
cmake --fresh -G "NMake Makefiles" -B build.cmake/NmakeX32/Debug -DCMAKE_BUILD_TYPE="Debug" -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "NMake Makefiles" -B build.cmake/NmakeX32/Release -DCMAKE_BUILD_TYPE="Release" -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\NmakeX32\Debug
nmake /f Makefile
cd ..
cd Release
nmake /f Makefile
set INCLUDE=
set LIB=
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour NMAKE en version 64 BITS
:NMAKEX64 
SET PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\bin\Hostx64\x64;C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\bin\%KIT_WIN_NUM%\x64;%PATH%
SET PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\Msbuild\Current\Bin\amd64;%PATH%
set INCLUDE="C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\shared";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\ucrt";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\um";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\include"
set LIB="C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Lib\%KIT_WIN_NUM%\ucrt\x64";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Lib\%KIT_WIN_NUM%\um\x64";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\lib\x64";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\lib\x64\store"
del /Q CMAKELists.txt
copy build.cmake\NmakeX64\CMAKELists.txt *.*
cmake --fresh -G "NMake Makefiles" -B build.cmake/NmakeX64/Debug -DCMAKE_BUILD_TYPE="Debug" -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "NMake Makefiles" -B build.cmake/NmakeX64/Release -DCMAKE_BUILD_TYPE="Release" -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\NmakeX64\Debug
nmake /f Makefile
cd ..
cd Release
nmake /f Makefile
set INCLUDE=
set LIB=
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour Visual Studio 2022 en version 32 BITS
:VS2022X32 
SET PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\bin\Hostx86\x86;C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\bin\%KIT_WIN_NUM%\x86;%PATH%
SET PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\Msbuild\Current\Bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\VS2022X32\CMAKELists.txt *.*
cmake --fresh -G "Visual Studio 17 2022" -B build.cmake/VS2022X32 -A Win32 -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\VS2022X32
msbuild %NAME_APPLI%.sln -m -target:%NAME_APPLI%:rebuild /p:Configuration=Debug /p:Platform=Win32
msbuild %NAME_APPLI%.sln -m -target:%NAME_APPLI%:rebuild /p:Configuration=MinSizeRel /p:Platform=Win32
msbuild %NAME_APPLI%.sln -m -target:%NAME_APPLI%:rebuild /p:Configuration=Release /p:Platform=Win32
msbuild %NAME_APPLI%.sln -m -target:%NAME_APPLI%:rebuild /p:Configuration=RelWithDebInfo /p:Platform=Win32
cd %SOURCE_DIR%
copy CMAKELists.txt build.cmake\VS2022X32\*.*
SET INCLUDE=
SET LIB=
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour Visual Studio 2022 en version 64 BITS
:VS2022X64 
SET PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\bin\Hostx64\x64;C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\bin\%KIT_WIN_NUM%\x64;%PATH%
SET PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\Msbuild\Current\Bin\amd64;%PATH%
del /Q CMAKELists.txt
copy build.cmake\VS2022X64\CMAKELists.txt *.*
cmake --fresh -G "Visual Studio 17 2022" -B build.cmake/VS2022X64 -A x64 -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\VS2022X64
msbuild %NAME_APPLI%.sln -m -target:%NAME_APPLI%:rebuild /p:Configuration=Debug /p:Platform=x64
msbuild %NAME_APPLI%.sln -m -target:%NAME_APPLI%:rebuild /p:Configuration=MinSizeRel /p:Platform=x64
msbuild %NAME_APPLI%.sln -m -target:%NAME_APPLI%:rebuild /p:Configuration=Release /p:Platform=x64
msbuild %NAME_APPLI%.sln -m -target:%NAME_APPLI%:rebuild /p:Configuration=RelWithDebInfo /p:Platform=x64
cd %SOURCE_DIR%
copy CMAKELists.txt build.cmake\VS2022X64\*.*
SET INCLUDE=
SET LIB=
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour CLANG en version 32 BITS adoss� � Visual Studio 2022 
:CLANGX32 
SET PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\bin\Hostx86\x86;C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\bin\%KIT_WIN_NUM%\x86;%PATH%
SET PATH=%LLVM%\bin;C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\Msbuild\Current\Bin;%PATH%
setx INCLUDE "%LLVM%\lib\clang\%CLANG_VERSION%\include";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\shared";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\ucrt";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\um";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\include"
setx LIB "%LLVM%\lib\clang\%CLANG_VERSION%\lib\windows";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Lib\%KIT_WIN_NUM%\ucrt\x86";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Lib\%KIT_WIN_NUM%\um\x86";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\lib\x86";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\lib\x86\store"
del /Q CMAKELists.txt
copy build.cmake\CLANGX32\CMAKELists.txt *.*
cmake --fresh -G "NMake Makefiles" -B build.cmake/CLANGX32/Debug -DCMAKE_BUILD_TYPE="Debug" -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "NMake Makefiles" -B build.cmake/CLANGX32/Release -DCMAKE_BUILD_TYPE="Release" -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\CLANGX32\Debug
nmake /f Makefile
cd ..
cd Release
nmake /f Makefile
reg delete HKCU\Environment /v INCLUDE /f 
reg delete HKCU\Environment /v LIB /f 
SET INCLUDE=
SET LIB=
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour CLANG en version 64 BITS adoss� � Visual Studio 2022 
:CLANGX64 
SET PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\bin\Hostx64\x64;C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\bin\%KIT_WIN_NUM%\x64;%PATH%
SET PATH=%LLVM64%\bin;C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\Msbuild\Current\Bin\amd64;%PATH%
setx INCLUDE "%LLVM64%\lib\clang\%CLANG_VERSION%\include";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\shared";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\ucrt";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Include\%KIT_WIN_NUM%\um";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\include"
setx LIB "%LLVM64%\lib\clang\%CLANG_VERSION%\lib\windows";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Lib\%KIT_WIN_NUM%\ucrt\x64";"C:\Program Files (x86)\Windows Kits\%KIT_WIN_VERSION%\Lib\%KIT_WIN_NUM%\um\x64";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\lib\x64";"C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Tools\MSVC\%VS_NUM%\lib\x64\store"
del /Q CMAKELists.txt
copy build.cmake\CLANGX64\CMAKELists.txt *.*
cmake --fresh -G "NMake Makefiles" -B build.cmake/CLANGX64/Debug -DCMAKE_BUILD_TYPE="Debug" -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "NMake Makefiles" -B build.cmake/CLANGX64/Release -DCMAKE_BUILD_TYPE="Release" -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\CLANGX64\Debug
nmake /f Makefile
cd ..
cd Release
nmake /f Makefile
reg delete HKCU\Environment /v INCLUDE /f 
reg delete HKCU\Environment /v LIB /f 
SET INCLUDE=
SET LIB=
cd %SOURCE_DIR%
del /Q CMAKELists.txt
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour CLANG MINGW GNU/GCC en version 32 bits
:CLANGW32
set PATH=C:\mingw32\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\CLANGW32\CMAKELists.txt *.*
cmake --fresh -G "MinGW Makefiles" -B build.cmake/CLANGW32/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MinGW Makefiles" -B build.cmake/CLANGW32/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\CLANGW32\Debug
mingw32-make . all
cd ..
cd Release
mingw32-make . all
cd %SOURCE_DIR%
del /Q CMAKELists.txt
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour CLANG MINGW GNU/GCC en version 64 bits
:CLANGW64
set PATH=C:\mingw64\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\CLANGW64\CMAKELists.txt *.*
cmake --fresh -G "MinGW Makefiles" -B build.cmake/CLANGW64/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MinGW Makefiles" -B build.cmake/CLANGW64/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\CLANGW64\Debug
mingw32-make . all
cd ..
cd Release
mingw32-make . all
cd %SOURCE_DIR%
del /Q CMAKELists.txt
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour CLANG MSYS2 GNU/GCC en version 32 bits
:CLANGMW32
set PATH=C:\msys64\mingw32\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\CLANGMW32\CMAKELists.txt *.*
cmake --fresh -G "MinGW Makefiles" -B build.cmake/CLANGMW32/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MinGW Makefiles" -B build.cmake/CLANGMW32/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\CLANGMW32\Debug
mingw32-make . all
cd ..
cd Release
mingw32-make . all
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
del /Q CMAKELists.txt
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration cmake pour CLANG MSYS2 GNU/GCC en version 64 bits
:CLANGMW64
set PATH=C:\msys64\mingw64\bin;%PATH%
del /Q CMAKELists.txt
copy build.cmake\CLANGMW64\CMAKELists.txt *.*
cmake --fresh -G "MinGW Makefiles" -B build.cmake/CLANGMW64/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "MinGW Makefiles" -B build.cmake/CLANGMW64/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake\CLANGMW64\Debug
mingw32-make . all
cd ..
cd Release
mingw32-make . all
SET INCLUDE=
SET LIB=
cd %SOURCE_DIR%
del /Q CMAKELists.txt
SET PATH=%PATHSAV%
IF "%3" NEQ "" GOTO FIN

REM             ATTENTION, pour les trois compilateurs Digital Mars, LCC et PellesC, 
REM             il n'y a pas de g�n�rateur CMAKE, donc nous n'utiliserons qu'une g�n�ration 
REM             en mode "make" classique. (idem pour Open WATCOM car bug CMAKE avec fichier de ressource)

REM             G�n�ration make pour LCC 32 bits
:DMC
SET PATH=C:\dm\bin;%PATH%
del /Q makefile_dmc_debug.mak makefile_dmc_release.mak
copy build.cmake\dmc\Debug\makefile_dmc_debug.mak *.*
copy build.cmake\dmc\Release\makefile_dmc_release.mak *.*
make -fmakefile_dmc_debug.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binDMC\Debug\
move /Y *.obj objDMC\Debug\
move /Y *.res objDMC\Debug\
make -fmakefile_dmc_release.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binDMC\Release\
move /Y *.obj objDMC\Release\
move /Y *.res objDMC\Release\
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
del /Q makefile_dmc_debug.mak makefile_dmc_release.mak
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration make --fresh pour LCC 32 bits
:LCC32
SET PATH=C:\lcc\bin;%PATH%
del /Q makefile_lcc32_debug.mak makefile_lcc32_release.mak
copy build.cmake\lcc32\Debug\makefile_lcc32_debug.mak *.*
copy build.cmake\lcc32\Release\makefile_lcc32_release.mak *.*
make -f makefile_lcc32_debug.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binlcc32\Debug\
move /Y *.obj objlcc32\Debug\
move /Y *.res objlcc32\Debug\
make -f makefile_lcc32_release.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binlcc32\Release\
move /Y *.obj objlcc32\Release\
move /Y *.res objlcc32\Release\
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
del /Q makefile_lcc32_debug.mak makefile_lcc32_release.mak
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration make pour LCC 64 bits
:LCC64
SET PATH=C:\lcc64\bin;%PATH%
del /Q makefile_lcc64_debug.mak makefile_lcc64_release.mak
copy build.cmake\lcc64\Debug\makefile_lcc64_debug.mak *.*
copy build.cmake\lcc64\Release\makefile_lcc64_release.mak *.*
make64 -f makefile_lcc64_debug.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binlcc64\Debug\
move /Y *.obj objlcc64\Debug\
move /Y *.res objlcc64\Debug\
make64 -f makefile_lcc64_release.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binlcc64\Release\
move /Y *.obj objlcc64\Release\
move /Y *.res objlcc64\Release\
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
del /Q makefile_lcc64_debug.mak makefile_lcc64_release.mak
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration make pour PellesC 32 bits
:PELLESC32
SET PATH=C:\PellesC\bin;%PATH%
del /Q makefile_pellesc_debug.mak makefile_pellesc_release.mak
copy build.cmake\pellesC32\Debug\makefile_pellesC_debug.mak *.*
copy build.cmake\pellesC32\Release\makefile_pellesC_release.mak *.*
pomake /F makefile_pellesc_debug.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binpellesc32\Debug\
move /Y *.obj objpellesc32\Debug\
move /Y *.res objpellesc32\Debug\
pomake /F makefile_pellesc_release.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binpellesc32\Release\
move /Y *.obj objpellesc32\Release\
move /Y *.res objpellesc32\Release\
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
del /Q makefile_pellesc_debug.mak makefile_pellesc_release.mak
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration make pour PellesC 64 bits
:PELLESC64
SET PATH=C:\PellesC\bin;%PATH%
del /Q makefile_pellesc64_debug.mak makefile_pellesc64_release.mak
copy build.cmake\pellesc64\Debug\makefile_pellesc64_debug.mak *.*
copy build.cmake\pellesc64\Release\makefile_pellesc64_release.mak *.*
pomake /F makefile_pellesc64_debug.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binpellesc64\Debug\
move /Y *.obj objpellesc64\Debug\
move /Y *.res objpellesc64\Debug\
pomake /F makefile_pellesc64_release.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binpellesc64\Release\
move /Y *.obj objpellesc64\Release\
move /Y *.res objpellesc64\Release\
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
del /Q makefile_pellesc64_debug.mak makefile_pellesc64_release.mak
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration wmake pour Open WATCOM 2.0 en version 32 bits (bug with Cmake, compilation du fichier resource non trait� !!!)
:WATCOM32
SET PATH=C:\WATCOM\binnt;%PATH%
del /Q makefile_OW32_debug.mak makefile_OW32_release.mak
copy build.cmake\OW32\Debug\makefile_OW32_debug.mak *.*
copy build.cmake\OW32\Release\makefile_OW32_release.mak *.*
wmake -f makefile_OW32_debug.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binOW32\Debug\
move /Y *.obj objOW32\Debug\
move /Y *.res objOW32\Debug\
wmake -f makefile_OW32_release.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binOW32\Release\
move /Y *.obj objOW32\Release\
move /Y *.res objOW32\Release\
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
del /Q makefile_OW32_debug.mak makefile_OW32_release.mak
IF "%3" NEQ "" GOTO FIN

REM             G�n�ration wmake pour Open WATCOM 2.0 en version 64 bits (bug with Cmake, compilation du fichier resource non trait� !!!)
:WATCOM64
SET PATH=C:\WATCOM\binnt64;%PATH%
del /Q makefile_OW64_debug.mak makefile_OW64_release.mak
copy build.cmake\OW64\Debug\makefile_OW64_debug.mak *.*
copy build.cmake\OW64\Release\makefile_OW64_release.mak *.*
wmake -f makefile_OW64_debug.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binOW64\Debug\
move /Y *.obj objOW64\Debug\
move /Y *.res objOW64\Debug\
wmake -f makefile_OW64_release.mak NAME_APPLI=%NAME_APPLI%
move /Y *.exe binOW64\Release\
move /Y *.obj objOW64\Release\
move /Y *.res objOW64\Release\
SET INCLUDE=
SET LIB=
cd %SOURCE_DIR%
SET PATH=%PATHSAV%
del /Q makefile_OW64_debug.mak makefile_OW64_release.mak
GOTO ARCHIVE 

REM             G�n�ration cmake pour Open WATCOM 2.0 (buggy with resource file with CMAKE !!!)
:WATCOM
SET PATH=C:\WATCOM\binnt;%PATH%
del /Q CMAKELists.txt
copy build.cmake\OW32\CMAKELists.txt *.*
cmake --fresh -G "Watcom WMake" -B build.cmake/OW32/Debug -DCMAKE_BUILD_TYPE=Debug -DNAME_APPLI=%NAME_APPLI% .
cmake --fresh -G "Watcom WMake" -B build.cmake/OW32/Release -DCMAKE_BUILD_TYPE=Release -DNAME_APPLI=%NAME_APPLI% .
cd build.cmake/OW32/Debug
wmake -a -v
cd ..
cd Release
wmake -a -v
cd %SOURCE_DIR%
SET PATH=%PATHSAV%

:ARCHIVE
del /Q *.7z *.tgz *.tar
REM "C:\CodeBlocks\cbp2make.exe" --local -in $(project_dir)$(project_filename) -out makefile
@echo on
%PYTHON64% ..\..\tools\Size_exec.py %NAME_APPLI%
%PYTHON64% ..\..\tools\Calc_checksums.py %NAME_APPLI%
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
echo Usage : %0 DIRECTORY_SAPPLI NAME_APPLI [Compilateur] 
echo   avec compilateur = [BCC|MINGW32OF|MINGW64CB|DEVCPP|CYGWIN32|CYGWIN64|MINGW32WL|MINGW64WL|TDM32|TDM64|MSYS2W32|MSYS2W64|NMAKEX32|NMAKEX64|VS2022X32|VS2022X64|CLANGX32|CLANGX64|CLANGW32|CLANGW64|CLANGMW32|CLANGMW64|DMC|LCC32|LCC64|PELLESC32|PELLESC64|WATCOM32|WATCOM64]
echo   et si pas de deuxi�me param�tre, g�n�ration de toutes les compilations avec les utilitaires "make" sp�cifiques � chaque cat�gorie de compilateurs (hors compilateur VS2022 car g�n�ration d'une solution)
 
:FIN
cd %DIRINIT%
