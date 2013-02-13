
# Asset Generator (AssetGenerator.py)
# 
# Original:
#   Kyle Pulver
#   @kylepulver
#   http://kpulv.com
#   
#   Kyle comments:
#       Dont use spaces in filenames or foldernames if you can help it
#
# Re-re-re-re-remix:
#   Colton Phillips
#   @ColtonPhillips
#   http://coltonphillips.ca

##################################################################
# Stuff you can change is right below!
##################################################################

#EXTENSIONS and PREFIXES need to line up!

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
EXCLUDES = [
    'psd',
    'exclude'
]

USAGE_STRING = \
"""
        >> python asset_generator.py ASSET_PATH OUTPUT_FILE

Modify the ASSET_PATH argument to be a path to your assets
directory from the script.  Usually it's just 'assets'

Modify the OUTPUT_FILE to be the resulting .as file.

Add names of folders to EXCLUDES to skip them.
"""
 
import os
 
def parse_arguments():
    import sys
    if (len(sys.argv) == 1):
        print (USAGE_STRING)
        sys.exit()
    
    asset_path = sys.argv[1]
    output_path = sys.argv[2]
    return asset_path, output_path    

# TODO: This doesn't appear to work. PN is always ""    
# Figure out the package name based on the folder
def package_name_from_path(path):
    package_name = path[path.find('/') + 1:]
    package_split = package_name.split('/')
    package_split.pop()
    if (len(package_split) > 0):
        package_name = ".".join(package_split) + " "
    else:
        package_name = ""
        
    return package_name
 
def give_me_the_dicts():
    asset_dict = dict()
    prefix_dict = dict()
    
    for i in range(len(EXTENSIONS)): 
        # Each EXTENSION will point to a list of assets
        # Each EXTENSION points to a specific PREFIX
        asset_dict[EXTENSIONS[i]] = [];
        prefix_dict[EXTENSIONS[i]] = PREFIXES[i] 
    
    return asset_dict, prefix_dict
 
def build_asset_dict(asset_path, output_path, asset_dict):
   for root,dirs,files in os.walk(asset_path):
     
        if (os.path.basename(root) in EXCLUDES):
            continue
     	
        for file_name in files:
            extension = os.path.splitext(file_name)[1][1:] # w/o '.'
            if (extension in asset_dict ):
                asset_dict[extension].append(os.path.relpath(root, output_path)[3:] + '\\' + file_name)
 
def write_to_file(asset_dict, prefix_dict, package_name, asset_path, output_path, class_name):
    
    
    # Start writing the file
    file = open(output_path, 'w+')
    file.write("""package """ + package_name + """{
        /** Auto generated from assetGenerator.py! :) */
        public class """ + class_name + """ {
     
    """);
     
    # Crazy writing all the embeds time
    for key, value in asset_dict.items():
        if (len(asset_dict[key]) > 0):
            file.write ("\t\t/** Generating " + key + " assets! */\n")
     
            for files in asset_dict[key]:
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
                file_name = file_name.upper().replace(prefix_dict[key] + "_", "") #get rid of prefixes already applied in the file name
                asset_name = prefix_dict[key] + "_"
                for i in range(len(subfolders)):
                    asset_name += subfolders[i].upper().replace(" ", "_") + "_"
                asset_name += file_name
     
                file.write("\t\t[Embed(source = \"" + files.replace("\\", "/") + "\"")
                
                # Fonts are special
                if (key == 'ttf'):
                    file.write(", embedAsCFF = \"false\", fontFamily = \"" + file_name + "\")] private static const _" + asset_name + ":Class\n")
                    file.write("\t\tpublic static const " + asset_name + ":String = \"" + file_name + "\"\n\n")
                else:
                    if (key != 'png' and key != 'mp3'):
                        file.write(", mimeType = \"application/octet-stream\"")
                    file.write(")] public static const " + asset_name + ":Class\n")
     
            if (key != 'ttf'):
                file.write("\n")
     
    # All done!
    file.write("\t}\n}")
    file.close()

 
def do_magic(asset_path, output_path):
    class_name = os.path.splitext(os.path.basename(output_path))[0]
    package_name = package_name_from_path(output_path)
    asset_dict, prefix_dict = give_me_the_dicts()
    
    build_asset_dict(asset_path, output_path, asset_dict)
    write_to_file(asset_dict, prefix_dict, package_name, asset_path, output_path, class_name)

def main(): 
    asset_path, output_path = parse_arguments()
    do_magic(asset_path, output_path)

if __name__ == "__main__":
    main()