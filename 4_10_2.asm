.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

; Write a program with a loop and indexed addressing that exchanges every pair 
; of values in an array with an even number of elements. Therefore, item i will 
; exchange with item i+1, and item i+2 will exchange with item i+3 and so on.

.data
bArray BYTE 12h,34h,56h,78h
bString BYTE "AAAAAAAAAAA",0
expectedArray BYTE 34h, 12h, 78h, 56h
.code 
main PROC	
	mov ecx, LENGTHOF bArray/2
	mov ebx, OFFSET bArray
	mov eax ,0
	
L1:
	mov al,[ebx] 
	xchg	[ebx+1], al 
	mov [ebx],al 
	add ebx,2
	loop L1

	nop
	invoke ExitProcess,eax
main ENDP
END main