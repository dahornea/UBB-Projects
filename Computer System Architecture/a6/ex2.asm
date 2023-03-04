bits 32 ; assembling for the 32 bits architecture

; 18. A string of doublewords is given. Order in increasing order the string of the high words (most significant) from these doublewords. The low words (least significant) remain unchange

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    string dd 12AB5678h, 1256ABCDh, 12344344h
    len equ ($-string)/4
    d resw 3
    result resd 3
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, string; we store in esi the offset of our string
        mov ecx, len
        mov ebx, 0
        loop1:
            lodsw
            lodsw; we get to the most significant word of the doubleword
            mov word[d+ebx], AX
            inc ebx
            inc ebx
        loop loop1; we store the high words of each doubleword in variable d
        
        ;now we create the sort loop
        mov dx, 1
        loop2:
            cmp dx, 0
            je end_loop
            
            mov esi, d
            mov dx, 0
            mov ecx, len-1
            
            repeat_for:
                mov ax, [esi]
                cmp ax, [esi+2]
                jle next
                    mov bx, [esi+2]
                    mov [esi], bx
                    mov [esi+2], ax
                    mov dx, 1
                next:
                inc esi
                inc esi
                loop repeat_for
                jmp loop2
        end_loop:
        
        ;now we make a loop to concatenate the new doublewords
        mov ecx, len
        
        mov ebx, 4h
        mov edx, 10
        std
        loop3:
            lodsw
            mov word[string+edx], AX
            sub edx, ebx
        loop loop3
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
