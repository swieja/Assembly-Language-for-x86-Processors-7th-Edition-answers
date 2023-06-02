.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD
; Write a program that contains a definition of each data type listed 
; in Table 3-2 in Section 3.4 Initialize each variable to a value
; that is consistent with its data type

.data
;d_byte BYTE 8
d_byte BYTE 12h

;d_sbyte SBYTE 8
d_sbyte SBYTE 12h

;d_word WORD 16
d_word WORD 1234h

;d_sword SWORD 16
d_sword SWORD 1234h

;d_dword DWORD 32
d_dword DWORD 12345678h

;d_sdword sdword 32
d_sdword sdword 12345678h

;d_fword FWORD 48
d_fword FWORD 1234567890abh

;d_qword QWORD 64
d_qword QWORD 1234567890abcdefh

;d_tbyte TBYTE 80
d_tbyte TBYTE 12deadbeefdeadbeefh

;d_real4 REAL4 3.2
d_real4 REAL4 3.2

;d_real8 REAL8 6.4
d_real8 REAL8 6.4

;d_real10 REAL10 8.0
d_real10 REAL10 8.0

floating_result DWORD ? 

.code
main PROC
	xor eax,eax
	mov al,d_byte ; lower 8 bit
	mov ah,d_sbyte ; higher 8 bits
	xor eax,eax
	mov ax, d_word ; lower 16 bits
	xor eax,eax
	mov ax, d_sword ; lower 16 bits
	
	xor ebx,ebx
	mov bx,WORD PTR d_dword ; 5678
	mov bx,WORD PTR [d_dword + 1] ; 3456
	mov bx,WORD PTR [d_dword + 2] ; 1234
	mov bx,WORD PTR [d_dword + 3] ; 7812

	xor eax,eax
	mov eax, d_sdword ; 12345678h

	xor ecx,ecx
	mov ecx,DWORD PTR d_fword ; 567890ab
	mov ecx,DWORD PTR [d_fword + 1] ; 34567890
	mov ecx,DWORD PTR [d_fword + 2] ; 12345678

	xor ecx,ecx
	mov ecx, DWORD PTR d_qword; 90abcdef
	mov ecx, DWORD PTR [d_qword+1]; 7890abcd
	mov ecx, DWORD PTR [d_qword+2]; 567890ab
	mov ecx, DWORD PTR [d_qword+3]; 34567890
	mov ecx, DWORD PTR [d_qword+4]; 12345678

	xor ecx,ecx
	mov ecx, DWORD PTR d_tbyte; deadbeef
	mov ecx, DWORD PTR [d_tbyte+1]; efdeadbe
	mov ecx, DWORD PTR [d_tbyte+2]; beefdead
	mov ecx, DWORD PTR [d_tbyte+3]; adbeefde
	mov ecx, DWORD PTR [d_tbyte+4]; deadbeef
	mov ecx, DWORD PTR [d_tbyte+5]; 12deadbe

	xor ecx,ecx
	mov cl,BYTE PTR d_tbyte; ef
	xor ecx,ecx

	;d_real4 REAL4 3.2
	fld d_real4
	fstp floating_result
	mov eax, floating_result

	xor eax,eax
	;d_real8 REAL8 6.4
	fld d_real8
	fstp floating_result
	mov eax, floating_result

	xor eax,eax
	;d_real10 REAL10 8.0
	fld d_real10
	fstp floating_result
	mov eax, floating_result
	

	INVOKE ExitProcess, eax

main ENDP

END main