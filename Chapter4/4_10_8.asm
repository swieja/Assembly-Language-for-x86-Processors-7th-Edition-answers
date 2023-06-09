.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

; Using a loop and indexed addressing, write code that rotates the members
; of a 32 bit integer array forward one position. The value at the end of the array must 
; wrap around to the first position. For example, the array [10,20,30,40]
; would be transformed into [40,10,20,30]

.data
array1 BYTE 10h,20h,30h,40h,50h,60h,70h,80h

.code 
main PROC	
	mov esi, offset array1 ; first element of array1
	mov edi, offset array1 + type array1 ; second element of array1 
	mov eax, [esi] ; eax = 10
	mov ecx, lengthof array1 - 1 ; ecx = 3 

L1:
	mov bl, BYTE PTR [edi]
	xchg bl, al
	mov BYTE PTR[edi], bl
	add edi, type array1
	loop L1

	mov array1, al

	nop
main ENDP
END main