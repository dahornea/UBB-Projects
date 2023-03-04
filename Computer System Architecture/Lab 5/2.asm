bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data


segment code use32 class=code
    start:
        ;A sequence of bytes is given. Find the last character "0".
        ;... all data about the "destination" string is loaded
        MOV AL, '0'
        MOV ECX, lung_sir
        STD
        Cont_caut: ;continue search...
            SCASB
            JE Found
        LOOP Cont_caut
        ;...
        Found:
            INC EDI;I return to the character found before EDI was decremented 

        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
