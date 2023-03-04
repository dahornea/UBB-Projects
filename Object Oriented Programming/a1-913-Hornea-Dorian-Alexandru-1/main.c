#include <stdio.h>

// Function to check if a number is prime
int isPrime(int n){
    for (int i = 2; i <= n / 2; i++) {
        if (n % i == 0)
            return 0;
    }
    return 1;
}

//Function that computes the values of the triangle based on the ones above the current value
int triangleValues(int n, int k){
    int res = 1;
    if (k > n - k)
        k = n - k;
    for(int i = 0; i < k ; ++i){
        res *= (n - i);
        res /= (i + 1);
    }
    return res;
}

//Method that prints the pascal triangle using the triangleValues function
void printTriangle(int n){
    for (int line = 0; line < n; line++){
        for(int i = 0; i <= line; i++)
            printf("%d", triangleValues(line, i));
        printf("\n");
    }
}

//Function to find the longest subsequence of prime numbers in an array
void primeSubsequence(int *array, int size){
    int start = 0, count = 0, start2 = 0, count2 = 0;
    for(int i = 0; i < size; i++){
        if(isPrime(array[i]) == 1){
            start = i;
            count++;
        }
        else{
            if(count > count2){
                start2 = start;
                count2 = count;
                count = 0;
            }
        }
    }
    if(count > count2){
        start2 = start;
        count2 = count;
    }
    for (int i = start2 - count2 + 1; i <= start2; i++){
        printf("%d\n", array[i]);
    }
}

//Function to print all prime numbers smaller than n using isPrime function declared above
void primeNumbers(int n){
    for(int i = 1; i < n; i++){
        if(isPrime(i) == 1){
            printf("%d",i);
            printf("%c", " ");
        }
    }
    printf("%s", "\n");
}


int main() {
    int array[20];
    int choice = 0;
    int number = 0;
    int n = 0;
    int m = 0;

    printf("%s", "1. Enter an array.\n");
    printf("%s", "2. Pascal Triangle\n");
    printf("%s", "3. Longest subsequence of prime numbers\n");
    printf("%s", "4. Exit.\n");
    printf("%s", "5. LabWork.\n");
    printf("%s", "Enter a number corresponding to the previous operations:\n");

    scanf("%d", &choice);
    while(1) {
        if (choice == 0){
            printf("%s", "1. Enter an array.\n");
            printf("%s", "2. Pascal Triangle\n");
            printf("%s", "3. Longest subsequence of prime numbers\n");
            printf("%s", "4. Exit.\n");
            printf("%s", "5. LabWork.\n");
            printf("%s", "Enter a number corresponding to the previous operations:\n");
            scanf("%d", &choice);
        }
        if (choice == 1) {
            printf("%s", "How many numbers do you wish to enter? (Maximum 20):");
            scanf("%d", &number);
            for (int i = 0; i < number; i++) {
                printf("array[%d] = ", i);
                scanf("%d", &array[i]);
            }
            choice = 0;
        }
        if (choice == 2) {
            printf("%s", "Enter number of rows:");
            scanf("%d", &n);
            if(n == 0){
                choice = 0;
            }
            printTriangle(n);
        }
        if (choice == 3){
            primeSubsequence((int *) array, number);
            choice = 0;
        }
        if (choice == 4){
            return 0;
        }
        if (choice == 5){
            printf("%s", "Enter number n:");
            scanf("%d", &m);
            primeNumbers(m);
            if(m == 0){
                choice = 0;
            }
        }
    }
}