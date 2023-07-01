INCLUDE Irvine32.inc
INCLUDE Macros.inc

; Create a macro that shifts an array of 32-bit integers a variable number of bits in either direction,
; using the SHRD and SHLD instructions. Write a test program that tests your macro by shifting
; the same array in both directions and displaying the resulting values. You can assume that the
; array is in little-endian order. Here is a sample macro declaration:
; mShiftDoublewords MACRO arrayName, direction, numberOfBits
; Parameters:
; arrayName Name of the array
; direction Right (R) or Left (L)
; numberOfBits Number of bit positions to shift

mShiftDoublewords MACRO someArray, dir, numBits
	LOCAL string1,string2,tempArray, L1, L2, counter
	.data
	string1 BYTE "Provided array before performing shift operation: ",0
	string2 BYTE "Provided array after performing shift operation: ",0
	tempArray DWORD LENGTHOF someArray DUP(0)
	counter DWORD LENGTHOF someArray
	.code
	pushad

	mov esi, offset someArray
	mov edx,offset string1
	mov ecx, counter
	call WriteString
	L1:
		mov eax, [esi]
		mov ebx, TYPE someArray
		call WriteBinB
		mov al, '|'
		call WriteChar
		add esi,TYPE someArray
		loop L1
	
	call Crlf
	IF dir EQ 'R'
		SHRD tempArray,esi,numBits
	ELSE
		SHLD tempArray,esi,numBits
	ENDIF

	mov ecx, counter
	mov edx,offset string2
	call WriteString
	L2:
		mov eax, [esi]
		mov ebx, TYPE someArray
		call WriteBinB
		mov al, '|'
		call WriteChar
		add esi,TYPE someArray
		loop L2

	popad
ENDM

.data
someArray DWORD 10h,20h,30h,40h
.code
main PROC
	nop
	mShiftDoublewords someArray,'R',4
	nop
	call Crlf
	mShiftDoublewords someArray,'L',4
	


	nop
	exit
main ENDP

end main