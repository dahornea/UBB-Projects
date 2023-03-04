
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global module       


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    positive dd 0; variable in which we'll store the positive numbers
    negative dd 0; variable in which we'll store the negative numbers
; our code starts here

segment code use32 class=code
    module:
        ; ...
        
        mov ECX, eax
        mov ebx, 0
        mov eax, 0
        mov edx, 0
        
        check_sign:; loop to check whether a number is positive or negative
            cmp ecx, 0
            je final
            dec ecx
            mov dl, [text+ebx]
            cmp dl, ' '
            je found_space
            cmp dl, '-'
            je found_negative
            jne found_positive
            inc ebx
        loop check_sign

        found_negative:
            mov [negative+edx], dl
            inc ebx
            mov dl, [text+ebx]
            mov [negative+edx], dl
            inc ebx
            inc edx
            jmp check_sign
            
        found_positive:
            mov [positive+eax], dl
            inc ebx
            inc eax
            jmp check_sign
            
        found_space:
            inc ebx
            jmp check_sign
               
        final:
        ; exit(0)
        ret 24
