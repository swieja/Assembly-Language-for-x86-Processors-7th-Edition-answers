INCLUDE Irvine32.inc

; Create a variant of the Str_trim procedure that lets the caller remove all instances of a set of
; characters from the end of a string. For example, if you were to call it with a pointer to the string
; “ABC#$&” and pass it a pointer to an array of filter characters containing “%#!;$&*”, the result-
; ing string would be “ABC”.
Str_trim_B PROTO, pString:PTR BYTE, pChars:PTR BYTE

.data
arrayString BYTE "ABC#$&",0
arrayChars BYTE "%#!;$&*",0


.code
main PROC
	INVOKE	Str_trim_B, ADDR arrayString, ADDR arrayChars

	mov edx, offset arrayString
	call WriteString
	call Crlf

	call WaitMsg
	exit
main ENDP

Str_trim_B PROC USES eax edx ecx esi edi,
	pString:PTR BYTE, ; points to string
	pChars:PTR BYTE ; character to remove
	
	;This will only work if specials chars are at the end of string
	mov esi, pString
	mov edi, pChars

	mov al, [esi]
	mov bl, [edi]
	L1:
		
		cmp al,00h
		je quitProc

		cmp al,bl
		je replaceWithNull
		jne incrementChars
		jmp quitProc

	replaceWithNull:
		mov byte ptr[esi],00h
		inc esi
		mov al,[esi]
		jmp L1

	incrementChars:
		inc edi
		mov bl, [edi]
		cmp bl,00h
		je resetCharsAndIncESI
		jmp L1

	resetCharsAndIncESI:
		inc esi
		mov edi, pChars
		mov al, [esi]
		mov bl, [edi]
		jmp L1

	quitProc:
		ret
	ret
Str_trim_B ENDP

END main