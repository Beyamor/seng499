 ##################################################################
# Asset Generator (assetGenerator.py)
# Kyle Pulver
# @kylepulver
# http://kpulv.com
# 2013 / 2 / 3
# Version 1.0.0
#
# Put this file in your AS3 Project root.
#
# Modify the ASSET_FOLDER argument to be a path to your assets
# directory from the script.  Usually it's just 'assets'
#
# Modify the OUTPUT_FILE to be the resulting .as file.
#
# Add names of folders to EXCLUDE to skip them.
#
# Dont use spaces in filenames or foldernames if you can help it
#
# The script assumes your dir structure looks something like this
# --
# assets/
#   png/
#     *.png
#   mp3/
#     *.mp3
#   levels/
#     *.oel
# assetGenerator.py
# --
# So your base assets folder has at least one sub directory for
# each major type of asset -- although this is not necessary.
# However, each sub directory beyond the first for each major
# asset type will be added to the asset name in the ouput file.
#
# If you change or improve this script, just let me know!
##################################################################
 
import os
 
##################################################################
# Stuff you can change is right below!
##################################################################
 
# Where to find the assets in relation to the script
ASSET_FOLDER = 'assets'
# The file to output.  Must use / and not \
OUTPUT_FILE = 'src/game/Assets.as'
# What extensions to look for
EXTENSIONS = [
  'png',
    'mp3',
    'oel',
    'ttf'
]
# What prefixes to give to the assets
PREFIXES = [
    'IMG',
    'SOUND',
    'LEVEL',
    'FONT'
]
# Which folders to exclude
EXCLUDE = [
    'psd',
    'exclude'
]
 
##################################################################
# Magic happens below this line!
##################################################################
 
path = os.getcwd() + '\\' + ASSET_FOLDER
output = os.getcwd() + '\\' + OUTPUT_FILE
 
# Figure out the class name based on the file
className = os.path.splitext(os.path.basename(OUTPUT_FILE))[0]
 
# Figure out the package name based on the folder
packageName = OUTPUT_FILE[OUTPUT_FILE.find('/') + 1:]
packageSplit = packageName.split('/')
packageSplit.pop()
if (len(packageSplit) > 0):
    packageName = ".".join(packageSplit) + " "
else:
    packageName = ""
 
# Assemble some data structures!
stuff = {}
prefix = {}
for i in range(len(EXTENSIONS)):
    stuff[EXTENSIONS[i]] = [];
    prefix[EXTENSIONS[i]] = PREFIXES[i] 
 
# Walk through dem files
for r,d,f in os.walk(path):
    addToFile = True
 
    for excludes in EXCLUDE:
        if (excludes == os.path.basename(r)):
            addToFile = False
 
    if (addToFile):	
        for files in f:
            ext = os.path.splitext(files)[1][1:] #grab extension without the '.''
            for key, value in stuff.items():
                if (ext == key):
                    stuff[key].append(os.path.relpath(r, output)[3:] + "\\" + files)
 
# Start writing the file
f = open(output, 'w+')
f.write("""package """ + packageName + """{
    /** Auto generated from assetGenerator.py! :) */
    public class """ + className + """ {
 
""");
 
# Crazy writing all the embeds time
for key, value in stuff.items():
    if (len(stuff[key]) > 0):
        f.write ("\t\t/** Generating " + key + " assets! */\n")
 
        for files in stuff[key]:
            subfolder = files[:files.find(ASSET_FOLDER)]
            subFolders = []
            subFolderCount = len(subfolder.split('\\'))
            folderCount = len(files.split('\\'))
 
            if (folderCount > subFolderCount + 2):
                start = files.find(ASSET_FOLDER) + len(ASSET_FOLDER) + 1
                poop = files[start:]
                start = poop.find('\\') + 1
                poop = poop[start:]
                poop = poop.split('\\')
                subFolders = poop[:-1]
 
            fname = os.path.splitext(os.path.basename(files))[0]
            fname = fname.replace(" ", "_") #get rid of spaces, use underscores instead
            fname = fname.upper().replace(prefix[key] + "_", "") #get rid of prefixes already applied in the file name
            assetName = prefix[key] + "_"
            for i in range(len(subFolders)):
                assetName += subFolders[i].upper().replace(" ", "_") + "_"
            assetName += fname
 
            f.write("\t\t[Embed(source = \"" + files.replace("\\", "/") + "\"")
            
            # Fonts are special
            if (key == 'ttf'):
                f.write(", embedAsCFF = \"false\", fontFamily = \"" + fname + "\")] private static const _" + assetName + ":Class\n")
                f.write("\t\tpublic static const " + assetName + ":String = \"" + fname + "\"\n\n")
            else:
                if (key != 'png' and key != 'mp3'):
                    f.write(", mimeType = \"application/octet-stream\"")
                f.write(")] public static const " + assetName + ":Class\n")
 
        if (key != 'ttf'):
            f.write("\n")
 
# All done!
f.write("\t}\n}")
f.close()