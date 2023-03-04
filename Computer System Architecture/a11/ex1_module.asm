bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s1 db "abc", 15, 30, 45
    len1 equ $-s1
    s2 db 20, 40, "def", 60; we declare the 2 strings
    len2 equ ($-s2)-s1
    result resb 6
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ECX, len2
        mov EAX, 0
        mov EBX, 0
        mov EDX, 0
        jecxz second_done
        
        second_string:; loop to get the decimal numbers from the seconds string
            cmp ecx, 0
            je second_done
            mov dl, [s2+ebx]
            cmp dl, 0d
            jge found_decimal
            inc ebx
        
        found_decimal:
            mov byte[result+ebx], dl
            inc ebx
            jmp second_string
            
        second_done:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
