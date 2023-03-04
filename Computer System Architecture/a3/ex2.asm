bits 32 ; assembling for the 32 bits architecture

; 18.(d+d)-a-b-c     a - byte, b - word, c - dword, d - qword  Unsigned interpretations

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    a db 11h
    b dw 1122h
    c dd 11223344h
    d dq 1122334455667788h
    r resq 1
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EAX, dword[d+0]
        mov EDX, dword[d+4]
        
        add EAX, EAX
        adc EDX, EDX; (d+d)
        
        mov EBX, 0
        mov BL, [a]
        mov ECX, 0; ECX:EBX holds the qword a
        sub EAX, EBX
        sbb EDX, ECX; (d+d) - a
        
        mov EBX, 0
        mov BX, [b]
        mov ECX, 0; ECX:EBX holds the qword b
        sub EAX, EBX
        sbb EDX, ECX; (d+d) - a - b
        
        mov EBX, [c]
        mov ECX, 0; ECX:EBX holds the qword c
        sub EAX, EBX
        sbb EDX, ECX; (d+d)-a-b-c
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
