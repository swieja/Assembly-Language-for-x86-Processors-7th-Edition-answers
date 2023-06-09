.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

; Use a loop with indirect or indexed addressing to reverse the elements of an integer
; array in place. Do not copy the elements to any other array. Use the SIZEOF, TYPE,
; and LENGTHOF operators to make the program as flexible as possible if the array
; size and type should be changed in the future.

.data
bArray BYTE 1,2,3,6,8,9

.code 
main PROC	
	mov ecx, LENGTHOF bArray / 2 ; iteration in loop
	mov ebx, OFFSET bArray ; address of the first element [0] in bArray
	mov esi, ebx ; preparing edx to be a pointer to the last element of bArray
	add esi,SIZEOF bArray - TYPE bArray ; edx points to the last element of bArray
	 
L1:
	mov al, BYTE PTR[ebx] ; passing first element to eax
	mov dl, BYTE PTR[esi] ; passing last element to edx

	mov [ebx],dl
	mov [esi],al

	add ebx,TYPE bArray
	sub esi,TYPE bArray
	loop L1

	invoke ExitProcess,edx
main ENDP
END main