# Short Answers
## 1 
What is the purpose of the STRUCT directive.
Structures provide an easy to to cluster data and pass it to a procedure, rich structures make it less error-prone when passing arguments to a procedure.
## 2
Assume that the following structure has been defined:
RentalInvoice STRUCT
    invoiceNum BYTE 5 DUP(' ')
    dailyPrice WORD ?
    daysRented WORD ?
RentalInvoice ENDS

State whether or not each of the following declarations is valid:
a. rentals RentalInvoice <>
b. RentalInvoice rentals <>
c. march RentalInvoice <'12345',10,0>
d. RentalInvoice <,10,0>
e. current RentalInvoice <,15,0,0>

b. and e. is incorrect.

## 3
A macro cannot contain data definitions.
False

## 4
What is the purpose of the LOCAL directive?
With LOCAL directive we are able to declare a variable inside a label.

## 5 
Which directive displays a message on the console during the assembly step?
ECHO

## 6
Which directive marks the end of a conditional block of statements?
ENDIF

## 7
List all the relational operators that can be used in constant boolean expressions.
LT Less than
GT Greater than
EQ Equal to
NE Not equal to
LE Less than or equal to
GE Greater than or equal to

## 8
What is the purpose of the & operator in a macro definition?
The & operator resolves ambigous references to parameter names within a macro

```asm
mShowRegister MACRO regName
.data
tempstr BYTE " &regName=",0
```
`regName` in `tempstr` gets replaced with provided regName argument.

## 9
What is the purpose of the ! operator in a macro definition?
This operator forces the preporcessor to treat a predefined operator as an ordinary character.

## 10
What is the purpose of the % operator in a macro definition?
% expands text macros or converts constant expressions into their
text representations.

# Algorithm
## 1
```asm
STRUCT SampleStruct
	field1 WORD ?
	align DWORD
	field2 DWORD 20 DUP(?)
ENDS
```

## 2
```asm
INCLUDE Irvine32.inc

; Write a statement that retrieves the wHour field of a SYSTEMTIME structure.

SYSTEMTIME STRUCT
	wYear WORD ?
	wMonth WORD ?
	wDayOfWeek WORD ?
	wDay WORD ?
	wHour WORD ?
	wMinute WORD ?
	wSecond WORD ?
	wMilliseconds WORD ?
SYSTEMTIME ENDS
	
.data
sysTime SYSTEMTIME <>

.code
main PROC
	INVOKE GetLocalTime, ADDR sysTime

	movzx eax, sysTime.wHour
	call WriteDec

	call Crlf
	nop
	exit
main ENDP

end main
```

## 3
```asm
INCLUDE Irvine32.inc

; Using the following Triangle structure, declare a structure variable and initialize its vertices
; to (0,0), (5, 0), and (7,6):
; 
; Triangle STRUCT
; 	Vertex1 COORD <>
; 	Vertex2 COORD <>
; 	Vertex3 COORD <>
; Triangle ENDS	


Triangle STRUCT
	Vertex1 COORD <>
	Vertex2 COORD <>
	Vertex3 COORD <>
Triangle ENDS	

.data
vert1 Triangle <<0,0>,<5,0>,<7,6>>

.code
main PROC
	
	call Crlf
	nop
	exit
main ENDP

end main
```

## 4
```asm
INCLUDE Irvine32.inc

; Declare an array of Triangle structures. Write a loop that initializes Vertex1 of each triangle
; to random coordinates in the range (0...10, 0...10).

Triangle STRUCT
	Vertex1 COORD <>
	Vertex2 COORD <>
	Vertex3 COORD <>
Triangle ENDS	

.data
vert1 Triangle 20 DUP(<<0,0>,<0,0>,<0,0>>)

.code
main PROC
	mov ebx, sizeof Triangle
	mov ecx, lengthof vert1
	mov esi,offset vert1
	L1:
		mov eax,11
		call RandomRange
		mov (Triangle PTR [esi]).Vertex1.X,ax

		mov eax,11
		call RandomRange
		mov (Triangle PTR [esi]).Vertex1.Y,ax

		add esi,ebx
		loop L1

	call Crlf
	nop
	exit
main ENDP

end main
```

## 5
```asm
INCLUDE Irvine32.inc

;Write a macro named mPrintChar that displays a single character on the screen. It should
;have two parameters: this first specifies the character to be displayed and the second speci-
;fies how many times the character should be repeated. Here is a sample call:

; mPrintChar 'X',20

mPrintChar MACRO char:REQ, count:REQ
	push eax
	push ecx

	mov ecx,count
	L1:
		mov al,char
		call WriteChar
		loop L1

	call Crlf
	pop ecx
	pop eax
ENDM

.data

.code
main PROC
	mPrintChar 'X', 20

	nop
	exit
main ENDP

end main
```

## 6
```asm
INCLUDE Irvine32.inc

; Write a macro named mGenRandom that generates a random integer between 0 and n - 1.
; Let n be the only parameter

mGenRandom MACRO number:REQ
	push eax
	mov eax,number
	dec eax
	call RandomRange
	call WriteDec

	pop eax
ENDM

.code
main PROC
	mov ecx,10
	mGenRandom ecx

	nop
	exit
main ENDP

end main
```

## 7
```asm
INCLUDE Irvine32.inc

;Write a macro named mPromptInteger that displays a prompt and inputs an integer from
;the user. Pass it a string literal and the name of a doubleword variable. Sample call:

;.data
;minVal DWORD ?
;.code
;mPromptInteger "Enter the minimum value", minVal

mPromptInteger MACRO text, value
	LOCAL string
	.data
	string BYTE text,0
	.code
	push eax
	push edx

	mov edx, offset string
	call WriteString
	call ReadInt
	mov value,eax
	call Crlf

	pop edx
	pop eax
ENDM

.data
minVal DWORD ? 

.code
main PROC
	mPromptInteger "Enter a number to be displayed: ",minVal
	
	nop
	exit
main ENDP
end main
```

## 11
```asm
INCLUDE Irvine32.inc
INCLUDE Macros.inc

; Write a macro named mDumpMemx that receives a single parameter, the name of a variable.
; Your macro must call the mDumpMem macro from the book’s library, passing it the variable’s
; offset, number of units, and unit size. Demonstrate a call to the mDumpMemx macro.

mDumpMemx MACRO number:REQ
	mDumpMem OFFSET number, LENGTHOF number, TYPE number
ENDM

.data
someVal DWORD 123h

.code
main PROC
	
	mDumpMem OFFSET someVal, LENGTHOF someVal, TYPE someVal

	nop
	exit
main ENDP
end main
```

## 12
```asm
INCLUDE Irvine32.inc
INCLUDE Macros.inc

; Show an example of a macro parameter having a default argument initializer

mWrite MACRO text:=<"default">
	LOCAL string ;; local label
	.data
	string BYTE text,0 ;; define the string
	.code
	push edx
	mov edx,OFFSET string
	call WriteString
	call Crlf
	pop edx
ENDM



.code
main PROC
	mWrite "teST"
	mWrite
	nop
	exit
main ENDP

end main
```

## 13
```asm
INCLUDE Irvine32.inc
INCLUDE Macros.inc

; Write a short example that uses the IF, ELSE, and ENDIF directives.

isBiggerThan5 MACRO number
	LOCAL greater,lower
	.data
	greater BYTE "&number is greater than 5.",0
	lower BYTE "&number is lower than 5.",0
	.code
	push edx
	IF number GT 5
		mov edx, offset greater
		call WriteString
	ELSE
		mov edx, offset lower
		call WriteString
	ENDIF
	call Crlf
	pop edx
ENDM



.code
main PROC
	isBiggerThan5 7
	isBiggerThan5 3
	
		
	nop
	exit
main ENDP

end main
```

## 14
```asm
INCLUDE Irvine32.inc
INCLUDE Macros.inc

; Write a statement using the IF directive that checks the value of the constant macro parame-
; ter Z; if Z is less than zero, display a message during assembly indicating that Z is invalid.

validation MACRO number
	LOCAL lower, bigger
	.data
	lower BYTE "Z (&number) is lower than 0",0
	bigger BYTE "Z (&number) is bigger than 0",0
	push edx
	.code
	IF number LT 0
		mov edx, offset lower
		call WriteString
	ELSE
		mov edx, offset bigger
		call WriteString
	ENDIF

	call Crlf
	pop edx
ENDM

.code
main PROC
	validation 3
	validation -2
	validation 6
	validation -3
	validation 1
		
	nop
	exit
main ENDP

end main
```

## 15
```asm

```