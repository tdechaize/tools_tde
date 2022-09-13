import os, builtins, sys, time

def convert_bytes(num):
    """
    this function will convert bytes to MB.... GB... etc
    """
    for x in ['bytes', 'KB', 'MB', 'GB', 'TB']:
        if num < 1024.0:
            return "%3.1f %s" % (num, x)
        num /= 1024.0

def file_size(file_path):
    """
    this function will return the file size
    """
    file_info = os.stat(file_path)
    taille = convert_bytes(file_info.st_size)
    if 'BC55' in file_path and 'Debug' in file_path:
        return "  Debug Borland C/C++ :      %s" % taille
    if 'BC55' in file_path and 'Release' in file_path:
        return "  Release Borland C/C++ :    %s" % taille
    if 'CLANGMW32' in file_path and 'Debug' in file_path:
        return "  Debug CLANG MSYS W32 :     %s" % taille
    if 'CLANGMW32' in file_path and 'Release' in file_path:
        return "  Release CLANG MSYS W32 :   %s" % taille
    if 'CLANGMW64' in file_path and 'Debug' in file_path:
        return "  Debug CLANG MSYS W64 :     %s" % taille
    if 'CLANGMW64' in file_path and 'Release' in file_path:
        return "  Release CLANG MSYS W64 :   %s" % taille
    if 'CLANGW32' in file_path and 'Debug' in file_path:
        return "  Debug CLANG Mingw32 :      %s" % taille
    if 'CLANGW32' in file_path and 'Release' in file_path:
        return "  Release CLANG Mingw32 :    %s" % taille
    if 'CLANGW64' in file_path and 'Debug' in file_path:
        return "  Debug CLANG Mingw64 :      %s" % taille
    if 'CLANGW64' in file_path and 'Release' in file_path:
        return "  Release CLANG Mingw64 :    %s" % taille
    if 'CLANGX32' in file_path and 'Debug' in file_path:
        return "  Debug CLANG VS2022 32 :    %s" % taille
    if 'CLANGX32' in file_path and 'Release' in file_path:
        return "  Release CLANG VS2022 32 :  %s" % taille
    if 'CLANGX64' in file_path and 'Debug' in file_path:
        return "  Debug CLANG VS2022 64 :    %s" % taille
    if 'CLANGX64' in file_path and 'Release' in file_path:
        return "  Release CLANG VS2022 64 :  %s" % taille
    if 'CYGWIN32' in file_path and 'Debug' in file_path:
        return "  Debug Cygwin 32 :          %s" % taille
    if 'CYGWIN32' in file_path and 'Release' in file_path:
        return "  Release Cygwin 32 :        %s" % taille
    if 'CYGWIN64' in file_path and 'Debug' in file_path:
        return "  Debug Cygwin 64 :          %s" % taille
    if 'CYGWIN64' in file_path and 'Release' in file_path:
        return "  Release Cygwin 64 :        %s" % taille
    if 'DevCpp' in file_path and 'Debug' in file_path:
        return "  Debug Mingw64 CPP :        %s" % taille
    if 'DevCpp' in file_path and 'Release' in file_path:
        return "  Release Mingw64 CPP :      %s" % taille
    if 'DMC' in file_path and 'Debug' in file_path:
        return "  Debug DMC 32 :             %s" % taille
    if 'DMC' in file_path and 'Release' in file_path:
        return "  Release DMC 32 :           %s" % taille
    if 'lcc32' in file_path and 'Debug' in file_path:
        return "  Debug lcc 32 :             %s" % taille
    if 'lcc32' in file_path and 'Release' in file_path:
        return "  Release lcc 32 :           %s" % taille
    if 'lcc64' in file_path and 'Debug' in file_path:
        return "  Debug lcc 64 :             %s" % taille
    if 'lcc64' in file_path and 'Release' in file_path:
        return "  Release lcc 64 :           %s" % taille
    if 'Mingw32of' in file_path and 'Debug' in file_path:
        return "  Debug Mingw32 officiel :   %s" % taille
    if 'Mingw32of' in file_path and 'Release' in file_path:
        return "  Release Mingw32 officiel : %s" % taille
    if 'Mingw32wl' in file_path and 'Debug' in file_path:
        return "  Debug Mingw32 WinLibs :    %s" % taille
    if 'Mingw32wl' in file_path and 'Release' in file_path:
        return "  Release Mingw32 WinLibs :  %s" % taille
    if 'Mingw64wl' in file_path and 'Debug' in file_path:
        return "  Debug Mingw64 WinLibs :    %s" % taille
    if 'Mingw64wl' in file_path and 'Release' in file_path:
        return "  Release Mingw64 WinLibs :  %s" % taille
    if 'Mingw64CB' in file_path and 'Debug' in file_path:
        return "  Debug Mingw64 CB :         %s" % taille
    if 'Mingw64CB' in file_path and 'Release' in file_path:
        return "  Release Mingw64 CB :       %s" % taille
    if 'MSYS2W32' in file_path and 'Debug' in file_path:
        return "  Debug Mingw32 MSYS2 :      %s" % taille
    if 'MSYS2W32' in file_path and 'Release' in file_path:
        return "  Release Mingw32 MSYS2 :    %s" % taille
    if 'MSYS2W64' in file_path and 'Debug' in file_path:
        return "  Debug Mingw64 MSYS2 :      %s" % taille
    if 'MSYS2W64' in file_path and 'Release' in file_path:
        return "  Release Mingw64 MSYS2 :    %s" % taille
    if 'OW32' in file_path and 'Debug' in file_path:
        return "  Debug OpenWatcom 32 :      %s" % taille
    if 'OW32' in file_path and 'Release' in file_path:
        return "  Release OpenWatcom 32 :    %s" % taille
    if 'OW64' in file_path and 'Debug' in file_path:
        return "  Debug OpenWatcom 64 :      %s" % taille
    if 'OW64' in file_path and 'Release' in file_path:
        return "  Release OpenWatcom 64 :    %s" % taille
    if 'PELLESC32' in file_path and 'Debug' in file_path:
        return "  Debug Pelles C 32 :        %s" % taille
    if 'PELLESC32' in file_path and 'Release' in file_path:
        return "  Release Pelles C 32 :      %s" % taille
    if 'PELLESC64' in file_path and 'Debug' in file_path:
        return "  Debug Pelles C 64 :        %s" % taille
    if 'PELLESC64' in file_path and 'Release' in file_path:
        return "  Release Pelles C 64 :      %s" % taille
    if 'TDMW32' in file_path and 'Debug' in file_path:
        return "  Debug TDM Mingw32 :        %s" % taille
    if 'TDMW32' in file_path and 'Release' in file_path:
        return "  Release TDM Mingw32 :      %s" % taille
    if 'TDMW64' in file_path and 'Debug' in file_path:
        return "  Debug TDM Mingw64 :        %s" % taille
    if 'TDMW64' in file_path and 'Release' in file_path:
        return "  Release TDM Mingw64 :      %s" % taille
    if 'VS2022X32' in file_path and 'Debug' in file_path:
        return "  Debug VS 2022 32 :         %s" % taille
    if 'VS2022X32' in file_path and 'Release' in file_path:
        return "  Release VS 2022 32 :       %s" % taille
    if 'VS2022X64' in file_path and 'Debug' in file_path:
        return "  Debug VS 2022 64 :         %s" % taille
    if 'VS2022X64' in file_path and 'Release' in file_path:
        return "  Release VS 2022 64 :       %s" % taille

# Lets check the file size of executable 
# or you can use any file path

name_exec = sys.argv[1]
file_path = fr".\src\{sys.argv[1]}"+".c"
if os.path.isfile(file_path):
    s = 'Date dernière modification du source ' + file_path + ' : ' + time.ctime(os.path.getmtime(file_path))
    print(s)
file_path = fr".\src\{sys.argv[1]}"+".rc"
if os.path.isfile(file_path):
    s = 'Date dernière modification du source ' + file_path + ' : ' + time.ctime(os.path.getmtime(file_path))
    print(s)
file_path = fr".\src\resource.h"
if os.path.isfile(file_path):
    s = 'Date dernière modification du source ' + file_path + ' : ' + time.ctime(os.path.getmtime(file_path))
    print(s)
print(f'Tableau récapitulatif de la taille des exécutables générés pour le projet : {sys.argv[1]}')
file_path = fr".\binBC55\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binBC55\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGMW32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGMW32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGMW64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGMW64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGW32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGW32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGW64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGW64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGX32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGX32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGX64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCLANGX64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCYGWIN32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCYGWIN32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCYGWIN64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binCYGWIN64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binDevCpp\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binDevCpp\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binDMC\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binDMC\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binlcc32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binlcc32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binlcc64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binlcc64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMingw32of\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMingw32of\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMingw32wl\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMingw32wl\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMingw64wl\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMingw64wl\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMingw64CB\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMingw64CB\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMSYS2W32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMSYS2W32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMSYS2W64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binMSYS2W64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binOW32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binOW32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binOW64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binOW64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binPELLESC32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binPELLESC32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binPELLESC64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binPELLESC64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binTDMW32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binTDMW32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binTDMW64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binTDMW64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binVS2022X32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binVS2022X32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binVS2022X64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))
file_path = fr".\binVS2022X64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print(file_size(file_path))