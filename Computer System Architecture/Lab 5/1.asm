bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
	sir_sursa dw 'a', 'b'
	dim_sir equ ($-sir_sursa)/2
    sir_dest resw dim_sir

segment code use32 class=code
    start:
        ;We have a source string of words. Copy this string into another string. We assume we know the length of this string.
        mov ECX, dim_sir ; no of elements in string
        mov ESI, sir_sursa ; load offset sir_sursa in ESI
        mov EDI, sir_dest ; load offset sir_dest in EDI
        CLD
        Again:
            MOVSW
        LOOP Again
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
