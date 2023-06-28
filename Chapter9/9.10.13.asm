INCLUDE Irvine32.inc

; Create a variant of the Str_trim procedure that lets the caller remove all instances of a leading
; character from a string. For example, if you were to call it with a pointer to the string “###ABC”
; and pass it the # character, the resulting string would be “ABC.”
Str_trim_A PROTO, pString:PTR BYTE, char:BYTE

.data
array BYTE "###ABC",0

.code
main PROC
	Invoke Str_trim_A, ADDR array, '#'

	mov edx, offset array
	call WriteString
	call Crlf

	call WaitMsg
	exit
main ENDP

Str_trim_A PROC USES eax edx ecx esi edi,
	pString:PTR BYTE, ; points to string
	char: BYTE ; character to remove

	mov esi, pString
	mov ecx,0

	L1:
		mov edx,[esi]
		cmp dl,char	
		je incrementECX
		jne L2
		jmp quitProc
	incrementECX:
		inc ecx
		inc esi
		jmp L1

	L2:
		mov edi,pString
		push esi
	L3:
		; esi points to the element after the last delimeter
		mov al,[esi]
		mov [edi],al
		inc esi
		inc edi
		loop L3

	pop esi
	L4:
		cmp byte ptr[esi],00h
		je quitProc
		mov BYTE PTR[esi],00h
		inc esi
		jmp L4

	quitProc:
		ret
	ret
Str_trim_A ENDP

END main