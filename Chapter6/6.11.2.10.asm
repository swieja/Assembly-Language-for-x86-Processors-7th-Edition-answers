INCLUDE Irvine32.inc

; Data transmission systems and file subsystems often use a form of error detection that relies on
; calculating the parity (even or odd) of blocks of data. Your task is to create a procedure that
; returns True in the EAX register if the bytes in an array contain even parity, or False if the parity
; is odd. In other words, if you count all the bits in the entire array, their count will be even or odd.
; Preserve all other register values between calls to the procedure. Write a test program that calls
; your procedure twice, each time passing it a pointer to an array and the length of the array. The
; procedure’s return value in EAX should be 1 (True) or 0 (False). For test data, create two arrays
; containing at least 10 bytes, one having even parity, and another having odd parity.
; idk stolen from some Chinese website

.data
array1			BYTE 11111110b, 11011110b, 10001110b, 11101100b, 11001100b, 11001010b, 11001010b, 11001010b, 11000110b, 10001100b ; 43
array2			BYTE 11111110b, 11011111b, 10001110b, 11101100b, 11001100b, 11001011b, 11001010b, 11001010b, 11000110b, 10001100b,11111110b, 11011110b ; 60

.code
main PROC
	mov esi, OFFSET array1
	mov ecx, SIZEOF array2
	call PFCheck

	mov esi, OFFSET oddParityArray
	mov ecx, SIZEOF oddParityArray
	call PFCheck

	exit
main ENDP

PFCheck PROC
	push esi
	push ecx
	sub ecx,1
	mov al,[esi] ; al = 02h

	L1: ; first iteration
		inc esi ; esi points to 14h
		xor al,[esi] ; 02h xor 14h
		mov bl, [esi] ; bl  = 14h
		loop L1 ; xor all elements

	jp LPF1 ; if parity jmp to LPF1 which sets PF to 1

	mov eax,0 ; else set PF to 0
	jmp endProc
	LPF1:
		mov eax,1	
	
	endProc:
		pop ecx
		pop esi
		ret
PFCheck ENDP

END main