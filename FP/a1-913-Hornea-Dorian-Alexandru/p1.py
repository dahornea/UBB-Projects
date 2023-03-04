# Solve the problem from the first set here
# Problem 2.
# Given natural number n, determine the prime numbers p1 and p2 such that n = p1 + p2 (check the Goldbach hypothesis).

#Function to determine whether a number is prime or not.

def isPrime(n):
    if n > 1:
        for i in range(2, int(n/2) + 1):
            if n % i == 0:
                return 0
        return 1
    else:
        return 0

#Function to determine the numbers.
#If i is a prime number, we subtract it from n and then check to see if the result is also a prime number. p1 gets the value of the subtrahend, p2 gets the value of the difference

def solution(n):
    for i in range(2, int(n/2) + 1):
        if isPrime(i):
            p1 = i
            p2 = n - i
            if isPrime(p2):
                print("The number " , n , " is equal to " , p1 ,  "+" , p2)
                return True
    print("The number " , n , " is not equal to the sum of any 2 prime numbers")            #If the for loop ends then the function could not find any prime numbers that when added are equal to n


if __name__ == "__main__":
    n = int(input("Enter the desired number: "))
    solution(n)
