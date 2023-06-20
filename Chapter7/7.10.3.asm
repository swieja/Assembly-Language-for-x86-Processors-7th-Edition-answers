INCLUDE Irvine32.inc

; Write a procedure named PackedToAsc that converts a 4-byte packed decimal integer to a string
; of ascii decimal digits. Pass the packed integer and the address of a buffer holding the ASCII digits
; to the procecdure. Write a short test program that passes at least 5 packed decimal integers
; to your procedure.

; decimal integer = 65 

.data
decIntegers_one BYTE 1,2,3,4
decIntegers_two BYTE 2,3,4,5
decIntegers_three BYTE 3,4,5,6
decIntegers_four BYTE 4,5,6,7
decIntegers_five BYTE 5,6,7,8

ASCIIDigits BYTE 5 DUP(?)

.code
main PROC
	mov edi, offset ASCIIDigits
	mov ecx, lengthof decIntegers_one

	mov esi, offset decIntegers_one
	call PackedToAsc

	mov esi, offset decIntegers_two
	call PackedToAsc

	mov esi, offset decIntegers_three
	call PackedToAsc

	mov esi, offset decIntegers_four
	call PackedToAsc

	mov esi, offset decIntegers_five
	call PackedToAsc

	

	exit
main ENDP

PackedToAsc PROC
	push edi
	push ecx
	L1:
		mov al,[esi]
		add al,'0'
		mov [edi],al 
		inc esi
		inc edi
		loop L1

	mov byte ptr[edi],0
	mov edx,offset ASCIIDigits
	call WriteString
	call Crlf

	pop ecx
	pop edi
	ret
PackedToAsc ENDP

END main