INCLUDE Irvine32.inc

; Write a procedure named CountNearMatches that receives pointers to two arrays of signed dou-
; blewords, a parameter that indicates the length of the two arrays, and a parameter that indicates the
; maximum allowed difference (called diff) between any two matching elements. For each element
; xi in the first array, if the difference between it and the corresponding yi in the second array is less
; than or equal to diff, increment a count. At the end, return a count of the number of nearly match-
; ing array elements in EAX. Write a test program that calls CountNearMatches and passes pointers
; to two different pairs of arrays. Use the INVOKE statement to call your procedure and pass stack
; parameters. Create a PROTO declaration for CountMatches. Save and restore any registers (other
; than EAX) changed by your procedure.

CountMatches PROTO pArray1: PTR DWORD, pArray2: PTR DWORD, arrayLength: DWORD

DIFF = 2
.data
array1		SDWORD 1,2,0,4,5,7,9,2
array2		SDWORD 9,2,3,7,5,8,0,3
arrayLen	DWORD lengthof array1

.code
main PROC

	invoke CountMatches, addr array1, addr array2, arrayLen

	call WaitMsg
	exit
main ENDP

CountMatches PROC uses esi edi ecx ,pArray1: PTR DWORD, pArray2: PTR DWORD, arrayLength: DWORD
		LOCAL count:SDWORD
	push esi
	push edi
	push ecx
	push ebx

	mov count,0
	mov esi, pArray1
	mov edi, pArray2
	mov ecx,arrayLength

	L1:
		mov eax, [esi]
		cmp eax, [edi]
		je incrementCount
		jmp nearMatch
		jmp nextLoop
	
	nearMatch:
		sub eax,[edi] ; check what is a real difference
		clc ; if negative convert to absolute
		mov ebx,eax
		neg eax
		cmovl eax,ebx
		cmp eax,DIFF ; eax is a real difference between xi and yi diff, if reall difference is bigger than DIFF, increment count
		jnge incrementCount
		jmp nextLoop

	incrementCount:
		add count,1
		
	nextLoop:
		add esi,4
		add edi,4
		loop L1
	
	endProc:
		pop ebx
		pop ecx
		pop edi
		pop esi
		ret
CountMatches ENDP

END main