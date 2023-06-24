INCLUDE Irvine32.inc

; Create a procedure named FindThrees that returns 1 if an array has three consecutive values of
; 3 somewhere in the array. Otherwise, return 0. The procedure’s input parameter list contains a
; pointer to the array and the array’s size. Use the PROC directive with a parameter list when
; declaring the procedure. Preserve all registers (except EAX) that are modified by the procedure.
; Write a test program that calls FindThrees several times with different arrays

FindThrees PROTO pArray: PTR DWORD, arrayLength: DWORD

COMMA = 44
.data
array1 SDWORD 8, 7, 7, 5, 4, 3, 4, 3, 5, 8, 6, 4, 8, 1, 2
array2 SDWORD 5, 3, 4, 5, 4, 3, 2, 1, 8, 7, 5, 1, 5, 7, 4
array3 SDWORD 3, 2, 6, 1, 5, 1, 8, 3, 8, 1, 8, 5, 7, 4, 4
array4 SDWORD 3, 2, 6, 1, 5, 1, 8, 3, 8, 3, 3, 3, 7, 4, 4
prompt1 BYTE "This array has 3 consecutive values of 3 in the array and is located at: 0x",0

.code
main proc
	
	INVOKE FindThrees	, offset array1,  lengthof array1
	INVOKE FindThrees	, offset array2,  lengthof array2
	INVOKE FindThrees	, offset array3,  lengthof array3
	INVOKE FindThrees	, offset array4,  lengthof array4

	call WaitMsg
	exit
main endp

FindThrees PROC uses esi ecx ebx , pArray: PTR DWORD, arrayLength: DWORD
	push esi
	push ecx
	push ebx 
	 
	mov esi, pArray
	mov ecx, 0
	add ecx, arrayLength
	sub ecx,2 

	;this is so scuffed lol
	mainLoop:
		dec ecx
		cmp ecx, 0
		je quitProc
		mov ebx,[esi]
		cmp ebx,3d
		je isThree
		add esi,4
		jmp mainLoop
		
	isThree:
		add esi,4
		cmp ebx,[esi]
		jne mainLoop
		cmp ebx,[esi + 4]
		jne mainLoop
		jmp ThreeFound

	ThreeFound:
		mov edx, offset prompt1
		call WriteString
		mov eax, pArray
		call WriteHex
		call Crlf
		mov esi, pArray
		mov ecx, arrayLength
			L1:
				mov eax, [esi]
				call WriteInt
				add esi, TYPE DWORD
				mov al, COMMA
				call WriteChar
				loop L1
	jmp quitProc


	quitProc:
	pop ebx
	pop ecx
	pop esi
	ret
FindThrees endp

END main