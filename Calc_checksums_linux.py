import os, builtins, sys, hashlib, zlib


def crc32_checksum(file_path):
    """
    this function will return the CRC32 Checksum 
    """
    name_exec = sys.argv[1]
    a_file = open(fr"{file_path}", "rb")
    content = a_file.read()
    digest = hex(zlib.crc32(content))[2:]
    c = '/'
    pos = file_path.rfind(c) + 1
    with open(fr"{file_path[0:pos]}"+name_exec+".crc32", "w") as f:
        f.write(fr'{digest}')
    return "Checksum CRC32  is %s." % digest
    
def md5_checksum(file_path):
    """
    this function will return the MD5 Checksum 
    """
    name_exec = sys.argv[1]
    md5_hash = hashlib.md5()
    a_file = open(fr"{file_path}", "rb")
    content = a_file.read()
    md5_hash.update(content)
    digest = md5_hash.hexdigest()
    c = '/'
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
    c = '/'
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
    c = '/'
    pos = file_path.rfind(c) + 1
    with open(fr"{file_path[0:pos]}"+name_exec+".sha512", "w") as f:
        f.write(digest)
    return "Checksum SHA512 is %s." % digest

def rmd160_checksum(file_path):
    """
    this function will return the RMD160 Checksum 
    """
    name_exec = sys.argv[1]
    rmd160_hash = hashlib.new('ripemd160')
    a_file = open(fr"{file_path}", "rb")
    content = a_file.read()
    rmd160_hash.update(content)
    digest = rmd160_hash.hexdigest()
    c = '/'
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
    c = '/'
    pos = file_path.rfind(c) + 1
    with open(fr"{file_path[0:pos]}"+name_exec+".blk2b", "w") as f:
        f.write(digest)
    return "Checksum BLAKE2B is %s." % digest
    
name_exec = sys.argv[1]
print(f'Tableau récapitulatif des différents checksums générés pour le projet : {sys.argv[1]}')
file_path = fr"./bingcc32/Debug/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr"./bingcc32/Release/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr"./bingcc64/Debug/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr"./bingcc64/Release/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr"./binclang32/Debug/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr"./binclang32/Release/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr"./binclang64/Debug/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
file_path = fr"./binclang64/Release/{sys.argv[1]}"+".exe"
if os.path.isfile(file_path):
    print("Calcul des cheksums du fichier : %s." % file_path)
    print(crc32_checksum(file_path))
    print(md5_checksum(file_path))
    print(sha256_checksum(file_path))
    print(sha512_checksum(file_path))
    print(rmd160_checksum(file_path))
    print(blake_checksum(file_path))
