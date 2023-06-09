INCLUDE Irvine32.inc

; Create a procedure that generates a random string of length L, containing all capital letters.
; When calling the procedure, pass the value of L in EAX, and pass a pointer to an array of byte
; that will hold the randoms string. Write a test program that calls your procedure 20 and displays
; the strings in the console window


.data
Array1 BYTE "ABCDEFGHIJKLMNOPQRSTUVWXYZ",0
copyOfArray1 BYTE LENGTHOF Array1 DUP(?)
L DWORD LENGTHOF Array1 - 1

.code
main PROC
	
	call proc_1

	INVOKE ExitProcess,0
main ENDP

proc_1 PROC
	mov ecx, L 
	mov esi, OFFSET Array1
	mov edx, OFFSET copyOfArray1 

L1:
	mov eax,L
	call RandomRange
	mov bl,[esi+eax]
	mov [edx],bl
	inc dl
	call Randomize
	loop L1

	ret
proc_1 ENDP

	
END main

;not a good solution because Randomize generates seed based on time so the copied array will most likely have the same contents as the source