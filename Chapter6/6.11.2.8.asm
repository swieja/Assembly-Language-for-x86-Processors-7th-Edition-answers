INCLUDE Irvine32.inc

; Revise the encryption program in Section 6.3.4 in the following manner: Create an encryption
; key consisting of multiple characters. Use this key to encrypt and decrypt the plaintext by XOR-
; ing each character of the key against a corresponding byte in the message. Repeat the key as
; many times as necessary until all plain text bytes are translated. Suppose, for example, the key
; were equal to “ABXmv#7”. This is how the key would align with the plain text bytes:

COMMA = 44
.data
plainText	BYTE  "This is plaintext message",0
separator	BYTE "00000000"
before		BYTE "plainText before encryption: ",0
after			BYTE "plainText after encryption: ",0
afterHex	BYTE "plainText after encryption in hex: ",0
KEY			BYTE "ABXmv#7"
keyLength	DWORD LENGTHOF KEY - 1

.code
main PROC

	mov edx, offset before
	call WriteString
	call Crlf
	mov edx, offset plainText
	call WriteString
	call Crlf

	mov esi, OFFSET plainText
	mov edi, OFFSET key

	mov ecx,0
	mov edx,0
	
	call TranslateBuffer

	mov edx, offset after
	call WriteString
	call Crlf
	mov edx, offset plainText
	call WriteString
	call Crlf

	; Write in hex here 
	mov ecx, LENGTHOF plainText 
	mov esi, offset plainText
	mov ebx, TYPE plainTEXT
L1:
	mov eax, [esi]
	call WriteHexB
	add esi,4
	mov al, COMMA
	call WriteChar
	loop L1


	call Crlf
	call WaitMsg
	exit
main ENDP

TranslateBuffer PROC
EncryptLoop:
 	mov al,[esi]
	cmp al,0
	je EndLoop

	mov bl, [edi + ecx]
	add ecx, 1
	cmp ecx, keylength
	je clearECX

	xor al,bl 
	mov[esi],al

	add esi,1
	
	jmp EncryptLoop

clearECX:
	xor ecx,ecx
	jmp EncryptLoop
EndLoop:
	ret
TranslateBuffer ENDP

END main