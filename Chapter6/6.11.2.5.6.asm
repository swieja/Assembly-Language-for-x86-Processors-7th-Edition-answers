INCLUDE Irvine32.inc

;	Create a program that functions as a simple boolean calculator for 32-bit integers. It should dis-
;	play a menu that asks the user to make a selection from the following list:
;	1. x AND y
;	2. x OR y
;	3. NOT x
;	4. x XOR y
;	5. Exit program
;	When the user makes a choice, call a procedure that displays the name of the operation about to
;	be performed. You must implement this procedure using the Table-Driven Selection technique,
;	shown in Section 6.5.4. (You will implement the operations in Exercise 6.) (The Irvine32 library
;	is required for this solution program.)

.data
CaseTable BYTE '1'
				DWORD X_AND_Y
				BYTE '2'
				DWORD X_OR_Y
				BYTE '3'
				DWORD NOT_X
				BYTE '4'
				DWORD X_XOR_Y
				BYTE '5'
				DWORD EXITPROGRAM
NumberOfEntries = 5

promptChoice				BYTE "Choice: ",0
prompt_X_AND_Y		BYTE "1. x AND y",0
prompt_X_OR_Y			BYTE "2. x OR y",0
prompt_NOT_X			BYTE "3. NOT x",0
prompt_X_XOR_Y		BYTE "4. X XOR y",0
prompt_ExitProgram	BYTE "5. Exit program.",0

prompt_X BYTE "Please enter X : ",0
prompt_Y BYTE "Please enter Y : ",0

result BYTE "Result: ",0

X DWORD ? 
Y DWORD ? 

.code
main PROC 
	call displayMenu
	mov edx, OFFSET promptChoice
	call WriteString
	call ReadChar
	call Crlf 
	mov ebx, OFFSET CaseTable
	mov ecx, NumberOfEntries

L1:
	cmp al,[ebx]
	jne L2
	call NEAR PTR [ebx + 1]
	call Crlf
	jmp L3

L2:
	add ebx, 5
	loop L1
L3:
	exit
main endp	


;prompt_X BYTE "Please enter X : ",0
;prompt_Y BYTE "Please enter Y : ",0

X_AND_Y PROC
	mov edx, offset prompt_X
	call WriteString
	call ReadHex
	mov X,eax

	mov edx, offset prompt_Y
	call WriteString
	call ReadHex
	mov Y,eax
	mov eax,X

	and eax,Y

	mov edx, offset result 
	call WriteString 
	call WriteHex
	call Crlf


	ret
X_AND_Y ENDP

X_OR_Y PROC
	mov edx, offset prompt_X
	call WriteString
	call ReadHex
	mov X,eax

	mov edx, offset prompt_Y
	call WriteString
	call ReadHex
	mov Y,eax
	mov eax,X

	or eax,Y

	mov edx, offset result 
	call WriteString 
	call WriteHex
	call Crlf


	ret
X_OR_Y ENDP

NOT_X PROC
	mov edx, offset prompt_X
	call WriteString
	call ReadHex
	mov X,eax

	neg eax

	mov edx, offset result 
	call WriteString 
	call WriteHex
	call Crlf


	ret
NOT_X ENDP

X_XOR_Y PROC
	mov edx, offset prompt_X
	call WriteString
	call ReadHex
	mov X,eax

	mov edx, offset prompt_Y
	call WriteString
	call ReadHex
	mov Y,eax
	mov eax,X

	xor eax,Y

	mov edx, offset result 
	call WriteString 
	call WriteHex
	call Crlf


	ret
X_XOR_Y ENDP

EXITPROGRAM PROC
	ret
EXITPROGRAM ENDP

displayMenu PROC
	mov edx, offset prompt_X_AND_Y
	call WriteString
	call Crlf

	mov edx, offset prompt_X_OR_Y
	call WriteString
	call Crlf

	mov edx, offset prompt_NOT_X
	call WriteString
	call Crlf

	mov edx, offset prompt_X_XOR_Y
	call WriteString
	call Crlf

	mov edx, offset prompt_ExitProgram
	call WriteString
	call Crlf

	ret
displayMenu ENDP

END main