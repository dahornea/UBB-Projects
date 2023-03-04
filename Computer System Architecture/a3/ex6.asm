bits 32 ; assembling for the 32 bits architecture

; 18.(a+b*c+2/c)/(2+a)+e+x      a,b-byte; c-word; e-doubleword; x-qword

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        



; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    a db 2h
    b db 3h
    c dw 4532h
    e dd 45328945h
    x dq 1122334455667788h
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        MOV EAX, 0
        MOV EBX, 0
        MOV ECX, 0
        MOV EDX, 0
        
        mov AL, [b]
        cbw; AX = b
        mov DX, [c]
        imul DX
        push DX
        push AX
        pop EBX; EBX = b*c
        
        mov EAX, 0
        mov EAX, 2h
        mov CX, [c]
        idiv CX; DX:AX = 2/c
        
        mov ECX, EAX
        mov AL, [a]
        cbw
        cwde; EAX = a
        
        add EAX, EBX; EAX = a+b*c
        add EAX, ECX; EAX = a+b*c+2/c
        
        mov BL, 2
        mov CL, [a]
        add BL, CL; BL = 2+a
        
        mov ECX, EAX
        mov AL, BL
        cbw
        mov BX, AX
        mov EAX, ECX
        mov EDX, 0
        idiv BX; DX:AX = (a+b*c+2/c)/(2+a)
        cwde; EAX = (a+b*c+2/c)/(2+a)
        mov EBX, [e]
        add EAX, EBX; EAX = (a+b*c+2/c)/(2+a)+e
        cdq; EDX:EAX = (a+b*c+2/c)/(2+a)+e
        
        mov EBX, dword[x+0]
        mov ECX, dword[x+4]
        add EAX, EBX
        adc EDX, ECX; EDX:EAX = (a+b*c+2/c)/(2+a)+e+x
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
