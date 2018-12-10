#include <stdio.h>


int main(int argc, char *argv[])
{
    if(argc == 2)
        printf("Correct number of arguments supplied!\n");
    else if(argc > 2)
        printf("Too many arguments supplied!\n");
    else(argc < 2)
        printf("Not enough arguments supplied!\n");
    
    printf("First arguement is: %s\n", argv[0]);
    printf("Second argument is: %s\n", argv[1]);
}