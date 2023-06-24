INCLUDE Irvine32.inc

; Write a procedure named ShowParams that displays the address and hexadecimal value of the
; 32-bit parameters on the runtime stack of the procedure that called it. The parameters are to be
; displayed in order from the lowest address to the highest. Input to the procedure will be a single
; integer that indicates the number of parameters to display. For example, suppose the following
; statement in main calls MySample, passing three arguments:
; INVOKE MySample, 1234h, 5000h, 6543h
; 
; Next, inside MySample, you should be able to call ShowParams, passing the number of param-
; eters you want to display:
; MySample PROC first:DWORD, second:DWORD, third:DWORD
; paramCount = 3
; call ShowParams, paramCount
; ShowParams should display output in the following format:
; Stack parameters:
; ---------------------------
; Address 0012FF80 = 00001234
; Address 0012FF84 = 00005000
; Address 0012FF88 = 00006543

MySample PROTO first:DWORD, second:DWORD, third:DWORD


SPACE = 20h
.data
paramCount = 3
promptStack BYTE "Stack parameters: ",0
promptDash BYTE "--------------------",0
promptAddress BYTE "Address ",0
promptEquals BYTE " = ",0
sometest DWORD ?

.code
main PROC
	INVOKE MySample, 1234h, 5000h, 6543h

	exit
main ENDP

MySample PROC first:DWORD, second:DWORD, third:DWORD
	
	push third
	push second
	push first
	push paramCount
	call ShowParams	

	ret
MySample ENDP

ShowParams PROC
	push ebp
	mov ebp,esp
	pushad

	mov ecx, [ebp + 8]; ecx must be max 3 
	lea ebx, [ebp + 12]

	; print the header
	mov edx, offset promptStack
	call WriteString
	call Crlf
	mov edx, offset promptDash
	call WriteString
	call Crlf
	L1:
		; print the Address
		mov edx, offset promptAddress
		call WriteString
		mov eax, ebx
		call WriteHex

		; print the dereferenced value
		mov edx, offset promptEquals
		call WriteString
		mov eax, [ebx]
		call WriteHex
		call Crlf

		; increment the stack 
		add ebx,4
		loop L1

	popad
	pop ebp
	ret 16
ShowParams ENDP

END main