
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
#   
#   Colton Comments:
#       I'm vaguely certain this will only work on Windows
#       For productivity, we use default values for non parameter based calls

##################################################################
# Stuff you can change is right below!
##################################################################

import os.path
import re

# HACK: fix the function - CP
PACKAGE_NAME = 'common'

#DEFAULT_ASSET_PATH = r"..\dev\src\assets"
#DEFAULT_OUTPUT_FILE = r"..\dev\src\common\Assets.as"
DEFAULT_ASSET_PATH = os.path.join("..", "dev", "src", "assets")
DEFAULT_OUTPUT_FILE = os.path.join("..", "dev", "src", "common",
"Assets.as")

# What extensions to look for
EXTENSIONS = [
    'png',
    'mp3',
    'oel',
    'ttf',
    'flv'
]
# What prefixes to give to the assets
#EXTENSIONS and PREFIXES need to line up!
PREFIXES = [
    'IMG',
    'SOUND',
    'LEVEL',
    'FONT',
    'VIDEO'
]
# Which folders to exclude
EXCLUDES = [
    'psd',
    'exclude'
]

USAGE_STRING = \
"""
        >> python asset_generator (You just called this!)
        
            uses DEFAULT_ASSET_PATH and DEFAULT_OUTPUT_FILE
        
        >> python asset_generator.py ASSET_PATH OUTPUT_FILE

            Modify the ASSET_PATH argument to be a path to your assets
            directory from the script.  Usually it's just 'assets'

            Modify the OUTPUT_FILE to be the resulting .as file.

Add names of folders to EXCLUDES to skip them.
Assets cannot contain some symbols!
"""
 
def parse_arguments():
    import sys
    
    if (len(sys.argv) == 1):
        print (USAGE_STRING)
        return DEFAULT_ASSET_PATH, DEFAULT_OUTPUT_FILE       
    
    asset_path = sys.argv[1]
    output_file = sys.argv[2]
    return asset_path, output_file    

# TODO: This doesn't appear to work. PN is always "" - CP  
# Figure out the package name based on the folder
def package_name_from_path(path):
    """
    package_name = path[path.find('/') + 1:]
    package_split = package_name.split('/')
    package_split.pop()
    if (len(package_split) > 0):
        package_name = ".".join(package_split) + " "
    else:
        package_name = ""
        
    return package_name
    """
        
    return PACKAGE_NAME
 
def give_me_the_dicts():
    asset_dict = dict()
    prefix_dict = dict()
    
    for i in range(len(EXTENSIONS)): 
        # Each EXTENSION will point to a list of asset_paths
        # Each EXTENSION points to a specific PREFIX
        asset_dict[EXTENSIONS[i]] = [];
        prefix_dict[EXTENSIONS[i]] = PREFIXES[i] 
    
    return asset_dict, prefix_dict
 
def build_asset_dict(asset_path, output_file, asset_dict):
   output_file_directory, _ = os.path.split(output_file)
   for root,dirs,files in os.walk(asset_path):
     
        if (os.path.basename(root) in EXCLUDES):
            continue
     	
        for file_name in files:
            extension = os.path.splitext(file_name)[1][1:] # w/o '.'
            if (extension in asset_dict ):
                asset_dict[extension].append(
                        os.path.join(
                            os.path.relpath(root, output_file_directory),
                            file_name))
 
def write_to_file(asset_dict, prefix_dict, package_name, asset_path, output_file, class_name):   
    
    file = open(output_file, 'w+')
    file.write(\
    """package """ + package_name + """{
\t/* Auto generated from AssetGenerator.py! */
\tpublic class """ + class_name + """ {
\t
""");
     
    for extension, files_with_extension in asset_dict.items():
        if (len(files_with_extension) == 0):
            continue
            
        file.write ("\t\t/* Generating " + extension + " assets! */\n")
 
        for file_path in files_with_extension:
            file.write("\t\t[Embed(source = \"" + file_path.replace("\\", "/") + "\"")
            
            file_name = os.path.splitext(os.path.basename(file_path))[0]
            clean_file_name = re.sub("[- ]", "_", file_name)
            asset_name = prefix_dict[extension] + "_" + clean_file_name.upper()
            
            if (extension == 'ttf'):
                file.write(", embedAsCFF = \"false\", fontFamily = \"" + file_name + "\")] private static const _" + asset_name + ":Class\n")
                file.write("\t\tpublic static const " + asset_name + ":String = \"" + file_name + "\"\n\n")
            if (extension != 'png' and extension != 'mp3'):
                file.write(", mimeType = \"application/octet-stream\"")
            
            file.write(")] public static const " + asset_name + ":Class\n")
 
        if (extension != 'ttf'):
            file.write("\n")
 
    file.write("\t}\n}")
    file.close()
 
def do_magic(asset_path, output_file):
    class_name = os.path.splitext(os.path.basename(output_file))[0]
    package_name = package_name_from_path(output_file)
    asset_dict, prefix_dict = give_me_the_dicts()
    
    build_asset_dict(asset_path, output_file, asset_dict)
    write_to_file(asset_dict, prefix_dict, package_name, asset_path, output_file, class_name)

def main(): 
    asset_path, output_file = parse_arguments()
    do_magic(asset_path, output_file)

if __name__ == "__main__":
    main()
