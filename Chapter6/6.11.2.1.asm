INCLUDE Irvine32.inc	

; Create a procedure that fills an array of doublewords with N random integers, making sure the
; values fall within the range j...k, inclusive. When calling the procedure, pass a pointer to the
; array that will hold the data, pass N, and pass the values of j and k. Preserve all register values
; between calls to the procedure. Write a test program that calls the procedure twice, using differ-
; ent values for j and k. Verify your results using a debugger


N = 13
.data
array DWORD 13 DUP(0)
j DWORD ?
k DWORD ? 
len DWORD N - 1
promptj BYTE "Please enter j: ",0
promptk BYTE "Please enter k: ",0
promptArrayBegin BYTE "Array: [ ",0
comma BYTE ", ",0
promptArrayEnd BYTE " ]",0


.code 
main PROC
	
	call fill
	call displayArray
	exit
main ENDP

fill PROC
	mov ecx, len
	mov esi, offset array
	call getInt

L1:
	mov eax, j
	mov eax, k
	call RandomRange
	cmp eax,0
	je L1
	mov [esi],eax
	add esi,4
	loop L1

	nop
	ret
fill ENDP
getInt PROC
	mov edx, offset promptj
	call WriteString
	call ReadInt
	mov j, eax
	call Crlf

	mov edx, offset promptk
	call WriteString
	call ReadInt
	mov k, eax
	call Crlf

	ret
getInt ENDP

displayArray PROC
	call Crlf
	mov edx, offset promptArrayBegin
	mov esi, offset array
	call WriteString
	mov ecx,len
L1:
	mov eax, [esi]
	call WriteInt
	mov edx, offset comma
	call WriteString
	add esi,4
	loop L1

	mov edx, offset promptArrayEnd
	call WriteString
	ret
displayArray ENDP

END main