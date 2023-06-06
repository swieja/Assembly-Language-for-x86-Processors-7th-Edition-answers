.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
dArray DWORD 1,2,3,4,5,6,7,8,9
dArraySum DWORD ?

.code 
main PROC	
	mov eax, OFFSET dArray
	mov ecx, LENGTHOF dArray
	call ArraySum	
	mov dArraySum,edx
	nop
	INVOKE ExitProcess,0
main ENDP

ArraySum PROC USES eax ecx
	mov edx,0

L1:
	add edx,[eax]
	add eax, TYPE DWORD
	loop L1

	ret
ArraySum ENDP

END main