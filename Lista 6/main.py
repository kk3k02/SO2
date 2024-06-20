# W zadanym drzewie katalogów znaleźć dowiązania symboliczne wskazujące na podkatalogi w zadanym katalogu
# (drugi argument skryptu, wskazujący na katalog poza drzewem).


import os
import sys


def find_symlinks_in_tree(target_dir, link_target_base):
    # Check if the target dir is a dir
    if not os.path.isdir(target_dir):
        print("Path is not a directory:", target_dir)
        return

    # Convert the link target base to its canonical form
    link_target_base = os.path.realpath(link_target_base)

    # Check if the link target base dir is valid
    if not os.path.isdir(link_target_base):
        print("Target base path is not a dir:", link_target_base)
        return

    # Walk through the dir tree
    for root, dirs in os.walk(target_dir):
        # Check each directory in the current root
        for dir_name in dirs:
            full_path = os.path.join(root, dir_name)
            # Check if the current path is a symlink
            if os.path.islink(full_path):
                # Get the absolute path to where the symlink points
                link_target = os.path.realpath(full_path)
                # Check if the symlink target is within the specified base dir
                if os.path.commonpath([link_target_base]) == os.path.commonpath([link_target_base, link_target]):
                    print(f"Symbolic link: {full_path} points to {link_target}")


# Main section of the script
if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: main.py [directory_tree_path] [target_directory_path]")
    else:
        target_dir = sys.argv[1]
        link_target_base = sys.argv[2]
        find_symlinks_in_tree(target_dir, link_target_base)
