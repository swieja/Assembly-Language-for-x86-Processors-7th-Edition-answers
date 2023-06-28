INCLUDE Irvine32.inc

;Write a procedure named Get_frequencies that constructs a character frequency table. Input to
;the procedure should be a pointer to a string and a pointer to an array of 256 doublewords initial-
;ized to all zeros. Each array position is indexed by its corresponding ASCII code. When the pro-
;cedure returns, each entry in the array contains a count of how many times the corresponding
;character occurred in the string. For example,

; min Hex for uppercase letter  = 41h = 65d
; max Hex for uppercase letter  = 5Ah = 90d

; 00000041 | 00000042 | 00000043 | 00000044 | 00000045 | 00000046 | 00000047 | 00000048 | 00000049 | 0000004A | 0000004B | 0000004C | 0000004D | 0000004E | 0000004F | 00000050 | 00000051 | 00000052 | 00000053 | 00000054 | 00000055 | 00000056 | 00000057 | 00000058 | 00000059 | 0000005A |
; 00000002 | 00000003 | 00000002 | 00000001 | 00000001 | 00000001 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 | 00000000 |

Get_frequencies PROTO pTarget:PTR BYTE, pFreqTable:PTR BYTE

.data
target BYTE "AAEBDCFBBC",0
freqTable DWORD 256 DUP(0)
prompt BYTE " | ",0

.code
main PROC
	INVOKE Get_frequencies, ADDR target, ADDR freqTable

	mov ecx, 90d
	sub ecx, 64d
	mov eax, 041h
	push ecx
	L1:
		call WriteHex
		mov edx,offset prompt
		call WriteString
		inc eax
		loop L1

	call Crlf
	pop ecx
	mov esi, offset freqTable
	L2:
		mov al, BYTE PTR [esi]
		call WriteHex
		mov edx,offset prompt
		call WriteString
		inc esi
		loop L2

		

	exit
main ENDP

Get_frequencies PROC USES esi edi eax ecx,
	pTarget:PTR BYTE,
	pFreqTable:PTR BYTE

	mov esi, pTarget
	mov edi, pFreqTable
	mov dl, 041h

	L1:
		cmp dl, 05Ah
		ja quitProc
		cmp byte ptr[esi],dl
		je matchFound
		cmp byte ptr[esi],00h
		je incrementFreqTable
		inc esi
		jmp L1

	
	matchFound:
		inc esi
		add byte ptr[edi], 1
		jmp L1

	incrementFreqTable:
		mov esi, pTarget
		inc dl
		inc edi
		jmp L1

	quitProc:
		ret
Get_frequencies ENDP

END main