import os
import shutil

# Utwórz kopię zadanego katalogu, przy czym:
# - wszystkie katalogi, należy zastąpić katalogami pustymi,
# - pliki regularne, do których wykonujący skrypt ma prawo odczytu należy skopiować,
# - pliki regularne, do których wykonujący skrypt nie ma prawa odczytu, zastąpić plikami pustymi,
# - dowiązania symboliczne należy pominąć w kopii.
# Obiekty w kopii powinny mieć takie same prawa dostępu jak w katalogu kopiowanym.


def copy_directory(src, dest):
    # Create destination directory if it does not exist
    if not os.path.exists(dest):
        os.makedirs(dest)

    # Iterate over all items in the source directory
    for item in os.listdir(src):
        s = os.path.join(src, item)
        d = os.path.join(dest, item)

        # Check if the item is a symbolic link
        if os.path.islink(s):
            continue

        # Check if the item is a directory
        if os.path.isdir(s):
            os.makedirs(d, exist_ok=True)  # Create an empty directory
        else:
            # Check if the item is a regular file
            if os.path.isfile(s):
                # Check read access to the file
                if os.access(s, os.R_OK):
                    shutil.copy2(s, d)  # Copy the file with metadata
                else:
                    open(d, 'a').close()  # Create an empty file

        # Set the same permissions as in the source directory
        st = os.stat(s)
        os.chmod(d, st.st_mode)


def main():
    src_directory = './test1'
    dest_directory = './test2'

    copy_directory(src_directory, dest_directory)


if __name__ == "__main__":
    main()
