INCLUDE Irvine32.inc

; The RandomRange procedure from the Irvine32 library generates a pseudorandom integer between
; 0 and N - 1, Your task is to create an improved version that generates an integer between M and N - 1
; Let the caller pass M in EBX and N in EAX. If we call the procedure BetterRandomRange
; the following code is a sample test: 
; mov ebx, -300 ; lower bound
; mov eax, 1000 ; upper bound 
; call BetterRandomRange


.data

.code
main PROC
	call Clrscr
	mov eax,-300 ; eax = N
	mov ebx, 100 ; ebx = M 
	mov ecx,50
	
L1:
	push eax
	push ebx
	call BetterRandomRange

	pop ebx
	pop eax
	loop L1

	call WaitMsg
	INVOKE ExitProcess,0
main ENDP

BetterRandomRange PROC	
	sub ebx,eax
	xchg ebx,eax
	call RandomRange
	neg ebx
	sub eax,ebx
	call WriteInt
	call Crlf
	ret

BetterRandomRange ENDP

END main
