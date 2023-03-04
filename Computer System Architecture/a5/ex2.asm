bits 32 ; assembling for the 32 bits architecture

; Two byte strings A and B are given. Obtain the string R that contains only the odd positive elements of the two strings.

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db '2', '1', '3', '-3'
    a1 equ $-a
    b db '4', '5', '-5', '7'
    b1 equ $-b
    r times 1 db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ECX, a1-1
        mov ESI, 0
        jecxz Final
        Loop1:
            mov al, [a+esi]
            test al, 1
            jpo oddd
            jg positiv
            
            oddd:
            ;if element is odd:
            jmp positiv
            
            positiv:
            ;if element is positive:
            mov [r+esi], al
            jmp increase
            
            increase:
            inc esi
        
        loop Loop1
        Final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
