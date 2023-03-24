import os, builtins, sys, time

def convert_bytes(num):
    """
    this function will convert bytes to MB.... GB... etc
    """
    for x in ['bytes', 'KB', 'MB', 'GB', 'TB']:
        if num < 1024.0:
            return "%5.1f %s" % (num, x)
        num /= 1024.0

def file_size(file_path):
    """
    this function will return the file size
    """
    file_info = os.stat(file_path)
    taille = convert_bytes(file_info.st_size)
    if 'bingcc32' in file_path and 'Debug' in file_path:
        return "  Debug GCC 32b     : %s" % taille
    if 'bingcc32' in file_path and 'Release' in file_path:
        return "  Release GCC 32b   : %s" % taille
    if 'bingcc64' in file_path and 'Debug' in file_path:
        return "  Debug GCC 64b     : %s" % taille
    if 'bingcc64' in file_path and 'Release' in file_path:
        return "  Release GCC 64b   : %s" % taille
    if 'binclang32' in file_path and 'Debug' in file_path:
        return "  Debug CLANG 32b   : %s" % taille
    if 'binclang32' in file_path and 'Release' in file_path:
        return "  Release CLANG 32b : %s" % taille
    if 'binclang64' in file_path and 'Debug' in file_path:
        return "  Debug CLANG 64b   : %s" % taille
    if 'binclang64' in file_path and 'Release' in file_path:
        return "  Release CLANG 64b : %s" % taille

# Lets check the file size of executable 
# or you can use any file path

name_exec = sys.argv[1]
file_path = fr"./src/{sys.argv[1]}"+".cpp"
if os.path.isfile(file_path):
    s = '  Date dernière modification du source ' + file_path + ' : ' + time.ctime(os.path.getmtime(file_path))
    print(s)
print(f'        Tableau récapitulatif de la taille des exécutables générés pour le projet : {sys.argv[1]}')
file_path = fr"./bingcc32/Debug/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    s = file_size(file_path) + ' et sa date dernière modification ' + time.ctime(os.path.getmtime(file_path))  + ' -> ' + file_path + '.'
    print(s)
file_path = fr"./bingcc32/Release/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    s = file_size(file_path) + ' et sa date dernière modification ' + time.ctime(os.path.getmtime(file_path))  + ' -> ' + file_path + '.' 
    print(s)
file_path = fr"./bingcc64/Debug/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    s = file_size(file_path) + ' et sa date dernière modification ' + time.ctime(os.path.getmtime(file_path))  + ' -> ' + file_path + '.'
    print(s)
file_path = fr"./bingcc64/Release/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    s = file_size(file_path) + ' et sa date dernière modification ' + time.ctime(os.path.getmtime(file_path))  + ' -> ' + file_path + '.'
    print(s)
file_path = fr"./binclang32/Debug/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    s = file_size(file_path) + ' et sa date dernière modification ' + time.ctime(os.path.getmtime(file_path))  + ' -> ' + file_path + '.'
    print(s)
file_path = fr"./binclang32/Release/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    s = file_size(file_path) + ' et sa date dernière modification ' + time.ctime(os.path.getmtime(file_path))  + ' -> ' + file_path + '.'
    print(s)
file_path = fr"./binclang64/Debug/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    s = file_size(file_path) + ' et sa date dernière modification ' + time.ctime(os.path.getmtime(file_path))  + ' -> ' + file_path + '.'
    print(s)
file_path = fr"./binclang64/Release/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    s = file_size(file_path) + ' et sa date dernière modification ' + time.ctime(os.path.getmtime(file_path))  + ' -> ' + file_path + '.'
    print(s)
