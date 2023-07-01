INCLUDE Irvine32.inc
INCLUDE Macros.inc

; Create a macro named mReadInt that reads a 16- or 32-bit signed integer from standard input and
; returns the value in an argument. Use conditional operators to allow the macro to adapt to the size
; of the desired result. Write a program that tests the macro, passing it operands of various sizes.
mReadInt MACRO input
	LOCAL string1,string2
	.data
	string1 BYTE "Provided input &input is WORD.",0
	string2 BYTE "Provided input &input is DWORD.",0
	.code
	push edx

	IF TYPE input LT TYPE DWORD
		mov edx, offset string1
		call WriteString
	ELSE
		mov edx, offset string2
		call WriteString
	ENDIF

	call Crlf
	pop edx
ENDM


.data
someVal1 WORD 1234h
someVal2 DWORD 5678h

.code
main PROC
	nop
	mReadInt  someVal1
	nop
	mReadInt  someVal2

	nop
	exit
main ENDP

end main