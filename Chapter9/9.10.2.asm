INCLUDE Irvine32.inc

; Write a procedure named Str_concat that concatenates a source string to the end of a target
; string. Sufficient space must exist in the target string to accommodate the new characters. Pass
; pointers to the source and target strings. Here is a sample call:
; .data
; targetStr BYTE "ABCDE",10 DUP(0)
; sourceStr BYTE "FGH",0
; .code
; INVOKE Str_concat, ADDR targetStr, ADDR sourceStr

Str_concat PROTO target:PTR BYTE, source:PTR BYTE


.data
targetStr BYTE "ABCDE",10 DUP(00h)
sourceStr BYTE "FGH",0

 .code
 main PROC
	INVOKE Str_concat, ADDR targetStr, ADDR sourceStr

	mov edx, offset targetStr
	call WriteString
	call Crlf
	
	nop
	exit
main ENDP

Str_concat PROC uses esi edi,
	target:PTR BYTE,
	source:PTR BYTE

	mov edi, target
	mov esi, source
	INVOKE Str_length, edi
	; string length of targetStr is in eax
	mov ecx,eax
	mov al,00h
	cld
	repne scasb
	

	INVOKE Str_length, esi
	; string length of targetStr is in eax
	mov ecx,eax
	cld
	rep movsb
	ret



	quitProc:
		ret
Str_concat ENDP

END main