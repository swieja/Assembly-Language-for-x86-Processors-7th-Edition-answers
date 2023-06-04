.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

; Write a prgoram with a loop and indirect addressing that copies a string from
; source to target, reversing the character order in the process. use the following
; variables

.data
source BYTE "This is the source string",0
target BYTE SIZEOF source DUP('#')

.code 
main PROC	
	mov esi,0 ; starting index
	mov edx, SIZEOF source - 1 ; last index - null terminator
	mov ecx,SIZEOF source ; size/length

L1:
	mov al,source[edx]
	mov target[esi],al
	inc esi
	dec edx
	loop L1

	nop
	invoke ExitProcess,edx
main ENDP
END main