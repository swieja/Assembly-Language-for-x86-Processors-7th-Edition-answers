INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD

KEY = 239
BUFMAX = 128

.data
sPrompt BYTE "Enter the plain text: ",0
sEncrypt BYTE "Cipher text:      ",0
sDecrypt BYTE "Decrypted:       ",0
buffer BYTE BUFMAX+1 DUP(0)
buffSize DWORD ? 

.code
main PROC
	call InputTheString
	call TranslateBuffer
	mov edx, OFFSET sEncrypt
	call DisplayMessage
	call TranslateBuffer
	mov edx, OFFSET sDecrypt
	call DisplayMessage
	exit
main ENDP

InputTheString PROC
	pushad
	mov edx,OFFSET sPrompt
	call WriteString
	mov ecx,BUFMAX
	mov edx,OFFSET buffer
	call ReadString
	mov buffSize,eax
	call Crlf
	popad
	ret
InputTheString ENDP

DisplayMessage PROC
	pushad
	call WriteString
	mov edx, OFFSET buffer
	call WriteString
	call Crlf
	call Crlf
	popad
	ret
DisplayMessage ENDP

TranslateBuffer PROC
	pushad
	mov ecx,buffSize
	mov esi,0
	L1:
		xor buffer[esi],KEY
		inc esi
		loop L1
		popad
		ret
TranslateBuffer ENDP

END main
