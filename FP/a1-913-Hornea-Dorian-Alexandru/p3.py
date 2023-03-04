# Solve the problem from the third set here
# Problem 15.
# Generate the largest perfect number smaller than a given natural number n. If such a number does not exist, a message should be displayed. A number is perfect if it is equal to the sum of its divisors, except itself. (e.g. 6 is a perfect number, as 6=1+2+3).

#Function to determine the divisors of a number. We then add the numbers to check whether the number is perfect or not

def isPerfect(n):
    s=0
    for i in range(1, int(n/2) + 1):
        if n % i == 0:
            s+=i
    if n == s:
        return True
    return False


#Function to determine the largest perfect number smaller than n
#The for loop checks in descending order if i is a perfect number using the "isPerfect" function

def solution(n):
    for i in range(n, 0, -1):
        if isPerfect(i):
            return i
    return 0

#Function to display a certain message whether there is a perfect number smaller than n or not.

def displayMessage(n):
    if n < 6:
        print("There is no such number smaller than", n)
    elif n > 6:
        print("The largest perfect number smaller than", n, "is:" ,solution(n))
    else:
        print("6 is the smallest perfect number")

if __name__ == "__main__":
    n = int(input("Enter the desired number:"))
    displayMessage(n)
