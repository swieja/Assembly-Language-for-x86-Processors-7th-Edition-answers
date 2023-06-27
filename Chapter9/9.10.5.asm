INCLUDE Irvine32.inc

; Write a procedure called Str_nextWord that scans a string for the first occurrence of a certain
; delimiter character and replaces the delimiter with a null byte. There are two input parameters: a
; pointer to the string and the delimiter character. After the call, if the delimiter was found, the Zero
; flag is set and EAX contains the offset of the next character beyond the delimiter. Otherwise, the
; Zero flag is clear and EAX is undefined. The following example code passes the address of target
; and a comma as the delimiter:

; data
; target BYTE "Johnson,Calvin",0
; .code
; INVOKE Str_nextWord, ADDR target, ','
; jnz notFound
; In Figure 9-5, after calling Str_nextWord, EAX points to the character following the position
; where the comma was found (and replaced).

Str_nextWord PROTO pArray:PTR BYTE, char:BYTE

.data
target BYTE "Johnson,Calvin",0
prompt BYTE "The locaiton of the char parameter was at: ",0
pos DWORD ? 

.code
main PROC

	INVOKE Str_nextWord, ADDR target, ','
	jnz notFound 
	mov edx, offset target
	call WriteString ; only Johnson should be printed.
	call Crlf
	mov edx, offset prompt
	mov eax,pos
	call WriteString
	call WriteHex
	call Crlf

	 notFound:
		exit
main ENDP

Str_nextWord PROC USES esi edi eax ecx ebx,
	pArray:PTR BYTE,
	char: BYTE

	mov edi, pArray
	INVOKE Str_length,edi
	mov ecx,eax

	mov al, char
	cld
	repne scasb

	dec edi
	mov eax,edi
	mov byte ptr[edi],00h

	
	mov pos,eax
	cmp byte ptr[edi], 00h ; for zero flag
	nop
	ret
Str_nextWord ENDP

END main