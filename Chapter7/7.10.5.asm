INCLUDE Irvine32.inc

; Write a program that generates all prime numbers between 2 and 1000, using the Sieve of Era-
; tosthenes method. You can find many articles that describe the method for finding primes in this
; manner on the Internet. Display all the prime values.

.data
    buffer BYTE 1000 DUP(0)

.code
main PROC
    mov esi,OFFSET buffer
    MOV ECX, 2     ; Initialize loop counter

check_prime:
    MOV EBX, 2     ; Initialize divisor

divisible:
    MOV EDX, 0
    MOV EAX, ECX
    DIV EBX
    CMP EDX, 0
    JE not_prime

    INC EBX        ; Increment divisor
    CMP EBX, ECX
    JL divisible

    ; Number is prime, print it
    
    mov [esi],ecx
    add esi, type buffer
    mov eax,ecx
    call WriteInt
    call Crlf
    
    INC ECX        ; Move to the next number
    CMP ECX, 1000
    JLE check_prime

    JMP done

not_prime:
    INC ECX        ; Move to the next number
    CMP ECX, 1000
    JLE check_prime

done:
    CALL WaitMsg
    EXIT
main ENDP

END main
