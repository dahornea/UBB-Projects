#
# Write the implementation for A2 in this file
#

# UI section
# (write all functions that have input or print statements here). 
# Ideally, this section should not contain any calculations relevant to program functionalities
def read_list(l):
    while True:
            real = input("The real part of the number :")
            if real == "stop":
                print("Stopped reading")
                return
            try:
                real = int(real)
            except ValueError:
                print("Invalid numerical value")
                return
            imag = input("The imaginary part of the number :")
            try:
                imag = int(imag)
            except ValueError:
                print("Invalid numerical value")
                return
            x = create_complex_number()
            set_real(x, real)
            set_imaginary(x, imag)
            l.append(x)

def print_list(l):
    for i in l:
        s = ''
        if get_real(i) != 0:
            s += str(get_real(i))
        if get_imaginary(i) != 0:
            #if s is empty then the real part was 0 so we only print the imaginary one
            if s == '':
                if get_imaginary(i) == 1:
                    s += 'i'
                elif get_imaginary(i) == -1:
                    s += '-i'
                else:
                    s += str(get_imaginary(i)) + 'i'
            elif get_imaginary(i) > 0:
                if get_imaginary(i) == 1:
                    s += "+i"
                else:
                    s += "+" + str(get_imaginary(i)) + 'i'
            else:
                if get_imaginary(i) == -1:
                    s += "-i"
                else:
                    s += str(get_imaginary(i)) + 'i'
        #if both parts are 0 then we print '0'
        if s == '':
            s = 0
        print(s)

def print_menu():
    print("Enter '1' to read a list of complex numbers")
    print("Enter '2' to display the list of complex numbers")
    print("Enter '3' to display the longest sequence of distinct numbers")
    print("Enter '4' to display the longest sequence of numbers where both real and imaginary parts can be written using the same base 10 digits")
    print("Enter 'exit' to exit the program")

# Function section
# (write all non-UI functions in this section)
# There should be no print or input statements below this comment
# Each function should do one thing only
# Functions communicate using input parameters and their return values

# print('Hello A2'!) -> prints aren't allowed here!
def get_real(x):
    # we retrieve the real part of the number from the first element of the list
    return x[0]

def set_real(x, value):
    """
    :param x: the number that belongs to the real part
    :param value: in this case the value will be "real"
    """
    x[0] = value

def get_imaginary(x):
    # we retrieve the imaginary part of the number from the second element of the list
    return x[1]

def set_imaginary(x, value):
    """
    :param x: the number that belongs to the imaginary part
    :param value: in this case the value will be "imag"
    """
    x[1] = value

def create_complex_number(a=0, b=0):
    """
    :param a: real part of the number
    :param b: imaginary part of the number
    :return: a list to store both parts of the complex number
    """
    return [a,b]

def distinct_numbers(l):
    '''
    :param l: the list of complex numbers
    :return: the longest sequence of distinct numbers
    '''
    seq = []
    seq2 = []
    for i in l:
        if i in seq2:
            if len(seq2) > len(seq):
                seq = seq2
                seq2 = []
            else:
                seq2 = []
            seq2.append(i)
        else:
            seq2.append(i)
    if len(seq2) > len(seq):
        seq = seq2
    return seq


def digit_frequency(n):
    """
    :param n: the number whose digits we want to save
    :return: a list with the number's digits
    """
    freq = [0] * 10
    # Basic algorithm to find the frequency of a number's digits
    # We get the frequency of the real number's digits
    i = abs((get_real(n)))
    while i:
        d = abs(int(i % 10))
        freq[d] = 1
        i = i // 10
    # Then the imaginary one
    j = abs((get_imaginary(n)))
    while j:
        d = abs(int(j % 10))
        freq[d] = 1
        j = j // 10
    return freq

def same_digits(l):
    '''
    :param l: the list of complex numbers
    :return: the longest sequence of numbers where both real and imaginary parts can be written using the same digits
    '''
    seq = []
    seq2 = [l[0]]
    # We add the first element of l in seq2 to compare it's digits frequency with the next ones.
    for i in l[1:]:
        if digit_frequency(i) == digit_frequency(seq2[0]):
            seq2.append(i)
        else:
            if len(seq2) > len(seq):
                seq = seq2
                seq2 = []
            else:
                seq2=[]
            seq2.append(i)
    if len(seq2) > len(seq):
        seq = seq2
    return seq

def main():
    l = [create_complex_number(9, 3), create_complex_number(3, 5), create_complex_number(6, 8), create_complex_number(62, 37),
        create_complex_number(251, 9), create_complex_number(2, 9), create_complex_number(6, 2), create_complex_number(113, 13),
        create_complex_number(13, 31), create_complex_number(131, 310)]
    while True:
        print_menu()
        option = input(">>>")
        if option == "1":
            read_list(l)
        elif option == "2":
            print_list(l)
        elif option == "3":
            print_list(distinct_numbers(l))
        elif option == "4":
            print_list(same_digits(l))
        elif option == "exit":
            return
        else:
            print("Please only enter the available options")

main()