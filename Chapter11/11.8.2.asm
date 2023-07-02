INCLUDE Irvine32.inc

; Write a program that inputs the following information from the user, using the Win32 Read-
; Console function: first name, last name, age, phone number. Redisplay the same information
; with labels and attractive formatting, using the Win32 WriteConsole function. Do not use any
; procedures from the Irvine32 library.

fillPerson PROTO, InputMessageDisplay: PTR BYTE, InputMessageSize: DWORD, structField:PTR BYTE
displayPerson PROTO, structField: PTR BYTE, sizeOfStruct: DWORD

BUFFER_SIZE = 256
BUFFER_SIZE_AGE = 8

PERSON struct 
	s_fName			BYTE BUFFER_SIZE		DUP(0)
	s_lName			BYTE BUFFER_SIZE		DUP(0)
	s_phoneNumber	BYTE BUFFER_SIZE		DUP(0)
	s_age			BYTE BUFFER_SIZE_AGE	DUP(0)
PERSON ENDS

.data
fNameInput  BYTE "Please provide you first name: ",0
fNameInput_messageSize DWORD ($ - fNameInput)
lNameInput  BYTE "Please provide you last name: ",0
lNameInput_messageSize DWORD ($ - lNameInput)
ageInput	BYTE "Please provide you age: ",0
ageInput_messageSize DWORD ($ - ageInput)
phoneNnmber BYTE "Please provide you phone number: ",0
phoneNnmber_messageSize DWORD ($ - phoneNnmber)

stdHandle		HANDLE ?
bytesRead		DWORD ? 
bytesWritten	DWORD ? 
somePerson		PERSON <>


.code
main PROC
	
	INVOKE fillPerson, ADDR fNameInput, fNameInput_messageSize, ADDR somePerson.s_fName
	INVOKE fillPerson, ADDR lNameInput, lNameInput_messageSize, ADDR somePerson.s_lName
	INVOKE fillPerson, ADDR ageInput, ageInput_messageSize, ADDR somePerson.s_age
	INVOKE fillPerson, ADDR phoneNnmber, phoneNnmber_messageSize, ADDR somePerson.s_phoneNumber

	call Crlf
	INVOKE displayPerson, ADDR somePerson.s_fName, lengthof somePerson.s_fName
	INVOKE displayPerson, ADDR somePerson.s_lName, lengthof somePerson.s_lName
	INVOKE displayPerson, ADDR somePerson.s_age, lengthof somePerson.s_age
	INVOKE displayPerson, ADDR somePerson.s_phoneNumber, lengthof somePerson.s_phoneNumber

	
	nop
	exit
main ENDP

fillPerson PROC uses eax, InputMessageDisplay: PTR BYTE, InputMessageSize: DWORD, structField:PTR BYTE

	INVOKE GetStdHandle, STD_OUTPUT_HANDLE 
	mov stdHandle,eax
	INVOKE WriteConsole, stdHandle, InputMessageDisplay, InputMessageSize, ADDR bytesWritten,0 
	
	INVOKE GetStdHandle, STD_INPUT_HANDLE 
	mov stdHandle,eax
	INVOKE ReadConsole, stdHandle, structField, BUFFER_SIZE, ADDR bytesRead, 0

	ret
fillPerson ENDP

displayPerson PROC uses eax, structField: PTR BYTE, sizeOfStruct: DWORD

	INVOKE GetStdHandle, STD_OUTPUT_HANDLE 
	mov stdHandle,eax
	INVOKE WriteConsole, stdHandle, structField, sizeOfStruct , ADDR bytesWritten,0

	ret
displayPerson ENDP

end main

