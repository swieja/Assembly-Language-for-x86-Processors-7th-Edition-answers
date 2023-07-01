INCLUDE Irvine32.inc
INCLUDE Macros.inc

; (Requires reading ahead to Section 11.1.11.) Create a macro that writes a null-terminated string to
; the console with a given text color. The macro parameters should include the string name and the
; color. Hint: Call SetTextColor from the book’s link library. Write a program that tests your macro
; with several strings in different colors. Sample call:

mWriteTestString MACRO stringToBePrinted, color
	push eax
	push edx

	mov eax, color
	call SetTextColor
	mov edx, offset stringToBePrinted
	call WriteString
	call Crlf

	pop edx
	pop eax
ENDM

.data
myString BYTE "This is a test string",0

.code
main PROC
	
	mWriteTestString myString, yellow
	mWriteTestString myString, blue
	mWriteTestString myString, red
	mWriteTestString myString, green

	nop
	exit
main ENDP

end main