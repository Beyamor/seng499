 ##################################################################
# Asset Generator (AssetGenerator.py)
# 
# Original:
#   Kyle Pulver
#   @kylepulver
#   http://kpulv.com
#
# Re-re-re-re-remix:
#   Colton Phillips
#   @ColtonPhillips
#   http://coltonphillips.ca
#
#   TODO: Should be sys arguments instead


##################################################################
# Stuff you can change is right below!
##################################################################
 
# Where to find the assets in relation to the script
#ASSET_FOLDER = 'assets'
# The file to output.  Must use / and not \
#OUTPUT_FILE = 'src/game/Assets.as'
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

USAGE_STRING = \
"""
        >> python asset_generator.py ASSET_PATH OUTPUT_FILE

Modify the ASSET_PATH argument to be a path to your assets
 directory from the script.  Usually it's just 'assets'

 Modify the OUTPUT_FILE to be the resulting .as file.

 Add names of folders to EXCLUDE to skip them.

 Dont use spaces in filenames or foldernames if you can help it

 The script assumes your dir structure looks something like this
 --
 assets/
   png/
     *.png
   mp3/
     *.mp3
   levels/
     *.oel
 assetGenerator.py
 --
 So your base assets folder has at least one sub directory for
 each major type of asset -- although this is not necessary.
 However, each sub directory beyond the first for each major
 asset type will be added to the asset name in the ouput file.

 If you change or improve this script, just let me know!

"""
##################################################################
 
import os
 
def parse_arguments():
    import sys
    if (len(sys.argv) == 1):
        print (USAGE_STRING)
        sys.exit()
    
    
    asset_path = sys.argv[1]
    output_path = sys.argv[2]
    return asset_path, output_path
        
def do_magic(asset_path, output_path):
    #path = os.getcwd() + '\\' + ASSET_FOLDER
    #output = os.getcwd() + '\\' + OUTPUT_FILE
     
    # Figure out the class name based on the file
    class_name = os.path.splitext(os.path.basename(output_path))[0]
     
    # Figure out the package name based on the folder
    package_name = output_path[output_path.find('/') + 1:]
    package_split = package_name.split('/')
    package_split.pop()
    if (len(package_split) > 0):
        package_name = ".".join(package_split) + " "
    else:
        package_name = ""
        
    print package_name
     
    # Assemble some data structures!
    stuff = {}
    prefix = {}
    for i in range(len(EXTENSIONS)):
        stuff[EXTENSIONS[i]] = [];
        prefix[EXTENSIONS[i]] = PREFIXES[i] 
     
    # Walk through dem files
    for r,d,f in os.walk(asset_path):
        add_to_file = True
     
        for excludes in EXCLUDE:
            if (excludes == os.path.basename(r)):
                add_to_file = False
     
        if (add_to_file):	
            for files in f:
                ext = os.path.splitext(files)[1][1:] #grab extension without the '.''
                for key, value in stuff.items():
                    if (ext == key):
                        stuff[key].append(os.path.relpath(r, output_path)[3:] + "\\" + files)
     
    # Start writing the file
    f = open(output_path, 'w+')
    f.write("""package """ + package_name + """{
        /** Auto generated from assetGenerator.py! :) */
        public class """ + class_name + """ {
     
    """);
     
    # Crazy writing all the embeds time
    for key, value in stuff.items():
        if (len(stuff[key]) > 0):
            f.write ("\t\t/** Generating " + key + " assets! */\n")
     
            for files in stuff[key]:
                subfolder = files[:files.find(asset_path)]
                subfolders = []
                subFolderCount = len(subfolder.split('\\'))
                folder_count = len(files.split('\\'))
     
                if (folder_count > subFolderCount + 2):
                    start = files.find(asset_path) + len(asset_path) + 1
                    poop = files[start:]
                    start = poop.find('\\') + 1
                    poop = poop[start:]
                    poop = poop.split('\\')
                    subfolders = poop[:-1]
     
                file_name = os.path.splitext(os.path.basename(files))[0]
                file_name = file_name.replace(" ", "_") #get rid of spaces, use underscores instead
                file_name = file_name.upper().replace(prefix[key] + "_", "") #get rid of prefixes already applied in the file name
                asset_name = prefix[key] + "_"
                for i in range(len(subfolders)):
                    asset_name += subfolders[i].upper().replace(" ", "_") + "_"
                asset_name += file_name
     
                f.write("\t\t[Embed(source = \"" + files.replace("\\", "/") + "\"")
                
                # Fonts are special
                if (key == 'ttf'):
                    f.write(", embedAsCFF = \"false\", fontFamily = \"" + file_name + "\")] private static const _" + asset_name + ":Class\n")
                    f.write("\t\tpublic static const " + asset_name + ":String = \"" + file_name + "\"\n\n")
                else:
                    if (key != 'png' and key != 'mp3'):
                        f.write(", mimeType = \"application/octet-stream\"")
                    f.write(")] public static const " + asset_name + ":Class\n")
     
            if (key != 'ttf'):
                f.write("\n")
     
    # All done!
    f.write("\t}\n}")
    f.close()

def main(): 

    asset_path, output_path = parse_arguments()
    do_magic(asset_path, output_path)

if __name__ == "__main__":
    main()