INCLUDE Irvine32.inc

; Create a procedure named FindLargest that receives two parameters: a pointer to a signed
; doubleword array, and a count of the array’s length. The procedure must return the value of
; the largest array member in EAX. Use the PROC directive with a parameter list when declar-
; ing the procedure. Preserve all registers (except EAX) that are modified by the procedure.
; Write a test program that calls FindLargest and passes three different arrays of different
; lengths. Be sure to include negative values in your arrays. Create a PROTO declaration for
; FindLargest.


FindLargest PROTO spDwArray: PTR DWORD, arrayLength: DWORD
.data
array1 SDWORD -5, -3, 3, 6 ,8, 0 ,12
array2 SDWORD -9, -1, 3, 4 ,14, 2 ,12,12,12,15
array3 SDWORD -5, -23, -19, 11 ,23, 7 ,-4,-3,-2,11,23
prompt1 BYTE "The largest number in the array is: ",0

.code
main PROC

	INVOKE FindLargest, offset array1, lengthof array1
	INVOKE FindLargest, offset array2, lengthof array2
	INVOKE FindLargest, offset array3, lengthof array3

	nop
	exit
main endp

FindLargest PROC USES esi ecx eax, spDwArray: PTR DWORD, arrayLength: DWORD
	push esi
	push ecx

	mov esi, spDwArray
	mov ecx, arrayLength
	dec ecx
	mov eax,[esi]

	L1:
		cmp ecx,0 ; essential if i dont want to jump to greater
		je endProc
		cmp eax,[esi + TYPE SDWORD]
		jng greater
		add esi, TYPE SDWORD
		loop L1
	
	greater:
		mov eax, [esi + TYPE SDWORD]
		add esi, TYPE SDWORD
		dec ecx
		jmp L1

	endProc:
		mov edx, offset prompt1 
		call WriteString
		call WriteInt
		call Crlf
		pop ecx
		pop esi
		ret
FindLargest ENDP
END main