bits 32 ; assembling for the 32 bits architecture

; 18.(d-b)-a-(b-c)     a - byte, b - word, c - double word, d - qword - Signed representation

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    a db 34h
    b dw 7763h
    c dd 88548912h
    d dq 1122334455667788h
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EBX, dword[d+0]; EBX = 55667788
        mov ECX, dword[d+4]; ECX = 11223344
        
        mov AX, [b]
        cwde
        cdq
        
        sub EBX, EAX
        sbb ECX, EDX; d-b
        
        mov AL, [a]
        cbw
        cwde
        cdq; EDX:EAX = 00000000 00000034
        
        sub EBX, EAX
        sbb ECX, EDX; (d-b) - a
        
        mov AX, [b]
        cwde
        
        mov EDX, [c]
        sub EAX, EDX; (b-c)
        cdq
        
        sub EBX, EAX
        sbb ECX, EDX; (d-b)-a-(b-c)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
