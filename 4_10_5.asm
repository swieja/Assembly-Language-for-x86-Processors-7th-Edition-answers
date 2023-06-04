.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

; Write a program that uses a loop to calculate the first seven value of the 
; Fibonacci number sequence, described by the following formula Fib(1) = 1, Fib(2) = 1, Fib(n) = Fib(n – 1) + Fib(n – 2).
.data

.code 
main PROC	
	mov eax,1 
	mov ebx,0 
	mov edx,1
	mov ecx,6

L1:
	mov eax,ebx
	mov eax,edx
	mov ebx,edx
	mov edx,eax
	loop L1

	nop
	invoke ExitProcess,eax
main ENDP
END main