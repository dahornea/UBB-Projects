#include <stdio.h>

void decimal();
void hex();
void binary();

int main()
{
	decimal();
    hex();
    binary();
    
	printf("\n\nThis line is printed from the C file!");
    printf("\nPress ENTER to continue.");  
    getchar();
    
    return 0;
}
