.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

; Write a program with a loop and indexed addressing that calculates the sum of 
; all the gaps between successive array elements. The array elements are doublewords,
; sequences in nondecreasing order. So for example the aray {0,2,5,9,10} has gaps 
; of 2,3,4 and 1, whose sum equals 10.

.data
dArray DWORD 0,2,5,9,10
.code 
main PROC	
	mov ecx, LENGTHOF dArray - 1
	mov ebx, OFFSET dArray
	mov eax,0 ; sum

L1:
	mov edx, [ebx+4]
	sub edx, [ebx]
	add ebx, 4
	add eax, edx
	loop L1

 	nop
	invoke ExitProcess,eax
main ENDP
END main