#include <stdio.h>
#include "assign7.h"

void printMenu() {
    printf("Enter one of the following actions or press CTRL-D to exit.\n");
    printf("C - create a new item\n");
    printf("R - read an existing item\n");
    printf("U - update an existing item\n");
    printf("D - delete an existing item\n");
}

int main(int argc, char *argv[]) {
    char userCode;
    do {
        printMenu();
        scanf(" %c", &userCode);
        switch (userCode) {
            case 'C':
            case 'c':
                printf("Time to create!\n");
                break;
            case 'R':
            case 'r':
                printf("Time to read!\n");
                break;
            case 'U':
            case 'u':
                printf("Time to update!\n");
                break;
            case 'D':
            case 'd':
                printf("Time to delete!\n");
                break;
            default:
                printf("ERROR: invalid option\n");
                break;
        }
    } while (userCode);
    return 0;
}
