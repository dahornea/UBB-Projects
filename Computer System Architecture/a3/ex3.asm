bits 32 ; assembling for the 32 bits architecture

; 3. (b+b+d)-(c+a)   a - byte, b - word, c - dword, d - qword   Signed interpretations

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    a db 11110111b
    b dw 1122h
    c dd 11223344h
    d dq 1122334455667788h
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EAX, 0
        mov AX, [b]
        add AX, AX; AX = b + b
        
        cwde
        cdq; EDX: EAX = 00000000 00002244
        
        mov EBX, dword[d+0]; EBX = 55667788
        mov ECX, dword[d+4]; ECX = 11223344
        
        add EBX, EAX; EBX = 00002244 + 55667788
        adc ECX, EDX; = ECX = 00000000 + 00002244
        
        
        mov EDX, [c]
        mov AL, [a]
        cbw
        cwde
        
        add EAX, EDX; (c+a)
        cdq
        
        sub EBX, EAX
        sbb ECX, EDX 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
