INCLUDE Irvine32.inc

; Write a procedure named BitwiseMultiply that multiplies any unsigned 32-bit integer by
; EAX, using only shifting and addition. Pass the integer to the procedure in the EBX register,
; and return the product in the EAX register. Write a short test program that calls the procedure
; and displays the product. (We will assume that the product is never larger than 32 bits.) This is
; a fairly challenging program to write. One possible approach is to use a loop to shift the mul-
; tiplier to the right, keeping track of the number of shifts that occur before the Carry flag is set.
; The resulting shift count can then be applied to the SHL instruction, using the multiplicand as
; the destination operand. Then, the same process must be repeated until you find the last 1 bit
; in the multiplier.


.data
val1 dword 333d
val2 dword 76d
product dword 0d

.code
main PROC

	call MulByAddition

	call WaitMsg
	exit
main ENDP

MulByAddition proc
	pushad

	mov edi, 0; counter for SHL multiplier
	mov ebx, val1; multiplicand
	clc
	L1:
		cmp bx,0
		je asd
		mov ecx, edi
		clc; set CF = 0 before performing SHR opration
		shr ebx, 1; multiplicand shifted to the right, if CF=1, then SHL eax
		jnc L2
		mov eax, val2; multiplier
		shl eax, cl
		add product, eax
		L2:
			inc edi
			jmp L1
	
	asd:
	popad
	ret
MulByAddition endp

END main