bits 32 ; assembling for the 32 bits architecture

;3. An array of doublewords, where each doubleword contains 2 values on a word (unpacked, so each nibble is preceded by a 0) is given. Write an asm program to create a new array of bytes which contain those values (packed on a single byte), arranged in an ascending manner in memory, these being considered signed numbers.


; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    array dd 0702090Ah, 0B0C0304h, 05060108h
    len equ ($-array)/2
    mov EDX, 0h
    result dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, array
        cld
        mov ecx, len
        
        Loop1:
            lodsw; we move into AX the least significant word of the doubleword
            mov dl, 
        loop Loop1
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
