import os, builtins, sys, hashlib, zlib

def crc32_checksum(file_path):
    """
    this function will return the CRC32 Checksum 
    """
    name_exec = sys.argv[1]
    a_file = open(fr"{file_path}", "rb")
    content = a_file.read()
    digest = hex(zlib.crc32(content))[2:]
    c = '\\'
    pos = file_path.rfind(c) + 1
    with open(fr"{file_path[0:pos]}"+name_exec+".crc32", "w") as f:
        f.write(fr'{digest}')
    return "Checksum CRC32  is %s." % digest
    
def md5_checksum(file_path):
    """
    this function will return the SHA256 Checksum 
    """
    name_exec = sys.argv[1]
    md5_hash = hashlib.md5()
    a_file = open(fr"{file_path}", "rb")
    content = a_file.read()
    md5_hash.update(content)
    digest = md5_hash.hexdigest()
    c = '\\'
    pos = file_path.rfind(c) + 1
    with open(fr"{file_path[0:pos]}"+name_exec+".md5", "w") as f:
        f.write(digest)
    return "Checksum MD5 is %s." % digest
    
def sha256_checksum(file_path):
    """
    this function will return the SHA256 Checksum 
    """
    name_exec = sys.argv[1]
    sha_256_hash = hashlib.sha256()
    a_file = open(fr"{file_path}", "rb")
    content = a_file.read()
    sha_256_hash.update(content)
    digest = sha_256_hash.hexdigest()
    c = '\\'
    pos = file_path.rfind(c) + 1
    with open(fr"{file_path[0:pos]}"+name_exec+".sha256", "w") as f:
        f.write(digest)
    return "Checksum SHA256 is %s." % digest

def sha512_checksum(file_path):
    """
    this function will return the SHA512 Checksum 
    """
    name_exec = sys.argv[1]
    sha_512_hash = hashlib.sha512()
    a_file = open(fr"{file_path}", "rb")
    content = a_file.read()
    sha_512_hash.update(content)
    digest = sha_512_hash.hexdigest()
    c = '\\'
    pos = file_path.rfind(c) + 1
    with open(fr"{file_path[0:pos]}"+name_exec+".sha512", "w") as f:
        f.write(digest)
    return "Checksum SHA512 is %s." % digest

def rmd160_checksum(file_path):
    """
    this function will return the SHA256 Checksum 
    """
    name_exec = sys.argv[1]
    rmd160_hash = hashlib.new('ripemd160')
    a_file = open(fr"{file_path}", "rb")
    content = a_file.read()
    rmd160_hash.update(content)
    digest = rmd160_hash.hexdigest()
    c = '\\'
    pos = file_path.rfind(c) + 1
    with open(fr"{file_path[0:pos]}"+name_exec+".rmd160", "w") as f:
        f.write(digest)
    return "Checksum RipeMD160 is %s." % digest

def blake_checksum(file_path):
    """
    this function will return the SHA512 Checksum 
    """
    name_exec = sys.argv[1]
    blake2b_hash = hashlib.blake2b()
    a_file = open(fr"{file_path}", "rb")
    content = a_file.read()
    blake2b_hash.update(content)
    digest = blake2b_hash.hexdigest()
    c = '\\'
    pos = file_path.rfind(c) + 1
    with open(fr"{file_path[0:pos]}"+name_exec+".blk2b", "w") as f:
        f.write(digest)
    return "Checksum BLAKE2B is %s." % digest
    
name_exec = sys.argv[1]
print(f'Tableau récapitulatif des différents checksums générés pour le projet : {sys.argv[1]}')
file_path = fr".\binBC55\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binBC55\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGMW32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGMW32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGMW64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGMW64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGW32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGW32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGW64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGW64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGX32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGX32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGX64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCLANGX64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCYGWIN32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCYGWIN32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCYGWIN64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binCYGWIN64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binDevCpp\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binDevCpp\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binDMC\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binDMC\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binlcc32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binlcc32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binlcc64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binlcc64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMingw32of\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMingw32of\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMingw32wl\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMingw32wl\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMingw64wl\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMingw64wl\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMingw64CB\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMingw64CB\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMSYS2W32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMSYS2W32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMSYS2W64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binMSYS2W64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binOW32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binOW32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binOW64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binOW64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binPELLESC32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binPELLESC32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binPELLESC64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binPELLESC64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binTDMW32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binTDMW32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binTDMW64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binTDMW64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binVS2022X32\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binVS2022X32\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binVS2022X64\Debug\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr".\binVS2022X64\Release\{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))