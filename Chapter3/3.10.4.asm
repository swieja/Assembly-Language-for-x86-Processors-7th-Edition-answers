INCLUDE Irvine32.inc


; Write a program that defines symbolic names for several string literals
; (characterts between quotes). Use each symbolic name in a variable definition

.data
    symbol1 BYTE "Hello",0
    symbol2 BYTE "World",0
    symbol3 BYTE "Assembly",0

    myString1 BYTE "Symbolic Name 1: ", 0
    myString2 BYTE "Symbolic Name 2: ", 0
    myString3 BYTE "Symbolic Name 3: ", 0

.code
main PROC
    ; Display the strings with symbolic names
    ; WriteString takes EDX as an arg which points to a string
    mov edx, OFFSET myString1 ; obtain offset of myString1 and load to edx
    call WriteString ; call writestring which takes EDX as an arg
    mov edx, OFFSET symbol1
    call WriteString

    mov edx, OFFSET myString2
    call WriteString
    mov edx, OFFSET symbol2
    call WriteString

    mov edx, OFFSET myString3
    call WriteString
    mov edx, OFFSET symbol3
    call WriteString

    ; Exit the program
    INVOKE ExitProcess, 0
main ENDP

END main
