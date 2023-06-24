INCLUDE Irvine32.inc

; Write a procedure named CountMatches that receives points to two arrays of signed double-
; words, and a third parameter that indicates the length of the two arrays. For each element xi in
; the first array, if the corresponding yi in the second array is equal, increment a count. At the end,
; return a count of the number of matching array elements in EAX. Write a test program that calls
; your procedure and passes pointers to two different pairs of arrays. Use the INVOKE statement
; to call your procedure and pass stack parameters. Create a PROTO declaration for Count-
; Matches. Save and restore any registers (other than EAX) changed by your procedure.

CountMatches PROTO pArray1: PTR DWORD, pArray2: PTR DWORD, arrayLength: DWORD

.data
array1		DWORD 1,2,3,4,5,7,9,2,3,3,3,3,3,3
array2		DWORD 1,2,3,4,5,8,0,3,3,3,3,3,3,3
arrayLen	DWORD lengthof array1

.code
main PROC

	invoke CountMatches, addr array1, addr array2, arrayLen 

	call WaitMsg
	exit
main ENDP

CountMatches PROC uses esi edi ecx ,pArray1: PTR DWORD, pArray2: PTR DWORD, arrayLength: DWORD
		LOCAL count:DWORD
	push esi
	push edi
	push ecx

	mov count,0
	mov esi, pArray1
	mov edi, pArray2
	mov ecx,arrayLength

	L1:
		mov eax, [esi]
		cmp eax, [edi]
		je L2
		jmp nextLoop
	L2:
		add count,1

	nextLoop:
		add esi,4
		add edi,4
		loop L1
	
	pop ecx
	pop edi
	pop esi
	ret
CountMatches ENDP

END main