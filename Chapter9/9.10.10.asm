INCLUDE Irvine32.inc

; Create a procedure that generates a four-by-four matrix of randomly chosen capital letters.
; When choosing the letters, there must be a 50% probability that the chosen letter is a vowel.
; Write a test program with a loop that calls your procedure five times and displays each matrix in
; the console window. Following is sample output for the first three matrices:

; D W A L
; S I V W
; U I O L
; L A I I

; K X S V
; N U U O
; O R Q O
; A U U T

; P O A Z
; A E A U
; G K A E
; I A G D

; ==================== THE PROGRAM HAS TO BE RUN WITH A DEBUGGER TO CREATE RANDOM ARRAYS ! BECAUSE OF HOW RANDOMRANGE WORKS. ====================

fillArray PROTO, charPointerArray:PTR BYTE, vowels:PTR BYTE, consonants:PTR BYTE
generateMatrix PROTO, mpArray:PTR BYTE

Rowsize = 4
.data
charArray BYTE 16 DUP (1),0
vowelsArray BYTE "AEIOUY",0
consonantsArray BYTE "BCDFGHJKLMNPQRSTVWXYZ",0
randomArray1 BYTE "FWYMLYXWSCFIBXDI",0
randomArray2 BYTE "SZRSZQJWAFCBCCKF",0
randomArray3 BYTE "PBSLVKLBQOLBDEBO",0
randomArray4 BYTE "EDZGLSHOSIZRZSFS",0
randomArray5 BYTE "QVPLLMCLUDWCKSQL",0
randomArray6 BYTE "RYXEORHEAOFXFKJM",0
randomArray7 BYTE "ZUHTZVCTPRSSHPGR",0
randomArray8 BYTE "PQZJSLRGHJKQPEGY",0
randomArray9 BYTE "RFPDKDZULSOIEGAK",0
randomArray10 BYTE "NDAHMLECPFQCUCMN",0

.code
main PROC
	
	; INVOKE fillArray, ADDR charArray, ADDR vowelsArray, ADDR consonantsArray ; RUN THIS WITH A DEBUGGER
	; INVOKE generateMatrix, ADDR charArray; RUN THIS WITH A DEBUGGER
		
	INVOKE generateMatrix, ADDR randomArray1
	INVOKE generateMatrix, ADDR randomArray2
	INVOKE generateMatrix, ADDR randomArray3
	INVOKE generateMatrix, ADDR randomArray4
	INVOKE generateMatrix, ADDR randomArray5
	INVOKE generateMatrix, ADDR randomArray6
	INVOKE generateMatrix, ADDR randomArray7
	INVOKE generateMatrix, ADDR randomArray8
	INVOKE generateMatrix, ADDR randomArray9
	INVOKE generateMatrix, ADDR randomArray10
	
	exit
main ENDP

fillArray PROC uses esi edi edx ecx eax,
	charPointerArray: PTR BYTE,
	vowels:PTR BYTE,
	consonants:PTR BYTE
	
	mov esi, charPointerArray
	mov edi, vowels
	mov edx, consonants

	invoke Str_length,esi
	mov ecx,eax
	generateRandomAndFillArray:
		cmp ecx,0
		je quitProc
		call Randomize
		mov eax,2
		call RandomRange
		cmp eax,1
		je chooseVowel
		jmp chooseconsonant

	chooseVowel:
		invoke Str_length, edi
		call RandomRange
		add edi,eax
		mov al,[edi]
		mov [esi], al
		inc esi
		loop generateRandomAndFillArray

	chooseconsonant:
		invoke Str_length, edx
		call RandomRange
		add edx,eax
		mov al, [edx]
		mov [esi],al
		inc esi
		loop generateRandomAndFillArray

	quitProc:
		ret
	ret
fillArray ENDP

generateMatrix PROC uses esi ecx eax edx,
	mpArray:PTR BYTE
	

	mov edx,0 ; edx will be the counter for matrix
	mov esi, mpArray
	INVOKE Str_length, esi
	mov ecx, eax
	L1:
		cmp BYTE PTR [esi], 00h
		je  quitProc
		mov al, [esi]
		call WriteChar
		mov al, ' '
		call WriteChar
		inc edx
		inc esi
		cmp edx,4
		je newLine
		jmp L1

	newLine:
		mov edx,0
		call Crlf
		jmp L1

	quitProc:
		call Crlf
		ret
generateMatrix ENDP

END main
