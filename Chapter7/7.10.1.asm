INCLUDE Irvine32.inc

; Write a procedure named WriteScaled that outputs a decimal ASCII number with an implied
; decimal point. Suppose the following number were defined as follows, where DECIMAL_OFFSET
; indicates that the decimal point must be inserted five positions from the right side of the number
;	DECIMAL_OFFSET = 5
;	.data
;	decimal_one BYTE "100123456789765"
; WriteScaled would display the number like this:
;	1001234567.89765
; When calling WriteScaled, pass the number’s offset in EDX, the number length in ECX, and the
; decimal offset in EBX. Write a test program that passes three numbers of different sizes to the
; WriteScaled procedure.

DECIMAL_POINT = 46
DECIMAL_OFFSET = 5
.data
decimal_one BYTE "100123456789765"
decimal_two BYTE "40941998605911219008"
decimal_three BYTE "6186940676615607343558123"

.code
main PROC
	mov esi, offset decimal_one
	mov ecx, lengthof decimal_one
	call WriteScaled

	mov esi, offset decimal_two
	mov ecx, lengthof decimal_two
	call WriteScaled

	mov esi, offset decimal_three
	mov ecx, lengthof decimal_three
	call WriteScaled

	nop
	exit
main ENDP

WriteScaled PROC
	sub ecx,DECIMAL_OFFSET

		L1:
		mov al,[esi]
		call WriteChar
		inc esi
		LOOP L1

	mov al, DECIMAL_POINT
	call WriteChar

	mov ecx, DECIMAL_OFFSET
	L2:
		mov al,[esi]
		call WriteChar
		inc esi
		LOOP L2

	call Crlf
	ret
WriteScaled ENDP
END main