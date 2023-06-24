INCLUDE Irvine32.inc

; Create an array of randomly ordered integers. Using the Swap procedure from Section 8.4.6 as a
; tool, write a loop that exchanges each consecutive pair of integers in the array.

COMMA = 44
.data
someArray DWORD 1,0,3,2,5,4,7,6,9,8
len DWORD lengthof someArray / 2
prompt1 BYTE "Sorted Array: ",0
.code
main proc
	
	push offset someArray
	push len
	call SwapInteger	

	mov edx,offset prompt1
	call WriteString
	mov ecx, lengthof someArray
	mov esi, offset someArray
	L1:
		mov eax, [esi]
		call WriteInt
		mov al, COMMA
		call WriteChar
		add esi,4
		loop L1

	exit
main endp

SwapInteger PROC
	push ebp
	mov ebp,esp
	pushad
	
	mov esi, [ebp + 12]
 	mov ecx, [ebp + 8]

	swapLoop:
		mov eax,[esi]
		mov edx,[esi+4]
		xchg	eax,edx
		mov [esi],eax
		mov [esi+4],edx
		add esi, 8
		loop swapLoop

	popad
	pop ebp
	ret 8
SwapInteger ENDP
	
END main