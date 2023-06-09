INCLUDE Irvine32.inc
; Write a program that displays the same string in four different colors, using a loop.
; Call the SetTextColor procedure from the book's link library. 
; Any colors may be chones, but you may find it easiest to change the foreground color.

.data
SomeString BYTE "# I am cool #",0

.code
main PROC
    mov ecx,4
    mov eax, 0
L1:
    
    add eax, 8
    call SetTextColor
    mov edx, OFFSET SomeString
    call WriteString 
    loop L1

    nop
    INVOKE ExitProcess, 0
main ENDP

END main
