bits 32 ; assembling for the 32 bits architecture

; 18. A text file is given. The text contains letters, spaces and points. Read the content of the file, determine the number of words and display the result on the screen. (A word is a sequence of characters separated by space or point)

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    file_name db "text.txt", 0
    access_mode db "r", 0; read access mode
    
    file_descriptor dd -1
    len equ 100
    text times len db 0; the variable in which we'll read the text from the file
    
    format db "There are %d words in the file", 0
    counter dw 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword access_mode
        push dword file_name
        call [fopen]; we open the file in read mode
        add esp, 4*2; clear the stack
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je final; if eax is 0 then we end the program because we got an error
        
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]; we start reading from the file. The number of characters will be stored in EAX
        
        mov ECX, eax
        mov ebx, 0
        mov edx, 0
        mov esi, 0
        jecxz end_space 
        
        check_space: ; loop to check for space
            cmp ecx, 0; we compare ecx to 0 to prevent the loop from running forever
            je end_space
            mov dl, [text+ebx]
            cmp dl, ' '
            je found_space
            inc ebx
        loop check_space
        
        found_space:
            inc esi; we increase esi if we find a space
            inc ebx
            jmp check_space
            
        end_space:
        
        mov ECX, eax; we move the length back into ecx to check the file again
        mov ebx, 0
        jecxz end_dot
        
        check_dot:; loop to check for the dots in the file
            mov dl, [text+ebx]
            cmp dl, '.'
            je found_dot
            inc ebx
        loop check_dot
        
        cmp ecx, 0; we compare ecx to 0 again to jump over "found_dot"
        je end_dot
        found_dot:
            inc esi; we increase esi if we find a dot
            inc ebx
            jmp check_dot
            
        end_dot:    
            
        add esp, 4*4
        push dword[file_descriptor]
        call [fclose]; we close the file
        add esp, 4
        
        ;Now we display the number
        final:
        push dword esi
        push dword format
        call [printf]; we call the printf function to display the number of words in our file
        
        add esp, 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
