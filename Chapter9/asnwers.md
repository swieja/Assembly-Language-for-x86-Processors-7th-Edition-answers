# Short Answers
## 1
Which Direction flag setting causes index registers to move backward through memory
when executing string primitives?
Direction flag must be set using STD
## 2
When a repeat prefix is used with STOSW, what value is added to or subtracted from the
index register?
STOSW is WORD = AX which is 2 bytes long, the index register (EDI) is decremented or incremented by 2 for each iteration
## 3
In what way is the CMPS instruction ambiguous
idk, I guess if esi/edi are not properly set to memory locations, it can cause unexpected behavior.

## 4
When the Direction flag is clear and SCASB has found a matching character, where does
EDI point?
It will point to the next character, so for example if we are looking for 'F' in string "ABDEFGH", edi will point to memory location that contains 'G'

## 5
When scanning an array for the first occurrence of a particular character, which repeat pre-
fix would be best
`repne scasb`, when the byte being compared matches the byte in the AL register, the ZF flag is set indicating the match was found.

## 6
What Direction flag setting is used in the Str_trim procedure from Section 9.3?
Direction flag doesn't seem to be set there, because the pointer to the last character is set in EDI

## 7
Why does the Str_trim procedure from Section 9.3 use the JNE instruction?
If the character is not the delimiter, we exit the loop, knowing that a null byte will be inserted at label L2

## 8 
What happens in the Str_ucase procedure from Section 9.3 if the target string contains a digit?
The program checks if the value is lower than 'a', digits are lower than 'a' so it will jump to label that increments the pointer

## 9 
If the Str_length procedure from Section 9.3 used SCASB, how would it calculate and
return the string length?
SCASB is useful when looking for a single value in a string or array, when scan is complete, it will store the index number of found character in DI register, we can use it to find null which is 00h and subtract that with 1, this would give us length.

## 10
If the Str_length procedure from Section 9.3 used SCASB, how would it calculate and
return the string length
SCASB is useful when looking for a single value in a string or array, when scan is complete, it will store the index number of found character in DI register, we can use it to find null which is 00h and subtract that with 1, this would give us length.

## 11
What is the maximum number of comparisons needed by the binary search algorithm when
an array contains 1,024 elements
10

## 12
In the FillArray procedure from the Binary Search example in Section 9.5, why must the
Direction flag be cleared by the CLD instruction?
We want to increment EDI so the flag must be cleared.

## 13
In the BinarySearch procedure from Section 9.5, why could the statement at label L2 be
removed without affecting the outcome?
The compare instruction in label2 is optional, becaues the same cmp was executed before jumping to L2

## 14
In the BinarySearch procedure from Section 9.5, how might the statement at label L4 be
eliminated?
change jmp L4 to jmp L1


# Algorithm

## 1. Show an example of a base-index operand in 32-bit mode.
[ebx+esi]
## 2. Show an example of a base-index-displacement operand in 32-bit mode.
array[ebx+esi]
## 3. Suppose a two-dimensional array of doublewords has three logical rows and four logical columns. Write an expression using ESI and EDI that addresses the third column in the second row. (Numbering for rows and columns starts at zero.) 
```asm
INCLUDE Irvine32.inc

.data
table DWORD 10h,20h,30h,40h
RowSize = ($ - table)
		DWORD 50h,60h,70h,80h
		DWORD 90h,0A0h,0B0h,0C0h

.code
main PROC
	mov edi,RowSize * 2; 2nd row 
	mov esi, 3 ; 3rd column
	; eax should point to in table 0C0h
	mov eax,table[edi + esi * TYPE table]
	
	exit
main ENDP


END main
```

## 4. Write instructions using CMPSW that compare two arrays of 16-bit values named sourcew and targetw. 

```asm
INCLUDE Irvine32.inc

; Write instructions using CMPSW that compare two arrays
; of 16-bit values named sourcew and targetw. 

.data
sourcew		WORD 9,3,5,6,1
targetw		WORD 1,2,4,6,4

.code
main PROC
	mov esi, offset sourcew
	mov edi, offset targetw

	cld
	mov ecx, lengthof sourcew
	repne cmpsw ; run until it finds the same indexes
	; after the loop 8 bytes should be added do edi and esi, because the same index was found at [esi + 6] which is sourcew[3]
	; after the loop esi will point to the next value in the array which is sourcew[4] = 1.


	exit
main ENDP


END main
```
## 5. Write instructions that use SCASW to scan for the 16-bit value 0100h in an array named wordArray, and copy the offset of the matching member into the EAX register.
```asm
INCLUDE Irvine32.inc

; Write instructions that use SCASW to scan for the 16-bit value 0100h in an array named wordArray,
; and copy the offset of the matching member into the EAX register.

.data
wordArray WORD 2000h,1000h, 0100h, 0020h
.code
main PROC
	mov edi, offset wordArray
	mov ax, 0100h
	mov ecx, lengthof wordArray

	cld
	repne scasw
	sub edi, type wordArray
	mov eax, edi
	nop
	jnz quit 

	quit:
		exit
main ENDP

END main
```
## 6. Write a sequence of instructions that use the Str_compare procedure to determine the larger of two input strings and write it to the console window.
```asm
INCLUDE Irvine32.inc

; Write a sequence of instructions that use the Str_compare procedure to 
; determine the larger of two input strings and write it to the console window.

.data
str1 BYTE "some super super super bigger stringA",0
str2 BYTE "some super super super bigger stringAA",0
equal BYTE "str 1 and str2 are equal.",0 

.code
main PROC
	nop
	check:
		INVOKE Str_compare, offset str1, offset str2
		JA isBigger
		JE isEqual
		JB isSmaller
		

	isSmaller:
		mov edx, offset str2 
		call WriteString
		jmp quitMain

	isEqual:
		mov edx, offset equal
		call WriteString
		jmp quitMain

	isBigger:
		mov edx, offset str1
		call WriteString
		jmp quitMain
		
	
	quitMain:
		nop
		exit
main ENDP

END main
```


## 7. Show how to call the Str_trim procedure and remove all trailing "@" characters from a string.
```asm
INCLUDE Irvine32.inc

; Show how to call the Str_trim procedure and remove
; all trailing "@" characters from a string.

.data
someString BYTE "Hello@@@@@@@@@",0
.code
main PROC
	
	INVOKE Str_trim, ADDR someString,'@'
	mov edx, offset someString

	call WriteString
	call Crlf

	nop
	exit
main ENDP

END main
```
## 8. Show how to modify the Str_ucase procedure from the Irvine32 library so it changes all characters to lower case.
Instead of ANDing chars with 11011111b, we can use ADD to add 32, to the character and conver the letter to lower case.
## 9. Create a 64-bit version of the Str_trim procedure.
```asm
ExitProcess 	proto
Str_length		proto
WriteString		proto
Crlf			proto


Str_trim64 PROTO

.data
someString BYTE "Hello,,,",0
char BYTE 02Ch
.code
main proc
	mov rcx, offset someString
	call Str_trim64

	mov rdx, offset someString
	call WriteString
	call Crlf

	nop
	call ExitProcess
main endp
PUBLIC main

Str_trim64 PROC USES rax rcx rdi	
	; to call Str_length we need rcx
	; rcx points to someString
	; it will return string length in rax
	call Str_length
	mov rdi,rcx
	cmp rax,0
	je L3
	mov rcx,rax
	dec rax
	add rdi,rax

	L1:
		mov al,[rdi]
		cmp al,char
		jne L2
		dec edi
		loop L1

	L2: mov BYTE PTR [rdi + 1],0
	L3: ret
	ret
Str_trim64 ENDP

end
```

## 10. Show an example of a base-index operand in 64-bit mode.
```asm
ExitProcess 	proto

.data
array DWORD 10000000h,20000000h,30000000h
.code
main proc
	mov rbx, offset array
	mov rsi,4
	mov eax,[rbx+rsi]

	mov rbx, offset array
	mov rsi,8
	mov eax,[rbx+rsi]

	mov rbx, offset array
	mov rsi,0
	mov eax,[rbx+rsi]


	nop
	call ExitProcess
main endp
PUBLIC main

end
```

## 11. Assuming that EBX contains a row index into a two-dimensional array of 32-bit integers named myArray and EDI contains the index of a column, write a single statement that moves the content of the given array element into the EAX register.
```asm
INCLUDE Irvine32.inc

; Assuming that EBX contains a row index into a two-dimensional array of 32-bit integers
; named myArray and EDI contains the index of a column, write a single statement that
; moves the content of the given array element into the EAX register.

.data
tableD	DWORD 10h, 20h, 30h, 40h, 50h
Rowsize = ($ - tableD)
			DWORD 60h, 70h, 80h, 90h, 0A0h


.code
main PROC
	mov ebx, offset tableD
	add ebx, Rowsize * 1
	mov edi, 2
	mov eax,[ebx+edi * 4]
	
	;eax will be 80h
	nop
	exit
main ENDP

END main
```

## 12. Assuming that RBX contains a row index into a two-dimensional array of 64-bit integers named myArray and RDI contains the index of a column, write a single statement that moves the content of the given array element into the RAX register.
```asm
ExitProcess 	proto

; Assuming that RBX contains a row index into a two-dimensional array of 64-bit integers
; named myArray and RDI contains the index of a column, write a single statement that
; moves the content of the given array element into the RAX register.

.data
tableD	QWORD 10h, 20h, 30h, 40h, 50h
Rowsize = ($ - tableD)
			QWORD 60h, 70h, 80h, 90h, 0A0h
.code
main proc
	mov rbx, offset tableD
	add rbx, Rowsize * 1 
	mov rdi, 2 
	mov rax,[rbx + rdi * 8]
	; rax will be 80h

		
	nop
	call ExitProcess
main endp
PUBLIC main

end
```