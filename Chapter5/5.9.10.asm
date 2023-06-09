INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD

; Write a procedure that produces N values in the Fibonacci number series and stores them in an array of doubleword.
; Input parameters should be a pointer to an array of doubleword, a counter of the number of values to generate.
; Write a test program that calls your procedure, passing N = 47. The first value in the array will be 1, and the last value 
; will be 2,971,215,073. Use the visual studio debugger to open and inspect the array contents.

; Here I use WriteInt32 to display values of  array1 which are the results
; of fibonacci procedure, the last value is 2971215073 but the WriteInt
; only displays signed integers so the value displayed in the console will be 
; -1323752223

.data

array1 DWORD 47 DUP(?) 
newline BYTE 0Ah, 0
result DWORD 0
prompt1 BYTE "Array offset fibonacci numbers: ",0

.code
main PROC
	mov esi,OFFSET array1
	mov ecx, LENGTHOF array1 -1 

	call fibonacci

	mov esi,OFFSET array1
	mov ecx, LENGTHOF array1 + 1

	mov edx, OFFSET prompt1
	call WriteString
	L2:
		mov eax,[esi]
		call WriteInt
		mov edx, OFFSET newline
		call WriteString ; last value is 2971215073 but signed representation will be displayed because WriteInt uses signed eax
		add esi,TYPE array1 
		loop L2

		nop
	call WaitMsg
	INVOKE ExitProcess,0
main ENDP

fibonacci PROC
	mov eax,0 
	mov ebx,1

	mov [esi],eax
	add esi,TYPE array1

	mov [esi],ebx
	add esi,TYPE array1

	L1:
	  mov eax, [esi-8]                
	  mov ebx, [esi-4]                
	  mov edx, eax
	  add edx, ebx                     
	  mov [esi], edx                   
	  add esi, TYPE array1
	  loop L1
	
	ret
fibonacci ENDP

END main
