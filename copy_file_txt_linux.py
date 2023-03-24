# Python program to explain shutil.copy2() method
   
# importing os module
import os, builtins, sys, time
 
# importing shutil module
import shutil

# Source path (le fichier txt doit se trouver sous C:\src)
file_text = sys.argv[1]
source = fr"/home/thierry/Sources/{sys.argv[1]}"
if os.path.isfile(source):
    s = 'Date dernière modification du fichier texte ' + source + ' : ' + time.ctime(os.path.getmtime(source))
    print(s)
    for i in range(48):
        if i < 9:
# Destination path
            if len(sys.argv) == 3:
                destination = fr"/home/thierry/Sources/Opengl/Lesson0"+str(i+1)+fr"/{sys.argv[2]}"
            else:
                destination = fr"/home/thierry/Sources/Opengl/Lesson0"+str(i+1) 
            if os.path.isdir(destination):
                dest = shutil.copy2(source, destination)
        else:
# Destination path
            if len(sys.argv) == 3:
                destination = fr"/home/thierry/Sources/Opengl/Lesson"+str(i+1)+fr"/{sys.argv[2]}"
            else:
                destination = fr"/home/thierry/Sources/Opengl/Lesson"+str(i+1)     
            if os.path.isdir(destination):
                dest = shutil.copy2(source, destination)
else:
    s = 'Le fichier texte ' + source + ' n\'existe pas.'
    print(s)
