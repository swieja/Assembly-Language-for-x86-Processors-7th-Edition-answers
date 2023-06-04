.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

; Write a program that uses the variables below and MOV instructions to copy the value from
; bigEndian to littleEndian, reversing the order of the bytes. The number’s 32-bit value is under-
; stood to be 12345678 hexadecimal.

.data
bigEndian BYTE 12h,34h,56h,78h
littleEndian DWORD ?

.code 
main PROC	
	mov eax, 0
	mov al, byte ptr bigEndian + 3
	mov BYTE PTR littleEndian, al

	mov al, byte ptr bigEndian + 2
	mov BYTE PTR littleEndian + 1 , al

	mov al, byte ptr bigEndian + 1
	mov BYTE PTR littleEndian + 2 , al

	mov al, byte ptr bigEndian
	mov BYTE PTR littleEndian + 3, al
	; 0x00404000  12 34 56 78 78 56 34 12 00 00  .4VxxV4...
	nop
	invoke ExitProcess,eax
main ENDP
END main