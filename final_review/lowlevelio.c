#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <string.h>
#include <unistd.h>

#define BLOCK_SIZE 4096L

int main(int argc, char *argv[])
{
    int readFileFD; // File descriptor for read file
    int writeFileFD; // File descriptor for write file
    char buffer[BLOCK_SIZE]; // Buffer for copying data
    int readB; // Number of bytes to read
    int writeB; // Number of bytes to write
    int totalB = 0; // Number of bytes written

    // Open the read file with read only permissions
    readFileFD = open(argv[1], O_RDONLY);

    // Open the write file, create if it does not exist
    writeFileFD = open(argv[2], O_WRONLY|O_APPEND|O_CREAT);

    // Print data from read and write files
    printf("Files:\nFD Filename\n");
    printf("%2d %s\n", readFileFD, argv[1]);
    printf("%2d %s\n", writeFileFD, argv[2]);

    // Read data from read file until EOF
    while((readB = read(readFileFD, buffer, BLOCK_SIZE)) > 0)
    {
        writeB = write(writeFileFD, buffer, readB);
        totalB += writeB;
        printf("Read %d bytes, wrote %d bytes\n", readB, writeB);
    }
    close(readFileFD);
    close(writeFileFD);
    printf("Total bytes written = %d bytes", totalB);
    return 0;
}