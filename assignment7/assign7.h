// Constants
#define INVENTORY_FILE "inventory2.dat"

// Struct
typedef struct
{
    char itemName[64];
    char simpleName[16];
    int currentQuantity;
    int maxQuantity;
    char body[128];
} Item;