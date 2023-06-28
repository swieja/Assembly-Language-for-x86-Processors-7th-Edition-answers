INCLUDE Irvine32.inc

; Write a procedure named calc_row_sum that calculates the sum of a single row in a two-dimensional
; array of bytes, words, or doublewords. The procedure should have the following stack parame-
; ters: array offset, row size, array type, row index. It must return the sum in EAX. Use explicit
; stack parameters, not INVOKE or extended PROC. Write a program that tests your procedure
; with arrays of byte, word, and doubleword. Prompt the user for the row index, and display the
; sum of the selected row.


arr_length PROTO, pString:PTR DWORD	; pointer to an array

.data
someArray DWORD 10h, 20h, 30h, 40h, 50h
Rowsize = ($ - someArray)
				 DWORD 60h, 70h, 80h, 90h, 0A0h
				 DWORD 0B0h, 0C0h, 0D0h, 0E0h, 0F0h

row_index DWORD ?
max_row_index DWORD ?
sum DWORD ? 
promptEnterRowIndex BYTE "Please enter row index: ",0
promptWrongIndex BYTE "Wrong row index."
promptFinal BYTE "The sum of selected ROW is: ",0
.code
main PROC
	
	; get the amount of rows in array, for functional error checking
	mov esi, offset someArray
	invoke arr_length, esi ; get the array real length
	mov ebx, rowsize
	cdq
	div ebx ; divide the array length with rowsize to get the amount of rows
	sub eax,1 ; there are N rows but we start from 0 so we have to substract
	mov max_row_index,eax ; store in max_row_index

	;ask the user to provide row_index
	read:
		mov edx, offset promptEnterRowIndex
		call WriteString
		call ReadInt
		jno goodInput
		mov edx,offset promptWrongIndex
		call WriteString
		call Crlf
		jmp read

	goodInput:
		cmp eax, max_row_index
		ja read
		cmp eax,0
		jb read
		mov row_index,eax

	push row_index
	push Rowsize
	push offset someArray
	call calc_row_sum
	
	call Crlf
	mov edx, offset promptFinal
	call WriteString
	mov eax, sum
	call WriteInt


	call WaitMsg
	exit
main ENDP

calc_row_sum PROC
	push ebp
	mov ebp,esp
	pushad

	mov ebx, [ebp+ 8] ; array offset
	mov ecx, [ebp+ 12] ; Rowsize
	mov eax, [ebp+ 16] ; row_index

	mul ecx
	add ebx,eax

	mov esi,0
	mov eax,0

	L1:
		movzx edx,BYTE PTR[ebx+esi]
		add eax,edx
		inc esi
		loop L1

	mov sum,eax
	popad
	pop ebp
	ret 12
calc_row_sum ENDP


; Modified Str_length to calculate the size of multi dimensional array
arr_length PROC USES edi,
	pString:PTR DWORD

	mov edi,pString
	mov eax,0     	                
L1:
	cmp DWORD PTR [edi],0	      
	je  L2
	add edi, type pString
	add eax, type pString
	jmp L1
L2: ret
arr_length ENDP

END main