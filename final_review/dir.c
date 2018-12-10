#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>

int main(int argc, char *argv[])
{
    DIR *dir;
    struct dirent *dirent;
    char type;

    dir = opendir(argv[1]);

    if(dir == NULL)
    {
        printf("opendir could not open '%s'\n", argv[1]);
        exit(1);
    }

    // Show information about each directory entry
    printf("%-10s %s\n", "INODE", "FILENAME");
    while((dirent = readdir(dir)) != NULL)
    {
        if(dirent->d_type == DT_REG)
            type = 'F';
        if(dirent->d_type == DT_DIR)
            type = 'D';
        printf("%10llu %s %c\n", dirent->d_ino, dirent->d_name, type);
    }
    closedir(dir);
    return 0;
}
