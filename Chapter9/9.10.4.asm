INCLUDE Irvine32.inc

; Write a procedure named Str_find that searches for the first matching occurrence of a source string
; inside a target string and returns the matching position. The input parameters should be a pointer to
; the source string and a pointer to the target string. If a match is found, the procedure sets the Zero
; flag and EAX points to the matching position in the target string. Otherwise, the Zero flag is clear
; and EAX is undefined. The following code, for example, searches for “ABC” and returns with EAX
; pointing to the “A” in the target string:

;.data
;target BYTE "123ABC342432",0
;source BYTE "ABC",0
;pos DWORD ?
;.code
;INVOKE Str_find, ADDR source, ADDR target
;jnz notFound
;mov pos,eax ; store the position value

Str_find PROTO arrayTarget:PTR BYTE, arraySource:PTR BYTE

.data
target BYTE "123ABC342432",0
source BYTE "ABC",0
pos DWORD ?
prompt BYTE "The starting address of matching character is located at: ",0

 .code
 main PROC
	INVOKE Str_find, ADDR target, ADDR source
	jnz notFound
	mov eax,pos
	mov edx,offset prompt
	call WriteString
	call WriteHex
	call Crlf
	
	notFound:
		exit
main ENDP

Str_find PROC uses esi edi edx ecx eax,
	arrayTarget:PTR BYTE,
	arraySource:PTR BYTE
	mov esi, arrayTarget
	mov edi, arraySource
	INVOKE Str_length, edi
	mov pos,eax
	

	
	L1:
		mov al,[esi]
		mov dl,[edi]
		cmp al,00h
		je quitProgram
		cmp dl,00h
		je stringMatchFound
	
	L2:
		cmp al,dl
		jne incrementESI
		je incrementESIEDI
		jmp quitProgram

	incrementESI:
		inc esi
		jmp L1
	incrementESIEDI:
		inc esi
		inc edi
		jmp L1
	
	stringMatchFound:
		sub esi,pos
		cmp dl,00h ; to set zero flag 
		mov pos,esi
		ret	

	quitProgram:
		ret
Str_find ENDP


END main