INCLUDE Irvine32.inc

; Create a procedure named Extended_Sub that subtracts two binary integers of arbitrary size.
; The storage size of the two integers must be the same, and their size must be a multiple of 32 bits
; Write a test program that passess several pairs of integers, each at least 10 bytes long.

.data
op1 BYTE 34h,56h,78h,01h,23h,45h,67h,89h,12h,88h
op2 BYTE 02h,45h,21h,33h,21h,11h,94h,12h,33h,33h
result BYTE 10 dup(0)

.code
main PROC
	mov esi, offset op1
	mov edi, offset op2
	mov ebx, offset result
	mov ecx, LENGTHOF op1
	call Extended_Sub

	mov esi, offset result
	mov ecx, lengthof result
	call Display_result
	call Crlf
	exit
main ENDP

Extended_Sub PROC
	pushad
	clc
	L1:
		mov al,[esi]
		sbb al,[edi]
		pushfd
		mov [ebx],al
		add esi,1
		add edi,1
		add ebx,1
		popfd
		loop L1

	mov byte ptr[ebx],0 
	sbb byte ptr[ebx],0 
	popad
	ret
Extended_Sub ENDP

Display_result PROC
	pushad	
	add esi, ecx
	sub esi, TYPE BYTE
	mov ebx, TYPE BYTE

	L1:
		mov al,[esi]
		call WriteHexB
		sub esi, TYPE BYTE
		loop L1

	popad
	ret
Display_result ENDP

END main