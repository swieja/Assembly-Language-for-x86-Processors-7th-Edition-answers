.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

; Write a program that defines symbolic constants for all seven
; days of the week. Create an array variable that uses 
; symbols as initializers

.data
myArray DWORD 7 dup(0)

monday EQU 0
tuesday EQU 1
wednesday EQU 2
thursday EQU 3
friday EQU 4
saturday EQU 5
sunday EQU 6

.code
main PROC

	mov eax, monday
	mov myArray[0], monday
	mov myArray[1], tuesday
	mov myArray[2], wednesday
	mov myArray[3], thursday
	mov myArray[4], friday
	mov myArray[5], saturday
	mov myArray[6], sunday



	INVOKE ExitProcess, myArray[6]

main ENDP
END main