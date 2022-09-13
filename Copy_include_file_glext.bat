REM Copy all mandatory include file GLEXT défined by KRONOS GROUP for many compilers C/C++
REM BORLANDC 
copy glcorearb.h 	%BORLANDC%\include\gl\*
copy glext.h 		%BORLANDC%\include\gl\*
copy glxext.h		%BORLANDC%\include\gl\*
copy wglext.h 		%BORLANDC%\include\gl\*
mkdir 	%BORLANDC%\include\KHR
copy khrplatform.h 	%BORLANDC%\include\KHR\*
REM CYGWIN64 
copy glcorearb.h 	%CYGWIN64%\usr\include\gl\*
copy glext.h 		%CYGWIN64%\usr\include\gl\*
copy glxext.h		%CYGWIN64%\usr\include\gl\*
copy wglext.h 		%CYGWIN64%\usr\include\gl\*
mkdir 	%CYGWIN64%\usr\include\KHR
copy khrplatform.h 	%CYGWIN64%\usr\include\KHR\*
REM CODE::BLOCKS (Mingw64) 
copy glcorearb.h 	%CB%\MinGW\x86_64-w64-mingw32\include\GL\*
copy glext.h 		%CB%\MinGW\x86_64-w64-mingw32\include\GL\*
copy glxext.h		%CB%\MinGW\x86_64-w64-mingw32\include\GL\*
copy wglext.h 		%CB%\MinGW\x86_64-w64-mingw32\include\GL\*
mkdir 	%CB%\MinGW\x86_64-w64-mingw32\include\KHR
copy khrplatform.h 	%CB%\MinGW\x86_64-w64-mingw32\include\KHR\*
REM DEVCPP  -> EMBARCADERO  (TDM GCC64) 
copy glcorearb.h 	%DEVCPP%\TDM-GCC-64\x86_64-w64-mingw32\include\GL\*
copy glext.h 		%DEVCPP%\TDM-GCC-64\x86_64-w64-mingw32\include\GL\*
copy glxext.h		%DEVCPP%\TDM-GCC-64\x86_64-w64-mingw32\include\GL\*
copy wglext.h 		%DEVCPP%\TDM-GCC-64\x86_64-w64-mingw32\include\GL\*
mkdir 	%DEVCPP%\TDM-GCC-64\x86_64-w64-mingw32\include\KHR
copy khrplatform.h 	%DEVCPP%\MinGW\x86_64-w64-mingw32\include\KHR\*
REM LCC  
copy glcorearb.h 	%LCC%\include\gl\*
copy glext.h 		%LCC%\include\gl\*
copy glxext.h		%LCC%\include\gl\*
copy wglext.h 		%LCC%\include\gl\*
mkdir 	%LCC%\include\KHR
copy khrplatform.h 	%LCC%\include\KHR\*
REM LCC64  
copy glcorearb.h 	%LCC64%\include64\gl\*
copy glext.h 		%LCC64%\include64\gl\*
copy glxext.h		%LCC64%\include64\gl\*
copy wglext.h 		%LCC64%\include64\gl\*
mkdir 	%LCC64%\include64\KHR
copy khrplatform.h 	%LCC64%\include64\KHR\*
REM MinGW Official 
copy glcorearb.h 	%MINGW%\include\gl\*
copy glext.h 		%MINGW%\include\gl\*
copy glxext.h		%MINGW%\include\gl\*
copy wglext.h 		%MINGW%\include\gl\*
mkdir 	%MINGW%\include\KHR
copy khrplatform.h 	%MINGW%\include\KHR\*
REM MINGW32 (provenance WINLIBS) 
copy glcorearb.h 	%MINGW32%\i686-w64-mingw32\include\GL\*
copy glext.h 		%MINGW32%\i686-w64-mingw32\include\GL\*
copy glxext.h		%MINGW32%\i686-w64-mingw32\include\GL\*
copy wglext.h 		%MINGW32%\i686-w64-mingw32\include\GL\*
mkdir 	%MINGW32%\i686-w64-mingw32\include\KHR
copy khrplatform.h 	%MINGW32%\i686-w64-mingw32\include\KHR\*
REM MINGW32 avec un compilateur X64
copy glcorearb.h 	%MINGW32%\MinGW\x86_64-w64-mingw32\include\GL\*
copy glext.h 		%MINGW32%\MinGW\x86_64-w64-mingw32\include\GL\*
copy glxext.h		%MINGW32%\MinGW\x86_64-w64-mingw32\include\GL\*
copy wglext.h 		%MINGW32%\MinGW\x86_64-w64-mingw32\include\GL\*
mkdir 	%MINGW32%\MinGW\x86_64-w64-mingw32\include\KHR
copy khrplatform.h 	%MINGW32%\MinGW\x86_64-w64-mingw32\include\KHR\*
REM MINGW64 (provenance WINLIBS)
copy glcorearb.h 	%MINGW64%\x86_64-w64-mingw32\include\GL\*
copy glext.h 		%MINGW64%\x86_64-w64-mingw32\include\GL\*
copy glxext.h		%MINGW64%\x86_64-w64-mingw32\include\GL\*
copy wglext.h 		%MINGW64%\x86_64-w64-mingw32\include\GL\*
mkdir 	%MINGW64%\x86_64-w64-mingw32\include\KHR
copy khrplatform.h 	%MINGW64%\x86_64-w64-mingw32\include\KHR\*
REM MSYS264 avec Mingw32 
copy glcorearb.h 	%MSYS264%\mingw32\i686-w64-mingw32\include\GL\*
copy glext.h 		%MSYS264%\mingw32\i686-w64-mingw32\include\GL\*
copy glxext.h		%MSYS264%\mingw32\i686-w64-mingw32\include\GL\*
copy wglext.h 		%MSYS264%\mingw32\i686-w64-mingw32\include\GL\*
mkdir 	%MSYS264%\mingw32\i686-w64-mingw32\include\KHR
copy khrplatform.h 	%MSYS264%\mingw32\i686-w64-mingw32\include\KHR\*
REM MSYS264 avec Mingw64
copy glcorearb.h 	%MSYS264%\mingw64\x86_64-w64-mingw32\include\GL\*
copy glext.h 		%MSYS264%\mingw64\x86_64-w64-mingw32\include\GL\*
copy glxext.h		%MSYS264%\mingw64\x86_64-w64-mingw32\include\GL\*
copy wglext.h 		%MSYS264%\mingw64\x86_64-w64-mingw32\include\GL\*
mkdir 	%MSYS264%\mingw64\x86_64-w64-mingw32\include\KHR
copy khrplatform.h 	%MSYS264%\mingw64\x86_64-w64-mingw32\include\KHR\*
REM PELLESC 
copy glcorearb.h 	%PELLESC%\include\Win\gl\*
copy glext.h 		%PELLESC%\include\Win\gl\*
copy glxext.h		%PELLESC%\include\Win\gl\*
copy wglext.h 		%PELLESC%\include\Win\gl\*
mkdir 	%PELLESC%\include\Win\KHR
copy khrplatform.h 	%PELLESC%\include\Win\KHR\*
REM TDM-GCC-32 
copy glcorearb.h 	%TDM32%\include\GL\*
copy glext.h 		%TDM32%\include\GL\*
copy glxext.h		%TDM32%\include\GL\*
copy wglext.h 		%TDM32%\include\GL\*
mkdir 	%TDM32%\include\KHR
copy khrplatform.h 	%TDM32%\include\KHR\*
REM TDM-GCC-64
copy glcorearb.h 	%TDM64%\x86_64-w64-mingw32\include\GL\*
copy glext.h 		%TDM64%\x86_64-w64-mingw32\include\GL\*
copy glxext.h		%TDM64%\x86_64-w64-mingw32\include\GL\*
copy wglext.h 		%TDM64%\x86_64-w64-mingw32\include\GL\*
mkdir 	%TDM64%\x86_64-w64-mingw32\include\KHR
copy khrplatform.h 	%TDM64%\x86_64-w64-mingw32\include\KHR\*
REM SDK Windows 10 (Kits Windows)
copy glcorearb.h 	"%WDK%\Include\10.0.19041.0\um\gl\*"
copy glext.h 		"%WDK%\Include\10.0.19041.0\um\gl\*"
copy glxext.h		"%WDK%\Include\10.0.19041.0\um\gl\*"
copy wglext.h 		"%WDK%\Include\10.0.19041.0\um\gl\*"
mkdir 	"%WDK%\Include\10.0.19041.0\um\KHR"
copy khrplatform.h 	"%WDK%\Include\10.0.19041.0\um\KHR\*"
REM Watcom 
copy glcorearb.h 	%WATCOM%\h\nt\GL\*
copy glext.h 		%WATCOM%\h\nt\GL\*
copy glxext.h		%WATCOM%\h\nt\GL\*
copy wglext.h 		%WATCOM%\h\nt\GL\*
mkdir 	%WATCOM%\h\nt\KHR
copy khrplatform.h 	%WATCOM%\h\nt\KHR\*