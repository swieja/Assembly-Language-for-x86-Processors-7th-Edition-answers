INCLUDE Irvine32.inc

;	Write a procedure named Str_remove that removes n characters from a string. Pass a pointer to
;	the position in the string where the characters are to be removed. Pass an integer specifying the
;	number of characters to remove. The following code, for example, shows how to remove “xxxx”
;	from target:
;	.data
;	target BYTE "abcxxxxdefghijklmop",0
;	.code
;	INVOKE Str_remove, ADDR [target+3], 4
; 

Str_remove PROTO array:PTR BYTE, chars:DWORD


.data
target BYTE "abcxxxxdefghijklmop",0

 .code
 main PROC

	INVOKE Str_remove, ADDR [target+3], 4
	
	mov edx, offset target
	call WriteString
	call Crlf
	nop
	exit
main ENDP

Str_remove PROC uses esi edi ecx eax,
	array:PTR BYTE,
	chars:DWORD

	mov edi,array
	mov esi, array	
	add esi,chars		
	
	invoke Str_length, esi
	mov ecx,eax

	cld
	rep movsb
	
	mov esi,array
	find_last_address:
		mov al, byte ptr [esi]
		cmp al, 00h
		je last_address_found
		inc esi
		jmp find_last_address
	
	last_address_found:
		dec esi

	mov ecx,chars
	L1:
		mov byte ptr[esi],00h
		dec esi
		loop L1

	nop
	ret
Str_remove ENDP

END main