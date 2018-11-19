#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "assign7.h"

void printMenu()
{
    printf("Enter one of the following actions or press CTRL-D to exit.\n");
    printf("C - create a new item\n");
    printf("R - read an existing item\n");
    printf("U - update an existing item\n");
    printf("D - delete an existing item\n");
}

int checkForFile(char *fileName) {
    FILE *inventoryFile;

    // Open binary file or create if it does not exist
    inventoryFile = fopen(fileName, "ab+");

    // Close binary file
    fclose(inventoryFile);
}

int checkForItem(int itemNumber) {
    FILE *inventoryFile;
    Item item;
    int numRecRead;

    printf("Item number is: %d\n", itemNumber);
    inventoryFile = fopen(INVENTORY_FILE, "rb");
    numRecRead = fread(&item, sizeof(Item), 1L, inventoryFile);
    printf("Number of entries found is: %d\n", numRecRead);
    return numRecRead;
}

void createItem() {
    Item item;
    int itemNumber;
    int checkResult;

    // Get item number and check if item already exists
    scanf(" %d\n", &itemNumber);
    printf("Item number is: %d\n", itemNumber);
    checkResult = checkForItem(itemNumber);
    if(checkResult != 1) {
        printf("ERROR: item already exists\n");
        return;
    }

    // Get simple name and remove trailing newline
    fgets(item.simpleName, sizeof item.simpleName, stdin);
    item.simpleName[strcspn(item.simpleName, "\n")] = '\0';

    // Get item name and remove trailing newline
    fgets(item.itemName, sizeof item.itemName, stdin);
    item.itemName[strcspn(item.itemName, "\n")] = '\0';

    // Get current quantity
    scanf("%d\n", &item.currentQuantity);

    // Get max quantity
    scanf("%d\n", &item.maxQuantity);

    // Get description and remove trailing newline
    fgets(item.body, sizeof item.body, stdin);
    item.body[strcspn(item.body, "\n")] = '\0';

    // Print struct for testing
    printf("Item number: %d\n", itemNumber);
    printf("Simple name: %s\n", item.simpleName);
    printf("Item name: %s\n", item.itemName);
    printf("Current quantity: %d\n", item.currentQuantity);
    printf("Max quantity: %d\n", item.maxQuantity);
    printf("Description: %s\n", item.body);
}

int main(int argc, char *argv[]) {
    checkForFile(INVENTORY_FILE);

    char userCode;
    int numScans = 0;
    do
    {
        printMenu();
        numScans = scanf(" %c", &userCode);
        if (numScans == EOF)
            break;
        switch (userCode)
        {
        case 'C':
        case 'c':
            createItem();
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
    } while (numScans != EOF);
    return 0;
}
