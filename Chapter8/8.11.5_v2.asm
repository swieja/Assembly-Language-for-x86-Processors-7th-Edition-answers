INCLUDE Irvine32.inc

; Write a procedure named DifferentInputs that returns EAX = 1 if the values of its three input
; parameters are all different; otherwise, return with EAX = 0. Use the PROC directive with a
; parameter list when declaring the procedure. Create a PROTO declaration for your procedure,
; and call it five times from a test program that passes different inputs.

; PUSHAD / POPAD 
.data
someNumber1 DWORD 1
someNumber2 DWORD 1
someNumber3 DWORD 1
prompt1 BYTE "Number: ",0
promptBad BYTE "Invalid input, please enter again",0
promptSuccess BYTE "All inputs are different.",0


.code
main proc
	push offset someNumber3
	push offset someNumber2
	push offset someNumber1
	call ReadInput

	push someNumber1
	push someNumber2
	push someNumber3
	call DifferentInputs	

	call WaitMsg
	exit
main endp

DifferentInputs PROC
	push ebp
	mov ebp,esp
	pushad

	mov ebx, [ebp + 8]
	mov ecx, [ebp + 12]

	cmp ebx,ecx
	je quitProgram
	cmp ebx, [ebp + 16]
	je quitProgram
	cmp ecx, [ebp + 16]
	je quitProgram
	jmp setEax

	setEax:
		mov eax,1
		mov edx, offset promptSuccess
		call WriteString
		call Crlf

	quitProgram:
	popad
	pop ebp
	ret 12
DifferentInputs ENDP

ReadInput PROC 
	push ebp
	mov ebp,esp
	pushad
	mov ecx,3  ; loop counter

	mov ebx, [ebp + 8]
	readLoop:
		mov edx, offset prompt1
		call WriteString
		call ReadInt
		jno goodInput

		mov edx, offset promptBad
		call WriteString
		
	goodInput:
		mov [ebx], eax
		add ebx,TYPE DWORD

	loop readLoop
	popad
	pop ebp
	ret 12
readInput ENDP

END main