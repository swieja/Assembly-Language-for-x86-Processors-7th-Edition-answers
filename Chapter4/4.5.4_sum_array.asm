.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
intArray DWORD 10000h,20000h,30000h,40000h

.code 
main PROC   
	mov edi, OFFSET intArray ; edi = address of intArray
	mov ecx, LENGTHOF intArray ; ecx = length of intArray (ecx = how many times will our loop run)
	mov eax,0 ; sum of elements in intArray

L1:
	add eax,[edi] ; add value pointer by edi (address of intArray)
	add edi, TYPE intArray ; add 4 bytes to edi to point to the next index in intArray
	loop L1 ; repeat

	invoke ExitProcess,eax
main ENDP
END main