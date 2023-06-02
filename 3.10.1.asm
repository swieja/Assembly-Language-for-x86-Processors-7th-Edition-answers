.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

; Using the AddTwo program from Section 3.2 as reference,
; write a program that calculates the following expression, using
; registers: a = (a+b)-(a-c). Assign integer values to the EAX,
; EBX, ECX and EDX registers.

.code
main PROC

	mov edx,10
    mov ecx,15
    mov ebx,20
    mov eax,25

    add ecx,edx
    add eax,ebx

    sub eax,ecx

	INVOKE ExitProcess, 0

main ENDP

END main