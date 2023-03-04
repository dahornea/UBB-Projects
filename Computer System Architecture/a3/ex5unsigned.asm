bits 32 ; assembling for the 32 bits architecture

;3.(8-a*b*100+c)/d+x         a,b,d-byte; c-doubleword; x-qword

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
    c dd 45328945h
    d db 20h
    x dq 1122334455667788h
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov AL, [a]
        mov DL, [b]
        mul DL; AX = a*b
        
        mov DX, 100h
        mul DX; DX:AX = a*b*100
        
        push DX
        push AX
        pop EBX; EBX = a*b*100
        
        mov ECX, 8h
        sub ECX, EBX; ECX = 8-a*b*100
        
        mov EBX, [c]
        add ECX, EBX; ECX = 8-a*b*100+c
        
        mov AL, [d]
        mov AH, 0; AX = word d
        
        mov EBX, 0
        mov BX, AX
        mov EAX, 0
        mov EDX, 0
        push ECX;
        pop AX;
        pop DX
        
        div BX; DX:AX = (8-a*b*100+c)/d
        mov CX, AX
        mov EAX, 0
        mov AX, CX
        mov EDX, 0; EDX:EAX = (8-a*b*100+c)/d
        
        mov EBX, dword[x+0]
        mov ECX, dword[x+4]
        
        add EAX, EBX
        adc EDX, ECX; EDX: EAX = (8-a*b*100+c)/d+x
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
