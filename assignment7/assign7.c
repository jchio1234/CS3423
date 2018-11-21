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

void checkForInventoryFile(char *fileName) {
    FILE *inventoryFile;

    // Open binary file or create if it does not exist
    inventoryFile = fopen(fileName, "ab+");

    // Close binary file
    fclose(inventoryFile);
}

int checkForExistingItem(int itemNumber) {
    FILE *p;
    Item item;
    long readResult;

    // Open file, read data into buffer, and return result of read
    p = fopen(INVENTORY_FILE, "rb");
    long int relativeByteAddress = itemNumber * sizeof(Item);
    fseek(p, relativeByteAddress, SEEK_SET);
    readResult = fread(&item, sizeof(Item), 1L, p);
    fclose(p);
    if(item.maxQuantity == 0)
        readResult = 0;
    return readResult;
}

void createItem() {
    FILE *p;
    Item item;
    int itemNumber;
    int checkResult;
    char buffer[MAX_DESCRIPTION];

    // Get item number and check if item already exists
    scanf("%d", &itemNumber);
    getchar();
    checkResult = checkForExistingItem(itemNumber);
    if(checkResult != 0) {
        printf("ERROR: item already exists\n");
        return;
    }

    // Get simple name
    fgets(buffer, MAX_DESCRIPTION, stdin);
    sscanf(buffer, "%s", item.simpleName);

    // Get item name
    fgets(buffer, MAX_DESCRIPTION, stdin);
    sscanf(buffer, "%[^\n]s", item.itemName);

    // Get current quantity
    fgets(buffer, MAX_DESCRIPTION, stdin);
    sscanf(buffer, "%d", &item.currentQuantity);

    // Get max quantity
    fgets(buffer, MAX_DESCRIPTION, stdin);
    sscanf(buffer, "%d", &item.maxQuantity);

    // Get description
    fgets(buffer, MAX_DESCRIPTION, stdin);
    sscanf(buffer, "%[^\n]s", item.body);

    // Write item to file
    p = fopen(INVENTORY_FILE, "rb+");
    long int relativeByteAddress = itemNumber * sizeof(Item);
    fseek(p, relativeByteAddress, SEEK_SET);
    long writeResult = fwrite(&item, sizeof(Item), 1L, p);
    if(writeResult != 1)
        printf("Error writing record %d\n", itemNumber);
    fclose(p);
}

void readItem() {
    FILE *p;
    Item item;
    int itemNumber;
    int checkResult;

    // Get item number and check if item does not exist
    printf("Enter an item number:\n");
    scanf("%d", &itemNumber);
    getchar();
    checkResult = checkForExistingItem(itemNumber);
    if(checkResult == 0) {
        printf("ERROR: item not found\n");
        return;
    }

    // Open file and read data into buffer
    p = fopen(INVENTORY_FILE, "rb");
    long int relativeByteAddress = itemNumber * sizeof(Item);
    fseek(p, relativeByteAddress, SEEK_SET);
    long readResult = fread(&item, sizeof(Item), 1L, p);
    if(readResult != 1)
        printf("Error reading record %d\n", itemNumber);

    // Print read result
    printf("Item name: %s\n", item.itemName);
    printf("Simple name: %s\n", item.simpleName);
    printf("Item Number: %d\n", itemNumber);
    printf("Qty: %d/%d\n", item.currentQuantity, item.maxQuantity);
    printf("Description: %s\n", item.body);
    fclose(p);
}

void updateItem() {
    FILE *p;
    Item item;
    Item existingItem;
    int itemNumber;
    int checkResult;
    char buffer[MAX_DESCRIPTION];

    // Get item number and check if item already exists
    printf("Enter an item number:\n");
    scanf("%d", &itemNumber);
    getchar();
    checkResult = checkForExistingItem(itemNumber);
    if(checkResult == 0) {
        printf("ERROR: item not found\n");
        return;
    }

    // Get simple name
    printf("Enter an simple name:\n");
    fgets(buffer, MAX_DESCRIPTION, stdin);
    sscanf(buffer, "%s", item.simpleName);

    // Get item name
    printf("Enter an item name:\n");
    fgets(buffer, MAX_DESCRIPTION, stdin);
    sscanf(buffer, "%[^\n]s", item.itemName);

    // Get current quantity
    printf("Enter a current quantity:\n");
    fgets(buffer, MAX_DESCRIPTION, stdin);
    if(buffer[0] == '\n')
        item.currentQuantity = 0;
    else
        sscanf(buffer, "%d", &item.currentQuantity);

    // Get max quantity
    printf("Enter a max quantity:\n");
    fgets(buffer, MAX_DESCRIPTION, stdin);
    if(buffer[0] == '\n')
        item.maxQuantity = 0;
    else
        sscanf(buffer, "%d", &item.maxQuantity);

    // Get description
    printf("Enter a description:\n");
    fgets(buffer, MAX_DESCRIPTION, stdin);
    sscanf(buffer, "%[^\n]s", item.body);

    // Open file and read data into buffer
    p = fopen(INVENTORY_FILE, "rb+");
    long int relativeByteAddress = itemNumber * sizeof(Item);
    fseek(p, relativeByteAddress, SEEK_SET);
    long readResult = fread(&existingItem, sizeof(Item), 1L, p);
    if(readResult != 1)
        printf("Error reading record %d\n", itemNumber);

    // Update struct items if not empty
    if(item.itemName[0] == '\0')
        strcpy(item.itemName, existingItem.itemName);
    if(item.simpleName[0] == '\0')
        strcpy(item.simpleName, existingItem.simpleName);
    if(item.currentQuantity == 0)
        item.currentQuantity = existingItem.currentQuantity;
    if(item.maxQuantity == 0)
        item.maxQuantity = existingItem.maxQuantity;
    if(item.body[0] == '\0')
        strcpy(item.body, existingItem.body);

    // Write updated item to file
    fseek(p, relativeByteAddress, SEEK_SET);
    long writeResult = fwrite(&item, sizeof(Item), 1L, p);
    if(writeResult != 1)
        printf("Error writing record %d\n", itemNumber);
    fclose(p);
}

void deleteItem() {
    FILE *p;
    Item existingItem;
    Item emptyItem;
    int itemNumber;
    int checkResult;

    // Get item number and check if item does not exist
    printf("Enter an item number:\n");
    scanf("%d", &itemNumber);
    getchar();
    checkResult = checkForExistingItem(itemNumber);
    if(checkResult == 0) {
        printf("ERROR: item not found\n");
        return;
    }

    // Populate emptyItem
    strcpy(emptyItem.itemName, "");
    strcpy(emptyItem.simpleName, "");
    emptyItem.currentQuantity = 0;
    emptyItem.maxQuantity = 0;
    strcpy(emptyItem.body, "");

    // Open file and read data into buffer
    p = fopen(INVENTORY_FILE, "rb+");
    long int relativeByteAddress = itemNumber * sizeof(Item);
    fseek(p, relativeByteAddress, SEEK_SET);
    long readResult = fread(&existingItem, sizeof(Item), 1L, p);
    if(readResult != 1)
        printf("Error reading record %d\n", itemNumber);

    // Overwrite existing item with emptyItem
    fseek(p, relativeByteAddress, SEEK_SET);
    long writeResult = fwrite(&emptyItem, sizeof(Item), 1L, p);
    if(writeResult != 1)
        printf("Error writing record %d\n", itemNumber);

    // Print confirmation message
    printf("%s was successfully deleted.\n", existingItem.simpleName);
    fclose(p);
}

int main(int argc, char *argv[]) {
    checkForInventoryFile(INVENTORY_FILE);
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
            readItem();
            break;
        case 'U':
        case 'u':
            updateItem();
            break;
        case 'D':
        case 'd':
            deleteItem();
            break;
        default:
            printf("ERROR: invalid option\n");
            break;
        }
    } while (numScans != EOF);
    return 0;
}
