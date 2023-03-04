bits 32 ; assembling for the 32 bits architecture

; 3. Two byte strings S1 and S2 are given. Obtain the string D by concatenating the elements of S1 from the left hand side to the right hand side and the elements of S2 from the right hand side to the left hand side.



; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db '1', '2', '3', '4'
    f equ $-a ; equal to the length of a
    b db '5', '6', '7'
    e equ $-b ; equal to the length of b
    d times 1 db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ECX, f  ; we add the length of the first string in ECX as a counter
        mov ESI, 0
        jecxz End1
        Loop:
            mov al, [a+esi]   
            mov [d+esi], al ; we move each element in d
            inc esi
        loop Loop
        End1: ; Add the first string in the right order
        
        mov ECX, e ;  we add the length of the second string in ECX as a counter
        mov ESI, 0
        jecxz End2
        Loop2:
            mov al, [b+esi]
            mov [d+f+ecx-1], al; we move each element from left to right in data
            inc esi
        loop Loop2
        End2:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
