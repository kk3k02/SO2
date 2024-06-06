import os


# W zadanym katalogu przerób wszystkie dowiązania symboliczne wskazujące
# na pliki regularne w tym katalogu, na dowiązania twarde.

def convert_symlinks_to_hardlinks(dir):
    # Iterate through all files in the given directory
    for filename in os.listdir(dir):
        filepath = os.path.join(dir, filename)

        # Check if the file is a symbolic link
        if os.path.islink(filepath):
            # Get the target path of the symbolic link
            target_path = os.readlink(filepath)
            target_fullpath = os.path.join(dir, target_path)

            # Check if the target path is a regular file
            if os.path.isfile(target_fullpath):
                # Remove the symbolic link
                os.remove(filepath)
                # Create a hard link
                os.link(target_fullpath, filepath)
                print(f'Converted symlink: {filepath} to hardlink pointing to {target_fullpath}')


directory = './test1'
convert_symlinks_to_hardlinks(directory)