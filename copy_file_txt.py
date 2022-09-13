# Python program to explain shutil.copy2() method
   
# importing os module
import os, builtins, sys, time
 
# importing shutil module
import shutil

# Source path (le fichier txt doit se trouver sous C:\src)
file_text = sys.argv[1]
source = fr"C:\src\{sys.argv[1]}"
if os.path.isfile(source):
    s = 'Date dernière modification du fichier texte ' + source + ' : ' + time.ctime(os.path.getmtime(source))
    print(s)
    for i in range(39):
        if i < 10:
# Destination path
            destination = fr"C:\src\OpenGL\NeHe_Lesson0"+str(i)+"-master"
            dest = shutil.copy2(source, destination)
        else:
# Destination path
            destination = fr"C:\src\OpenGL\NeHe_Lesson"+str(i)+"-master"
            dest = shutil.copy2(source, destination)
else:
    s = 'Le fichier texte ' + source + ' n\'existe pas.'
    print(s)