bits 32 ; assembling for the 32 bits architecture

; 18. Given the word A, compute the doubleword B as follows:
;       the bits 0-3 of B have the value 0
;       the bits 4-7 of B are the same as the bits 8-11 of A
;       the bits 8-9 and 10-11 of B are the invert of the bits 0-1 of A (so 2 times)
;       the bits 12-15 of B have the value 1
;       the bits 16-31 of B are the same as the bits 0-15 of B.


; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 0111011101010111b
    b dd 0
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EAX, 0
        mov EBX, 0; we compute the result in EBX

        or EBX, 11111111111111111111111111110000b; we force the value of bits 0-3 to 0
        
        mov ax, [a]
        and ax, 0000111100000000b
        mov cl, 4
        ror ax, cl; we rotate 4 positions to the right
        or EBX, EAX; we put the bits into the result
        
        mov ax, [a]
        not ax
        mov cl, 8
        rol ax, cl; we rotate 8 positions to the left
        or EBX, EAX; we add the inversed bits 0-1 of A in bits 8-9 of B
        
        mov ax, [a]
        not ax
        mov cl, 10
        rol ax, cl
        or EBX, EAX; we add the inversed bits 0-1 of A in bits 10-11 of B

        or EBX, 00000000000000001111000000000000b; we force the value of bits 12-15 to 1
        
        mov AX, BX; we move the 0-15 bits in AX 
        mov cl, 16
        rol EAX, cl; we rotate 16 positions to the left
        or EBX, EAX; we put the bits into the result
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
