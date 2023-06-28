INCLUDE Irvine32.inc

; The Sieve of Eratosthenes, invented by the Greek mathematician of the same name, provides a
; quick way to find all prime numbers within a given range. The algorithm involves creating an array
; of bytes in which positions are “marked” by inserting 1s in the following manner: Beginning with
; position 2 (which is a prime number), insert a 1 in each array position that is a multiple of 2. Then
; do the same thing for multiples of 3, the next prime number. Find the next prime number after 3,
; which is 5, and mark all positions that are multiples of 5. Proceed in this manner until all multiples
; of primes have been found. The remaining positions of the array that are unmarked indicate which
; numbers are prime. For this program, create a 65,000-element array and display all primes
; between 2 and 65,000. Declare the array in an uninitialized data segment (see Section 3.4.11) and
; use STOSB to fill it with zeros.

PrintPrimes PROTO, count:DWORD 

FIRST_PRIME = 2
LAST_PRIME = 65000

.data
commaStr BYTE ", ",0
sieve WORD LAST_PRIME DUP(0)

.code
main PROC
	
	mov esi, FIRST_PRIME
	
	L1:
		cmp esi, LAST_PRIME
		jb L2
		jmp L4
	L2:
		cmp word ptr sieve[esi*TYPE sieve],0
		jne L3
		call MarkMultiplies	
	L3:
		inc esi
		jmp L1

	L4:
		invoke PrintPrimes, 8000
	
	nop
	exit
main ENDP

MarkMultiplies PROC
	push eax
	push esi
	mov eax,esi
	add esi,eax

	L1:
		cmp esi, LAST_PRIME
		ja L2
		mov sieve[esi * TYPE sieve],1
		add esi,eax
		jmp L1

	L2:
		pop esi
		pop eax
		ret
MarkMultiplies ENDP

PrintPrimes PROC, count:DWORD

	mov esi,1
	mov eax,0
	mov ecx,count

	L1:
		mov ax,sieve[esi*TYPE sieve]
		or ax,ax
		jne L2
		mov eax,esi
		call WriteDec
		mov edx, offset commaStr
		call WriteString
	L2:
		inc esi
		loop L1

		ret
PrintPrimes ENDP
END main