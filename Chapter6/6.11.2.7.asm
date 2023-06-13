INCLUDE Irvine32.inc

; Write a program that randomly chooses among three different colors for displaying text on
; the screen. Use a loop to display 20 lines of text, each with a randomly chosen color. The
; probabilities for each color are to be as follows: white  30%, blue  10%, green  60%.
; Suggestion: Generate a random integer between 0 and 9. If the resulting integer falls in the
; range 0 to 2 (inclusive), choose white. If the integer equals 3, choose blue. If the integer falls in
; the range 4 to 9 (inclusive), choose green. Test your program by running it ten times, each time
; observing whether the distribution of line colors appears to match the required probabilities.
; (The Irvine32 library is required for this solution program.)


.data
sometext BYTE "Today was a sunny day.",0
randomNumber DWORD ? 

.code
main PROC
	mov ecx,20d

L1:
	mov eax,9
	call RandomRange
	mov randomNumber, eax
	call checkRange
	loop L1

main ENDP

checkRange PROC
	mov eax, randomNumber	
	cmp eax,2
	jbe L_White
	cmp eax,3
	je L_Blue
	cmp eax,4
	jae L_Green

L_White:
	call writeWhite
	jmp goToMain
L_Blue:
	call writeBlue
	jmp goToMain
L_Green:
	call writeGreen
	jmp goToMain

goToMain:
	ret

	ret
checkRange ENDP

writeWhite PROC
	mov eax, white
	call SetTextColor
	mov edx, offset sometext
	call WriteString
	call Crlf
	ret
writeWhite ENDP
	
writeBlue PROC
	mov eax, blue
	call SetTextColor
	mov edx, offset sometext
	call WriteString
	call Crlf
	ret
writeBlue ENDP

writeGreen PROC
	mov eax, green
	call SetTextColor
	mov edx, offset sometext
	call WriteString
	call Crlf
	ret
writeGreen ENDP



END main