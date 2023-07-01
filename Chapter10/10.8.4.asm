INCLUDE Irvine32.inc
INCLUDE Macros.inc

; Create a macro named mMult32 that multiplies two 32-bit memory operands and produces a
; 32-bit product. Write a program that tests your macro

mMult32 MACRO val1, val2
	LOCAL prompt,result
	.data
	resultPrompt BYTE "The result is: ",0
	result DWORD ? 
	.code
	push eax
	push ebx
	push ebx

	mov eax,val1
	mov ebx, val2
	mul ebx
	mov edx,offset resultPrompt
	call WriteString
	call WriteDec
	call Crlf
	
	pop ebx
	pop edx
	pop eax
ENDM

.data
someVal1 DWORD 34h
someVal2 DWORD 12h

.code
main PROC
	mMult32 someVal1, someVal2

	nop
	exit
main ENDP

end main