bits 32 ; assembling for the 32 bits architecture

; 3.Two strings containing characters are given. Calculate and display the result of the concatenation of all characters of type decimal number from the second string, and then followed by those from the first string, and vice versa, the result of concatenating the characters from the first string after those from the second string

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

%include "ex1_module.asm"
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s1 db 
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
