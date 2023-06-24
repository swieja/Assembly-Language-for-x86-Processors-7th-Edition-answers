INCLUDE Irvine32.inc

; Write a recursive implementation of Euclid’s algorithm for finding the greatest common divisor
; (GCD) of two integers. Descriptions of this algorithm are available in algebra books and on the
; Web. Write a test program that calls your GCD procedure five times, using the following pairs of
; integers: (5,20), (24,18), (11,7), (432,226), (26,13). After each procedure call, display the GCD.

.data
num1 DWORD ?
num2 DWORD ? 

.code
main PROC
    mov num2, 20d
    mov num1, 5d
    push num2
    push num1
    call gcd

    mov num2, 18d
    mov num1, 24d
    push num2
    push num1
    call gcd

    mov num2, 7d
    mov num1, 11d
    push num2
    push num1
    call gcd

    mov num2, 226d
    mov num1, 432d
    push num2
    push num1
    call gcd

    mov num2, 13d
    mov num1, 26d
    push num2
    push num1
    call gcd


    
    call WaitMsg
    ret

main ENDP

gcd PROC
    push ebp
    mov ebp, esp

    ; Arguments:
    ; [ebp+8] - first number (num1)
    ; [ebp+12] - second number (num2)

    mov eax, [ebp+8]    
    mov ebx, [ebp+12]  

gcd_loop:
    cmp eax, ebx     
    jz gcd_done       

    jl swap_nums     

    sub eax, ebx      
    jmp gcd_loop     

swap_nums:
    xchg eax, ebx     
    jmp gcd_loop     

gcd_done:
    ; gcd in eax
    call WriteInt
    call Crlf
    pop ebp
    ret 8
gcd ENDP
END main
