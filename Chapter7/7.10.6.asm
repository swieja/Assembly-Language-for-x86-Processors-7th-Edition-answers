INCLUDE Irvine32.inc

; The greatest common divisor (GCD) of two integers is the largest integer that
; will evenly divide both integers. The GCD algorithm involves integer division in a loop, 
; described by the following pseudocode

; int GCD(int x, int y)
; {
; 	x = abs(x) // absolute value
; 	y = abs(y)
; 	do {
; 		int n = x % y
; 		x = y
; 		y = n
; 	} while (y > 0)
; 	return x
; }

; Implement this function in assembly language and write a test program that calls the function several
; times, passing it different values. Display all results on the screen.
.data
prompt1 BYTE "GCD of ",0 
prompt2 BYTE " and ",0
prompt3 BYTE " is: ",0
gcdVal DWORD ? 

.code
main proc
	mov eax, 5d ; x
	mov ecx, 25d ; y
	call gcd
	call printGCD

	mov eax, 3d ; x
	mov ecx, 1443d ; y
	call gcd
	call printGCD
	
	mov eax, 1284d ; x
	mov ecx, 48244224d ; y
	call gcd
	call printGCD

	exit
main endp

gcd proc
	push eax
	push ecx
	; scuffed absolute
	clc
	mov ebx,eax
	neg eax
	cmovl eax,ebx

	mov ebx,ecx
	neg ecx
	cmovl ecx,ebx
	;eax = x 
	;ecx = y

	asd:
		
		cdq
		idiv ecx ; int n = x % y;
		; edx = n
		mov eax,ecx ; x = y 
		mov ecx,edx ; y = n
		cmp ecx,0
		ja asd

	mov gcdVal, eax
	pop ecx
	pop eax
	ret
gcd endp

printGCD proc
	push ecx
	push eax
	;.data
	;prompt1 BYTE "GCD of " 
	;prompt2 BYTE " and "
	;prompt3 BYTE "is: "
	;gcdVal DWORD ? 
	mov edx , offset prompt1
	call WriteString
	call WriteInt
	mov edx , offset prompt2
	call WriteString
	mov eax,ecx
	call WriteInt
	mov edx , offset prompt3
	call WriteString
	mov eax, gcdVal
	call WriteInt
	call Crlf

	pop eax
	pop ecx
	ret
printGCD endp

end main