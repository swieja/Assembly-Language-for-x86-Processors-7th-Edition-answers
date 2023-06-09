INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD

; Direct recursion is the term we use when a procedure calls itself. Of course, you never want to let a procedure keep
; calling itself forever, because the runtime stack would fill up. Instead, you must limit the recursion in some way.
; Write a program that calls a recursive procedure. Inside this procedure, add 1 to a counter so you can verify the number
; of times it executed. Run your program with a debugger, and at the end of the program, check the counter's value.
; Using only the LOOP instruction (and no other conditional statements from laster chapters), find a way for the recursive
; procedeure to call itself a fixed number of times.

; The recursion was ran +6 times.
.data
sumCounter DWORD ?
prompt1 BYTE "The recursion was ran ",0
prompt2 BYTE " times.",0
newline BYTE 0Ah, 0

.code
main PROC
	mov ecx, 7; counter ecx for loop
	mov eax, 0; counter ebx for sumCounter

	call recursion
	mov edx, OFFSET prompt1
	call WriteString
	call WriteInt
	mov edx, OFFSET prompt2
	call WriteString
	mov edx, OFFSET newline
	call WriteString
	call WaitMsg
 	INVOKE ExitProcess,0	
main ENDP

recursion PROC
	loop L1
	ret
	L1:
		add eax,1
		call recursion
		ret

recursion ENDP

END main