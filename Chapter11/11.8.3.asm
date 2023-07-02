INCLUDE Irvine32.inc

; Write a program that creates a new text file. Prompt the user for a student identification number,
; last name, first name, and date of birth. Write this information to the file. Input several more
; records in the same manner and close the file

fillStudent PROTO fHandle: HANDLE, stringPTR: PTR BYTE, bufferPTR:PTR BYTE

DELIMETER = 44
BUFFER_SIZE = 500
.data
filename			BYTE "studentList.txt"
fileHandle			HANDLE ? 
stringLength		DWORD ? 
bytesWritten		DWORD ? 
buffer				BYTE BUFFER_SIZE DUP(0)
error1				BYTE "Cannot Create a file",0
strId				BYTE "Enter student's ID: ",0
strLName			BYTE "Enter student's last name: ",0
strFName			BYTE "Enter student's first name: ",0
strDate				BYTE "Enter student's date offset birth: ",0
newLine				BYTE 0dh,0ah,00h



.code
main PROC
	
	; Create a file
	mov edx, offset filename
	call CreateOutputFile
	mov fileHandle, eax

	; Check for errors
	cmp eax, INVALID_HANDLE_VALUE
	jne file_ok
	mov edx,offset error1
	call WriteString
	jmp quitProgram

	call CloseFile
	file_ok:
		
		INVOKE fillStudent, fileHandle, ADDR strId, ADDR buffer
		INVOKE fillStudent, fileHandle, ADDR strLName, ADDR buffer
		INVOKE fillStudent, fileHandle, ADDR strFName, ADDR buffer
		INVOKE fillStudent, fileHandle, ADDR strDate, ADDR buffer

		mov eax, fileHandle
		mov edx, offset newLine
		mov ecx, 2
		call WriteToFile

		INVOKE fillStudent, fileHandle, ADDR strId, ADDR buffer
		INVOKE fillStudent, fileHandle, ADDR strLName, ADDR buffer
		INVOKE fillStudent, fileHandle, ADDR strFName, ADDR buffer
		INVOKE fillStudent, fileHandle, ADDR strDate, ADDR buffer

		mov eax, fileHandle
		mov edx, offset newLine
		mov ecx, 2
		call WriteToFile

		INVOKE fillStudent, fileHandle, ADDR strId, ADDR buffer
		INVOKE fillStudent, fileHandle, ADDR strLName, ADDR buffer
		INVOKE fillStudent, fileHandle, ADDR strFName, ADDR buffer
		INVOKE fillStudent, fileHandle, ADDR strDate, ADDR buffer

	quitProgram:
		nop
		exit
main ENDP

fillStudent PROC fHandle: HANDLE, stringPTR: PTR BYTE, bufferPTR:PTR BYTE
	


	mov edx, stringPTR
	call WriteString

	mov ecx, BUFFER_SIZE
	mov edx, bufferPTR
	call ReadString

	mov esi, bufferPTR
	add esi, eax 
	mov byte ptr [esi], DELIMETER

	inc eax
	mov stringLength, eax
	mov eax, fHandle
	mov edx, bufferPTR
	mov ecx, stringLength
	call WriteToFile
	mov bytesWritten,eax

	ret
fillStudent ENDP

end main

