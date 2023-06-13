INCLUDE Irvine32.inc

;	 Banks use a Personal Identification Number (PIN) to uniquely identify each customer. Let us
;	 assume that our bank has a specified range of acceptable values for each digit in its customers’
;	 5-digit PINs. The table shown below contains the acceptable ranges, where digits are numbered
;	 from left to right in the PIN. Then we can see that the PIN 52413 is valid. But the PIN 43534 is
;	 invalid because the first digit is out of range. Similarly, 64535 is invalid because of its last digit.

; Something is wrong here because if I understood the exercise correctly, 64535 is a valid PIN.

;		DIGIT NUMBER		RANGE
;		1							5 to 9
;		2							2 to 5 
;		3							4 to 8
;		4							1 to 4
;		5							3 to 6

;	 Your task is to create a procedure named Validate_PIN that receives a pointer to an array of byte
;	 containing a 5-digit PIN. Declare two arrays to hold the minimum and maximum range values,
;	 and use these arrays to validate each digit of the PIN that was passed to the procedure. If any
;	 digit is found to be outside its valid range, immediately return the digit’s position (between
;	 1 and 5) in the EAX register. If the entire PIN is valid, return 0 in EAX. Preserve all other
;	 register values between calls to the procedure. Write a test program that calls Validate_PIN at
;	 least four times, using both valid and invalid byte arrays. By running the program in a debugger,
;	 verify that the return value in EAX after each procedure call is valid. Or, if you prefer to use the
;	 book’s library, you can display "Valid" or "Invalid" on the console after each procedure call.

COMMA		= 44
PIN_LEN	= 5
.data
randomPIN		BYTE PIN_LEN DUP(?)
minRange		BYTE 5,2,4,1,3
maxRange		BYTE 9,5,8,4,6
Svalid			BYTE " The PIN is valid.",0
Sinvalid			BYTE " The PIN is invalid.",0

.code
main PROC
	mov ecx,10000

L1:
	call generatePin
	call displayPin
	call validatePIN
	loop L1
	
	call Crlf 
	call WaitMsg
	exit
main ENDP

generatePin PROC
	push ecx
	mov ecx, PIN_LEN
	mov esi, offset randomPIN

L1:
	mov eax,1
	call Delay

	call Randomize 
	mov eax,9
	call RandomRange
	inc eax
	mov [esi],al
	add esi,1
	loop L1
	
	pop ecx
	ret
generatePin ENDP

validatePIN PROC
	push ecx
	mov esi,0

L1:
		movzx ebx, byte ptr randomPIN[esi]
		mov cl,minRange[esi]
		mov ch, maxRange[esi]

		inc esi

		cmp bl,cl
		jb InvalidDigit
		cmp bl, ch
		ja InvalidDigit
		
		cmp esi,PIN_LEN ; if we reached the end, it means all digits were correct
		je ValidDigit

		jmp L1


	InvalidDigit:
		mov eax,esi ; if digit outside of range, move its position to eax
		mov eax, red
		call SetTextColor
		mov edx, offset Sinvalid
		call WriteString
		call Crlf
		mov eax, white
		call SetTextColor
		pop ecx
		ret

	ValidDigit:
		mov eax,0 ; if all digits are valid, mov 0 to eax
		mov eax, green
		call SetTextColor
		mov edx, offset Svalid
		call WriteString
		call Crlf
		mov eax, white
		call SetTextColor
		pop ecx
		ret

	ret
validatePIN ENDP

displayPin PROC
	push ecx
	mov ecx,PIN_LEN
	mov esi, offset randomPIN
L1:
	movzx eax, byte ptr[esi]
	call WriteInt
	add esi,1
	mov al,COMMA
	call WriteChar
	loop L1

	pop ecx
	ret
displayPin ENDP
END main