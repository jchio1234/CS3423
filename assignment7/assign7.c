#define _CRT_SECURE_NO_WARNINGS 1

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

void createItem()
{
    Item item;
    int itemNumber;
    char buffer[MAX_DESCRIPTION];

    // Get item number and check if item already exists
    scanf("%d\n", &itemNumber);

    // Get simple name
    fgets(item.simpleName, sizeof item.simpleName, stdin);
    item.simpleName[strcspn(item.simpleName, "\n")] = '\0';

    // Get item name
    fgets(item.itemName, sizeof item.itemName, stdin);
    item.itemName[strcspn(item.itemName, "\n")] = '\0';

    // Get current quantity
    scanf("%d\n", &item.currentQuantity);

    // Get max quantity
    scanf("%d\n", &item.maxQuantity);

    // Get description
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

int main(int argc, char *argv[])
{
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
