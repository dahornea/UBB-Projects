# Solve the problem from the second set here
# Problem 8.
# Find the smallest number m from the Fibonacci sequence, defined by f[0]=f[1]=1, f[n]=f[n-1] + f[n-2], for n > 2, larger than the given natural number n. (e.g. for n = 6, m = 8).

#Function to determine the number on position n from the Fibonnaci sequence

def fibonnaci(n):
    if n == 0:
        return 0
    elif (n == 1) or (n == 2):
        return 1
    else:
        return fibonnaci(n - 1) + fibonnaci(n - 2)

#The function assigns m the value of every number from the Fibonnaci sequence
#After assigning m each value, it checks whether it's larger than the given number in the for loop

def solution(n):
    i = 1
    m = 0
    while m <= n:
        m = fibonnaci(i)
        i += 1
    return m


if __name__ == "__main__":
    n = int(input("Enter the desired number:"))
    if n <= 2:
        print("Please enter a number greater than 2")
    else:
        print("The smallest number from the Fibonnaci sequence bigger than", n, "is:", solution(n))
