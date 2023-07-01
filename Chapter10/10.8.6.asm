INCLUDE Irvine32.inc
INCLUDE Macros.inc

; Create a macro named mWriteInt that writes a signed integer to standard output by calling
; the WriteInt library procedure. The argument passed to the macro can be a byte, word, or
; doubleword. Use conditional operators in the macro so it adapts to the size of the argument.
; Write a program that tests the macro, passing it arguments of different sizes.

mWriteInt MACRO input
	LOCAL string1,string2,string3
	.data
	string1 BYTE "Provided is BYTE: ",0
	string2 BYTE "Provided is WORD:" ,0
	string3 BYTE "Provided is DWORD: ",0
	.code
	push edx
	push eax
	IF TYPE input LT WORD
		mov edx, offset string1
		call WriteString
		mov al, input
		call WriteInt
	ELSEIF TYPE input LT DWORD
		mov edx, offset string2
		call WriteString
		mov ax, input
		call WriteInt
	ELSE
		mov edx, offset string3
		call WriteString
		mov eax, input
		call WriteInt
	ENDIF
	call Crlf
	pop eax
	pop edx
ENDM

.data
someVal1 BYTE 12h
someVal2 WORD 3456h
someVal3 DWORD 78901234h

.code
main PROC
	
	mWriteInt someVal1
	mWriteInt someVal2
	mWriteInt someVal3

	nop
	exit
main ENDP

end main