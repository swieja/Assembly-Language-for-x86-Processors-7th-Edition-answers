INCLUDE Irvine32.inc
INCLUDE Macros.inc

; Create a macro that waits for a keystroke and returns the key that was pressed. The macro
; should include parameters for the ASCII code and keyboard scan code. Hint: Call ReadChar
; from the book’s link library. Write a program that tests your macro. For example, the follow-
; ing code waits for a key; when it returns, the two arguments contain the ASCII code and scan
; code:

mReadKey MACRO 
	LOCAL scan,ascii,prompt
	.data
	scanb BYTE ? 
	asciib BYTE ? 
	promptHEX BYTE "The hex value: ",0
	promptASCII BYTE "The ASCII value: ",0
	.code
	push edx
	push eax
	xor eax,eax
	call ReadChar
	mov scanb,al
	mov asciib,al

	mov edx, offset promptHEX
	call WriteString
	call WriteChar
	call Crlf

	mov ebx, TYPE BYTE
	mov edx, offset promptASCII
	call WriteString
	call WriteHexB
	call Crlf	
ENDM

.code
main PROC

	mReadKey	

	nop
	exit
main ENDP

end main