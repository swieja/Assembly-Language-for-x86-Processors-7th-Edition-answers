INCLUDE Irvine32.inc

; Implement your own version of the ReadString procedure, using stack parameters. Pass it a
; pointer to a string and an integer, indicating the maximum number of characters to be entered.
; Return a count (in EAX) of the number of characters actually entered. The procedure must input
; a string from the console and insert a null byte at the end of the string (in the position occupied
; by 0Dh). See Section 11.1.4 for details on the Win32 ReadConsole function. Write a short pro-
; gram that tests your procedure.

; lol

MAX_SIZE_BUFFER = 50
.data
buffer BYTE MAX_SIZE_BUFFER DUP(0)

.code
main PROC
	push offset buffer
	push MAX_SIZE_BUFFER
	call myReadString

	nop
	exit
main ENDP

myReadString PROC
	push ebp
	mov ebp,esp
	push ecx
	push edx

	mov ecx,[ebp+8]
	mov edx,[ebp+12]
	call ReadString
	
	pop edx
	pop ecx
	pop ebp
	ret 8 
myReadString ENDP
end main