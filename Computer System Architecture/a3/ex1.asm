bits 32 ; assembling for the 32 bits architecture

; 3.(c+d)-(a+d)+b       a- byte,   b- word, c - doubleword, d - qword   Unsigned interpretations

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
        mov EAX, [c]
        mov EDX, 0; EDX:EAX hold 'c' as qword
        
        mov EBX, dword[d+0]
        mov ECX, dword[d+4]
        
        add EAX, EBX
        adc EDX, ECX; (c+d)
        
        mov dword [r+0], eax 
        mov dword [r+4], edx ; hold (c+d) in a variable
        
        mov EAX, 0;
        mov AL, [a]
        mov AH, 0; convert a into word
        mov DX, 0; convert a into dword
        mov EDX, 0; convert a into qword
        
        add EAX, EBX
        adc EDX, ECX; (a+d)
        
        mov EBX, dword[r+0]
        mov ECX, dword[r+4]
        sub ebx, eax
        sbb ecx, edx; (c+d) - (a+d)
        
        mov EAX, 0
        mov ax, [b]
        mov edx, 0
        add ebx, eax
        adc ecx, edx; (c+d)-(a+d)+b
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
