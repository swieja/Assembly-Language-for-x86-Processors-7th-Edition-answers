.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

PBYTE TYPEDEF PTR BYTE
PWORD TYPEDEF PTR WORD
PDWORD TYPEDEF PTR DWORD


.data
arrayB BYTE 10h,20h,30h
arrayW WORD 1,2,3
arrayD DWORD 4,5,6

ptr1 PBYTE arrayB
ptr2 PWORD arrayW
ptr3 PDWORD arrayD


.code 
main PROC   
	mov esi,ptr1
	mov al,[esi] ; al = 10h

	mov esi,ptr2
	mov ax,[esi] ; ax = 0001h

	mov esi,ptr3
	mov eax,[esi] ; eax = 00000004h



	xor ecx,ecx
	INVOKE ExitProcess,eax
main ENDP
END main