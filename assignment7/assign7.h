// Constants
#define MAX_ITEM_NAME 64
#define MAX_SIMPLE_NAME 16
#define MAX_DESCRIPTION 128
#define INVENTORY_FILE "inventory.dat"

// Struct
typedef struct
{
    char itemName[64];
    char simpleName[16];
    int currentQuantity;
    int maxQuantity;
    char body[128];
} Item;