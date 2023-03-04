bits 32 ; assembling for the 32 bits architecture

; 18. Read a string of unsigned numbers in base 10 from keyboard. Determine the minimum value of the string and write it in the file min.txt (it will be created) in 16 base.

; declare the EntryPoint (a label defining the very first instruction of the program)
global _minValue      

; declare external functions needed by our program

; our data is declared here (the variables needed by our program)
segment data public data use32
    ; ...
    min dd 0
    aux dd 0
    
; our code starts here
segment code public code use32
    _minValue:
        ; ...
        push ebp
        mov ebp, esp
        
        mov eax, [ebp+4]
        mov ebx, 0
        
        
        compare:
            mov edx, [eax+ebx]
            inc ebx
            cmp edx, -1
            je final
            cmp EDX, [min]
            jl smaller
            jg greater
            mov edx, [min]
            jmp compare
            smaller:
                mov dword[aux], edx
                mov dword[min], edx
                mov edx, [aux]
            greater:
                mov dword[aux], edx
                mov dword[min], edx
                mov edx, [aux]
        loop compare
        
        final:
            mov eax, [min]
            mov esp, ebp
            pop ebp
            
            ret
