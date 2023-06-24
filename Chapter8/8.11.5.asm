INCLUDE Irvine32.inc

; Write a procedure named DifferentInputs that returns EAX = 1 if the values of its three input
; parameters are all different; otherwise, return with EAX = 0. Use the PROC directive with a
; parameter list when declaring the procedure. Create a PROTO declaration for your procedure,
; and call it five times from a test program that passes different inputs.

;Assembler specific directives
ReadInput PROTO pNumber1: PTR DWORD, pNumber2: PTR DWORD, pNumber3: PTR DWORD 
DifferentInputs PROTO input1: DWORD, input2: DWORD, input3: DWORD 

.data
someNumber1 DWORD 1
someNumber2 DWORD 1
someNumber3 DWORD 1
prompt1 BYTE "Number: ",0
promptBad BYTE "Invalid input, please enter again",0
promptSuccess BYTE "All inputs are different.",0


.code
main proc
	
	INVOKE ReadInput	,ADDR someNumber1, ADDR someNumber2, ADDR someNumber3
	INVOKE DifferentInputs ,someNumber1,someNumber2,someNumber3
	exit
main endp

DifferentInputs PROC uses ebx ecx edx, input1: DWORD, input2: DWORD, input3: DWORD 
	mov ebx, input1
	mov ecx, input2

	cmp ebx, input2
	je quitProgram
	cmp ebx, input3
	je quitProgram
	cmp ecx,input3
	je quitProgram
	jmp setEax
	
	setEax:
		mov eax,1
		mov edx, offset promptSuccess
		call WriteString
		call Crlf
		
	quitProgram:
		ret
DifferentInputs ENDP

ReadInput PROC uses ecx ebx, pNumber1: PTR DWORD, pNumber2: PTR DWORD, pNumber3: PTR DWORD 
	mov ebx, pNumber3
	mov ebx, pNumber2
	mov ebx, pNumber1

	
	mov ecx,3
	readLoop:	
		mov edx, offset prompt1
		call WriteString
		call ReadInt
		jno goodInput

		mov edx, offset promptBad
		call WriteString
		jmp readLoop
		
	goodInput:	
		mov [ebx], eax
		add ebx, TYPE DWORD
	
	loop readLoop
	ret
readInput ENDP

END main