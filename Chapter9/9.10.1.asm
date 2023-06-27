INCLUDE Irvine32.inc

; The Str_copy procedure shown in this chapter does not limit the number of characters to be cop-
; ied. Create a new version (named Str_copyN) that receives an additional input parameter indi-
; cating the maximum number of characters to be copied

Str_copyN PROTO source:PTR BYTE, target:PTR BYTE, maxChar:DWORD

.data
sourceDW BYTE "I am from source.",0
targetDW  BYTE "AAAAAAAAAAAAAA",0


.code
main PROC
	INVOKE str_copyN,	ADDR sourceDW, ADDR targetDW, 7

	mov edx,offset targetDW
	call WriteString
	call Crlf

	nop
	exit
main ENDP

Str_copyN PROC uses eax ecx esi edi,
	source:PTR BYTE,
	target: PTR BYTE,
	maxChar:DWORD
	
	INVOKE Str_length, source
	cmp eax,maxChar
	jb quitProc
	mov ecx,eax
	sub ecx,maxChar
	mov esi,source
	mov edi,target
	cld
	rep movsb
	ret

	quitProc:
		ret
Str_copyN ENDP

END main