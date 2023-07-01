INCLUDE Irvine32.inc
INCLUDE Macros.inc

; Write a macro named mMove32 that receives two 32-bit memory operands. The macro should
; move the source operand to the destination operand. Write a program that tests your macro.

mMove32 macro source,target
	push	eax

	mov eax, source
	mov target, eax

	pop eax
ENDM


.data
src DWORD 12345678h
trg DWORD ? 

.code
main PROC
	
	mMove32 src,trg

	nop
	exit
main ENDP

end main