.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

; Write a program that uses a loop to copy all the elements from an unsigned 
; WORD (16-bit) array into an unsigned doubleword (32-bit) array

.data
wArray WORD 2,4,6,8,9
empty BYTE "AAAAAA"
dwTarget DWORD SIZEOF wArray DUP(0)

.code 
main PROC	
	mov ecx, LENGTHOF wArray
	mov edx, OFFSET wArray
	mov ebx, OFFSET dwTarget

L1:
	mov eax, [edx]
	mov [ebx], ax
	add edx,2
	add ebx,4
	loop L1

 	nop
	invoke ExitProcess,eax
main ENDP
END main