INCLUDE Irvine32.inc

; Write a procedure that performs simple encryption byu rotating each plaintext byte a varying number
; of positions in different directions. For example, in the following array that representes the 
; encryption key, a negative value indicates a rotation to the left and a positive value indicates
; a rotation to the right. The integer in each position indicates the magnitude of the rotation
; key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
; Your procedure should loop throught a plaintext message and align the key to the first 10 bytes
; of the message. Rotate each plaintext byte by the amount indicated by its matching key array value
; Then align the key to the next 10 bytes of the message and repeat the process
; Write a program that tests your encryption by calling it twice, with different data sets.

COMMA = 44
.data
key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
plaintext_one BYTE "This is a plaintext message",0
plaintext_two BYTE "This is another plaintext message",0
plaintext_three BYTE "And another one",0
keyLength	DWORD lengthof key - 1

.code
main PROC
	mov edi,offset key
	mov esi, offset plaintext_one
	mov edx, 0
	mov ebx,0
	call encrypt
	mov eax, offset plaintext_one
	mov ebx, TYPE plaintext_one
	mov ecx, lengthof plaintext_one
	call WriteEncryptedTextInHex


	mov esi, offset plaintext_two
	call encrypt
	mov eax, offset plaintext_two
	mov ebx, TYPE plaintext_two
	mov ecx, lengthof plaintext_two
	call WriteEncryptedTextInHex
	
	mov esi, offset plaintext_three
	call encrypt
	mov eax, offset plaintext_three
	mov ebx, TYPE plaintext_three
	mov ecx, lengthof plaintext_three
	call WriteEncryptedTextInHex
	

	exit
main ENDP	

encrypt PROC
pushad
	encryptLoop:
		mov al,[esi]
		cmp al,0 ; if reached end of plaintext array, return to main
		je EndLoop

		mov al,[edi + edx]
		add edx, 1
		cmp edx, keyLength
		je resetKeyIndex

		mov cl,key[ebx]
		test cl,cl ; check if key index is positive or negative
		jns positive
		jmp negative
		
positive:
	ror BYTE PTR[esi], cl; rotate plaintext index to right, cl is the value moved from key array
	jmp addCounters
negative:
	;the count operand is an unsigned integer that can be an immediate or a value in the CL register. The processor restricts the count to a number between 0 and 31 by masking all the bits in the count operand except the 5 least-significant bits.
	neg cl
	rol	BYTE PTR[esi], cl ; rotate plaintext index to left, cl is the value moved from key array
	jmp addCounters

addCounters:
	add esi, type byte
	add edi, type byte
	jmp encryptLoop

resetKeyIndex:
	sub edi, DWORD PTR keyLength
	jmp encryptLoop

	EndLoop:
		popad
		ret
encrypt ENDP

WriteEncryptedTextInHex PROC
	pushad
	L1:
		call WriteHexB
		add eax,1

		loop L1

	call Crlf
	popad
	ret
WriteEncryptedTextInHex ENDP

END main