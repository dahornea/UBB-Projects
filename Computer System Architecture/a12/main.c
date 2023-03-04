// main.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <stdio.h>

int minValue(int a[]);


int main()
{
    int a = 0;
    int str[20] = { 0 };
    printf("How many numbers do you wish to enter?");
    scanf_s("%d", &a);
    printf("Enter the numbers:");

    for (int i = 0; i < a; i++)
        scanf_s("%d", &str[i]);
    str[a] = -1;

    int minimum = minValue(str);

    FILE* fptr;
    fptr = fopen("min.txt", "w");
    fprintf(fptr, "%x", minimum);
    fclose(fptr);


}
// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
