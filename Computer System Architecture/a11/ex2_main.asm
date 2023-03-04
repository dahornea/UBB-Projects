bits 32 ; assembling for the 32 bits architecture

; 18.Read from file numbers.txt a string of numbers (positive and negative). Build two strings using readen numbers:
;   P – only with positive numbers
;   N – only with negative numbers
;   Display the strings on the screen.

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf  ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
extern module

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    file_name db "numbers.txt", 0
    access_mode db "r", 0
    file_descriptor dd -1
    len equ 100
    text times len db 0; the variable in which we'll read the text from the file
    
    format_positive db "P: %s", 0
    format_negative db "N: %s", 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2; clear the stack
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je final
        
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        
        push dword[text]
        call module
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
