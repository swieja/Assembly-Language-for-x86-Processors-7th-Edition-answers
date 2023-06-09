INCLUDE Irvine32.inc

; Write a program that clears the screen, locates the cursor near the middle of the screen,
; prompts the user for two integers, adds the integers and displays their sum

.data
value1 DWORD ?
value2 DWORD ? 
sum DWORD ?

.code
main PROC
	call Clrscr
	call getInt

	mov eax,sum
	call WriteInt
	nop
main ENDP

getInt PROC
	call ReadInt
	mov value1, eax

	call ReadInt
	mov value2, eax

	mov eax,value2
	add eax,value1
	mov sum,eax

	ret
getInt ENDP

END main