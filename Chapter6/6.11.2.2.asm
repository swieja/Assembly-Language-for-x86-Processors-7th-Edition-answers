INCLUDE Irvine32.inc	

; Create a procedure that returns the sum of all array elements falling within the range j...k (inclu-
; sive). Write a test program that calls the procedure twice, passing a pointer to a signed double-
; word array, the size of the array, and the values of j and k. Return the sum in the EAX register,
; and preserve all other register values between calls to the procedure.

N = 13
.data
array DWORD N DUP (1)
j DWORD ? 
k DWORD ? 
len DWORD N - 1
sum DWORD ? 
promptj BYTE "Please provide j: ",0
promptk BYTE "Please provide k: ",0
promptArrayBegin BYTE "Array: [",0
comma BYTE ", ",0
promptArrayEnd BYTE "]",0
arraySum BYTE "The Sum is: ",0

.code 
main PROC
	
	call fillArray
	call sumArray
	call displayArrayAndSum
	exit
main ENDP

fillArray PROC
	pushad
	mov esi, offset array
	mov ecx, len

	call getInt

L1:
	mov eax,j
	mov eax,k
	call RandomRange
	cmp eax,0
	je L1
	mov [esi],eax
	add esi,4
	loop L1
	

	popad
	ret
fillArray ENDP	

getInt PROC
	mov edx,offset promptj
	call WriteString
	call ReadInt
	mov j,eax
	call Crlf

	mov edx,offset promptk
	call WriteString
	call ReadInt
	mov k,eax
	call Crlf

	ret
getInt ENDP

sumArray PROC
	mov esi, offset array
	mov ecx, len
	mov ebx,0
L1:
	add ebx,[esi]
	add esi,4
	loop L1

	mov sum,ebx
	ret
sumArray ENDP

displayArrayAndSum PROC
	mov esi, offset array
	mov ecx, len
 
	call Crlf
	mov edx, offset promptArrayBegin
	call WriteString
L1:
	mov eax,[esi]
	call WriteInt
	mov edx, offset comma
	call WriteString
	add esi,4
	loop L1
		
	mov edx, offset promptArrayEnd
	call WriteString

	call Crlf
	mov edx, offset arraySum
	call WriteString
	mov eax, sum
	call WriteInt

	ret
displayArrayAndSum ENDP

END main