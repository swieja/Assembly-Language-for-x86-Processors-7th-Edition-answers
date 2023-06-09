INCLUDE Irvine32.inc

; Write a program that clears the screen, locates the cursor near the middle of the screen,
; prompts the user for two integers, adds the integers and displays their sum

.data
value1 DWORD ?
value2 DWORD ? 
value3 DWORD ? 
sum DWORD 0

.code
main PROC
	call Clrscr
	call getInt

	mov eax,sum
	call WriteInt
	nop
	INVOKE ExitProcess,0
main ENDP

getInt PROC
	mov esi,OFFSET value1
	mov ecx,3
L1:
	call ReadInt
	mov [esi],eax
	mov eax,0
	add DWORD PTR eax,[esi]
	add sum,eax
	add esi,4
	call Clrscr
	loop L1

	ret
getInt ENDP

END main